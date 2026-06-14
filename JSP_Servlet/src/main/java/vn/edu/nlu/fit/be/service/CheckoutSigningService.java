package vn.edu.nlu.fit.be.service;

import java.util.List;

import vn.edu.nlu.fit.be.dto.CheckoutSignResult;
import vn.edu.nlu.fit.be.dto.OrderToSignRes;
import vn.edu.nlu.fit.be.model.Account;
import vn.edu.nlu.fit.be.model.Cart;
import vn.edu.nlu.fit.be.model.CartItem.CartItem;
import vn.edu.nlu.fit.be.model.PaymentMethod;

public class CheckoutSigningService {

    private static final String ORDER_JSON_URL_PREFIX = "/order-sign/order-json?orderId=";
    private static final String SIGN_TOOL_URL = "/signing-tool/download";
    private static final String PRIVATE_KEY_URL = "/security-key/download-private-key";

    private final OrdersService ordersService = new OrdersService();
    private final StockProductService stockProductService = new StockProductService();
    private final CertificateService certificateService = new CertificateService();
    private final OrderSigningService orderSigningService = new OrderSigningService();

    public CheckoutSignResult checkoutAndPrepareSigning(Account account,
                                                         Cart cart,
                                                         String deliveryAddress,
                                                         PaymentMethod paymentMethod,
                                                         Integer voucherId,
                                                         int finalPrice) throws Exception {
        validateInput(account, cart, deliveryAddress);
        ensureStockAvailable(cart);

        certificateService.ensureActiveCert(account.getAccountId());
        boolean hasPrivateKeyForDownload = certificateService.hasPendingPrivateKey(account.getAccountId());

        int orderId = ordersService.createOrderFromCart(
                account,
                cart,
                deliveryAddress,
                paymentMethod,
                voucherId,
                finalPrice
        );

        decreaseStock(cart);

        OrderToSignRes orderToSign = orderSigningService.createSnapshotAndReturnPayload(
                orderId,
                account.getAccountId()
        );

        return new CheckoutSignResult(
                orderId,
                orderToSign.getOrderHash(),
                ORDER_JSON_URL_PREFIX + orderId,
                SIGN_TOOL_URL,
                hasPrivateKeyForDownload ? PRIVATE_KEY_URL : null
        );
    }

    private void validateInput(Account account, Cart cart, String deliveryAddress) {
        if (account == null) {
            throw new IllegalArgumentException("Account is null");
        }
        if (cart == null || cart.getTotalQuantity() == 0) {
            throw new IllegalArgumentException("Giỏ hàng đang trống");
        }
        if (deliveryAddress == null || deliveryAddress.trim().isEmpty()) {
            throw new IllegalArgumentException("Vui lòng nhập địa chỉ giao hàng");
        }
    }

    private void ensureStockAvailable(Cart cart) {
        if (stockProductService.checkAvailable(cart)) {
            return;
        }

        List<String> outOfStockProducts = stockProductService.getOutOfStockProducts(cart);
        throw new IllegalStateException("Không đủ số lượng tồn kho cho: " + String.join(", ", outOfStockProducts));
    }

    private void decreaseStock(Cart cart) {
        for (CartItem item : cart.getItems()) {
            stockProductService.updateStockProduct(
                    item.getProduct().getProductId(),
                    item.getQuantity()
            );
        }
    }
}
