package vn.edu.nlu.fit.be.service;

import vn.edu.nlu.fit.be.dao.OrderSignDao;
import vn.edu.nlu.fit.be.dto.OrderToSignRes;
import vn.edu.nlu.fit.be.dto.SignPackageRes;
import vn.edu.nlu.fit.be.model.Order;
import vn.edu.nlu.fit.be.model.OrderDetail;
import vn.edu.nlu.fit.be.model.OrderSign;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.security.MessageDigest;
import java.util.Formatter;
import java.util.List;

public class OrderSigningService {

    private final OrdersService ordersService = new OrdersService();
    private final OrderSignDao orderSignDao = new OrderSignDao();
    private final Path privateKeyDir = Path.of("JSP_Servlet", "data", "private_keys");

    public void createOrderSignSnapshot(int orderId, int accountId) {
        Order o = ordersService.getOrderById(orderId);
        if (o == null) throw new IllegalArgumentException("Order not found");
        if (o.getAccountId() != accountId)
            throw new IllegalArgumentException("Not your order");
        List<OrderDetail> ods = ordersService.getOrderDetailsByOrderId(orderId);

        // build deterministic snapshot string
        StringBuilder sb = new StringBuilder();
        sb.append("orderId=").append(o.getOrderId()).append(";");
        sb.append("accountId=").append(o.getAccountId()).append(";");
        sb.append("total=").append(o.getTotalAmount()).append(";");
        sb.append("address=").append(o.getDeliveryAddress()).append(";");
        sb.append("details=["+"\t");
        for (OrderDetail od : ods) {
            sb.append("[\t");
            sb.append("productId=").append(od.getProductId()).append(";");
            sb.append("quantity=").append(od.getQuantity()).append(";");
            sb.append("price=").append(od.getUnitPrice()).append(";");
            sb.append("]\t");
        }
        sb.append("]");

        String snapshot = sb.toString();
        String hash = sha256Hex(snapshot);

        OrderSign sign = new OrderSign();
        sign.setOrderId(orderId);
        sign.setAccountId(accountId);
        sign.setSnapshotJson(snapshot);
        sign.setOrderHash(hash);
        sign.setHashAlgorithm("SHA-256");
        sign.setStatus("WAITING_SIGNATURE");

        orderSignDao.insert(sign);
    }

    public SignPackageRes getSigningPackage(int orderId, int accountId) {
        SignPackageRes res = new SignPackageRes();
        res.setOrderId(orderId);
        res.setSigningUrl("/sign/download?orderId=" + orderId);
        res.setPrivateKeyUrl("/sign/private?orderId=" + orderId);
        return res;
    }

    public OrderToSignRes getOrderToSign(int orderId, int accountId) {
        OrderSign sign = orderSignDao.findByOrderId(orderId);
        if (sign == null) return null;
        OrderToSignRes signRes = new OrderToSignRes();
        signRes.setOrderId(orderId);
        signRes.setOrderHash(sign.getOrderHash());
        signRes.setSnapshotJson(sign.getSnapshotJson());
        signRes.setHashAlgorithm(sign.getHashAlgorithm());
        return signRes;
    }

    public String consumePrivateKeyPem(int orderId, int accountId) {
        Order order = ordersService.getOrderById(orderId);

        if (order == null) {
            throw new IllegalArgumentException("Order not found");
        }
        if (order.getAccountId() != accountId) {
            throw new IllegalArgumentException("Not your order");
        }

        Path pemPath = privateKeyDir.resolve("account_" + accountId + "_private.pem");
        try {
            if (!Files.exists(pemPath)) {
                return null;
            }
            String pem = Files.readString(pemPath);
            Files.delete(pemPath);
            return pem;
        } catch (IOException e) {
            throw new RuntimeException("Cannot consume private key", e);
        }
    }

    public byte[] loadSigningTool() {
        // Not implemented - return empty
        return new byte[0];
    }

    private String sha256Hex(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] digest = md.digest(input.getBytes(java.nio.charset.StandardCharsets.UTF_8));
            try (Formatter f = new Formatter()) {
                for (byte b : digest) f.format("%02x", b);
                return f.toString();
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
