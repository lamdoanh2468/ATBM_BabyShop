package vn.edu.nlu.fit.be.service;

import vn.edu.nlu.fit.be.dao.OrderSignDao;
import vn.edu.nlu.fit.be.dao.OrderSignatureDao;
import vn.edu.nlu.fit.be.dao.OrdersDao;
import vn.edu.nlu.fit.be.dao.CertificateDao;
import vn.edu.nlu.fit.be.dao.SignatureAuditDao;
import vn.edu.nlu.fit.be.dto.SignedOrderReq;
import vn.edu.nlu.fit.be.model.*;
import vn.edu.nlu.fit.be.dto.SignVerifyResult;

import java.util.List;
import java.util.Objects;
import java.util.Optional;

public class AdminSignService {

    private final OrderSignDao orderSignDao = new OrderSignDao();
    private final OrdersDao ordersDao = new OrdersDao();
    private final CertificateDao certificateDao = new CertificateDao();
    private final SignatureAuditDao auditDao = new SignatureAuditDao();
    private final OrderSignatureDao signatureDao = new OrderSignatureDao();
    private final SignVerifyService verifyService = new SignVerifyService();

    public OrderSign getOrderSignByOrderId(int orderId) {
        return orderSignDao.findByOrderId(orderId);
    }

    public Optional<UserCertificate> getCertificateByOrderId(int orderId) {
        OrderSign s = orderSignDao.findByOrderId(orderId);
        if (s == null) return null;
        return certificateDao.findActiveByAccountId((int) s.getAccountId());
    }

    public List<SignatureAuditLog> getVerifyLogs(int orderId) {
        return auditDao.findByOrderId(orderId);
    }

    public List<Order> getInvalidSignOrders() {
        List<OrderSign> signs = orderSignDao.findByStatus("FAIL_INVALID_SIG");
        return mapSignsToOrders(signs);
    }

    public List<Order> getWaitingSignOrders() {
        List<OrderSign> signs = orderSignDao.findByStatus("WAITING_SIGNATURE");
        return mapSignsToOrders(signs);
    }

    public List<Order> getTamperedOrders() {
        List<OrderSign> signs = orderSignDao.findByStatus("FAIL_HASH_MISMATCH");
        return mapSignsToOrders(signs);
    }

    public List<Certificate> getRecentRevokedCerts() {
        return certificateDao.findRecentRevoked(20);
    }

    public void reverifyOrder(int orderId) throws Exception {
        // Admin-triggered reverify: find latest uploaded signature for the order and re-run verify
        OrderSignature lastSig = signatureDao.findLatestByOrderId(orderId);
        if (lastSig == null) return;

        SignedOrderReq req = new SignedOrderReq();
        req.setOrderId((int) lastSig.getOrderId());
        req.setCertificateId((int) lastSig.getCertificateId());
        req.setOrderHash(lastSig.getOrderHash());
        req.setSignatureValue(lastSig.getSignatureValue());
        req.setSignatureAlgorithm(lastSig.getSignatureAlgorithm());

        SignVerifyResult result = verifyService.verifySignedOrder(req, (int) lastSig.getAccountId());

        // write an audit log for admin action
        SignatureAuditLog log = new SignatureAuditLog();
        log.setOrderId((long) orderId);
        log.setAccountId(lastSig.getAccountId());
        log.setCertificateId(lastSig.getCertificateId());
        log.setAction("ADMIN_REVERIFY");
        log.setResult(result.isSuccess() ? "VERIFIED" : "FAILED");
        log.setMessage(result.getMessage());
        auditDao.insert(log);
    }

    public void revokeCert(int certificateId, String reason) {
        certificateDao.revokeById(certificateId, reason);
    }

    private List<Order> mapSignsToOrders(List<OrderSign> signs) {
        return signs.stream().map(sign ->
                ordersDao.getOrderById((int) sign.getOrderId())).filter(Objects::nonNull).toList();
    }
}
