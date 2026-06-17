package vn.edu.nlu.fit.be.service;

import vn.edu.nlu.fit.be.dao.OrderSignDao;
import vn.edu.nlu.fit.be.dto.OrderToSignRes;
import vn.edu.nlu.fit.be.model.*;

import java.security.MessageDigest;
import java.util.Comparator;
import java.util.Formatter;
import java.util.List;

public class OrderSigningService {

    private static final String HASH_ALGORITHM = "SHA-256";
    private final OrdersService ordersService = new OrdersService();
    private final CertificateService certificateService = new CertificateService();
    private final OrderSignDao orderSignDao = new OrderSignDao();


    public OrderToSignRes createSnapshotAndReturnPayload(int orderId, int accountId) {
        Order order = getOwnedOrder(orderId, accountId);
        List<OrderDetail> orderDetails = ordersService.getOrderDetailsByOrderId(orderId);

        String snapshot = buildSnapshot(order, orderDetails);
        String hash = sha256Hex(snapshot);

        OrderSign sign = new OrderSign();
        sign.setOrderId(orderId);
        sign.setAccountId(accountId);
        sign.setSnapshotJson(snapshot);
        sign.setOrderHash(hash);
        sign.setHashAlgorithm(HASH_ALGORITHM);
        sign.setStatus(OrderStatus.WAITING_SIGNATURE.name());

        orderSignDao.insert(sign);

        return getOrderToSign(orderId, accountId);
    }


    public String calculateCurrentOrderHash(int orderId, int accountId, String storedSnapshot) {
        String currentSnapshot = buildCurrentSnapshot(orderId, accountId, storedSnapshot);
        return sha256Hex(currentSnapshot);
    }

    private String buildCurrentSnapshot(int orderId, int accountId, String storedSnapshot) {
        Order order = getOwnedOrder(orderId, accountId);
        List<OrderDetail> orderDetails = ordersService.getOrderDetailsByOrderId(orderId);

        if (isLegacySnapshot(storedSnapshot)) {
            return buildLegacySnapshot(order, orderDetails);
        }

        return buildSnapshot(order, orderDetails);
    }

    private boolean isLegacySnapshot(String storedSnapshot) {
        return storedSnapshot != null && storedSnapshot.contains("details=[\t[");
    }

    private String buildLegacySnapshot(Order order, List<OrderDetail> orderDetails) {
        StringBuilder sb = new StringBuilder();

        sb.append("orderId=").append(order.getOrderId()).append(";");
        sb.append("accountId=").append(order.getAccountId()).append(";");
        sb.append("voucherId=").append(order.getVoucherId()).append(";");
        sb.append("total=").append(order.getTotalAmount()).append(";");
        sb.append("paymentMethod=").append(order.getPaymentMethod()).append(";");
        sb.append("address=").append(nullToEmpty(order.getDeliveryAddress())).append(";");
        sb.append("details=[").append("\t");

        for (OrderDetail detail : orderDetails) {
            sb.append("[").append("\t");
            sb.append("productId=").append(detail.getProductId()).append(";");
            sb.append("quantity=").append(detail.getQuantity()).append(";");
            sb.append("price=").append(detail.getUnitPrice()).append(";");
            sb.append("]").append("\t");
        }

        sb.append("]");
        return sb.toString();
    }

    public OrderToSignRes getOrderToSign(int orderId, int accountId) {
        getOwnedOrder(orderId, accountId);

        OrderSign sign = orderSignDao.findByOrderId(orderId);
        if (sign == null) {
            return null;
        }

        Certificate cert = certificateService.getActiveCertByAccountId(accountId).orElse(null);

        OrderToSignRes signRes = new OrderToSignRes();
        signRes.setOrderId(orderId);
        signRes.setAccountId(accountId);
        if (cert != null) {
            signRes.setCertificateId(cert.getCertificateId());
        }
        signRes.setOrderHash(sign.getOrderHash());
        signRes.setSnapshotJson(sign.getSnapshotJson());
        signRes.setHashAlgorithm(sign.getHashAlgorithm());
        return signRes;
    }

    private Order getOwnedOrder(int orderId, int accountId) {
        Order order = ordersService.getOrderById(orderId);
        if (order == null) {
            throw new IllegalArgumentException("Order not found");
        }
        if (order.getAccountId() != accountId) {
            throw new IllegalArgumentException("Not your order");
        }
        return order;
    }

    private String buildSnapshot(Order order, List<OrderDetail> orderDetails) {
        StringBuilder sb = new StringBuilder();
        sb.append("orderId=").append(order.getOrderId()).append(";");
        sb.append("accountId=").append(order.getAccountId()).append(";");
        sb.append("voucherId=").append(order.getVoucherId()).append(";");
        sb.append("total=").append(order.getTotalAmount()).append(";");
        sb.append("paymentMethod=").append(order.getPaymentMethod()).append(";");
        sb.append("address=").append(nullToEmpty(order.getDeliveryAddress())).append(";");
        sb.append("details=[");

        orderDetails.stream().sorted(Comparator.comparingInt(OrderDetail::getProductId)).forEach(detail -> sb.append("{").append("productId=").append(detail.getProductId()).append(";").append("quantity=").append(detail.getQuantity()).append(";").append("price=").append(detail.getUnitPrice()).append(";").append("}"));

        sb.append("]");
        return sb.toString();
    }

    private String nullToEmpty(String value) {
        return value == null ? "" : value.trim();
    }

    private String sha256Hex(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance(HASH_ALGORITHM);
            byte[] digest = md.digest(input.getBytes(java.nio.charset.StandardCharsets.UTF_8));
            try (Formatter formatter = new Formatter()) {
                for (byte b : digest) {
                    formatter.format("%02x", b);
                }
                return formatter.toString();
            }
        } catch (Exception e) {
            throw new RuntimeException("Cannot hash order snapshot", e);
        }
    }

    // DEBUG ORDER COMPARISON
    public String buildCurrentSnapshotForDebug(int orderId, int accountId, String storedSnapshot) {
        return buildCurrentSnapshot(orderId, accountId, storedSnapshot);

    }
}
