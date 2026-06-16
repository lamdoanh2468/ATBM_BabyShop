package vn.edu.nlu.fit.be.dto;

public class CheckoutSignResult {

    private int orderId;
    private String orderHash;
    private String signingUrl;
    private String signToolUrl;
    private String privateKeyUrl;
    private boolean hasActiveCert;

    public CheckoutSignResult() {
    }

    public CheckoutSignResult(int orderId,
                              String orderHash,
                              String signingUrl,
                              String signToolUrl,
                              String privateKeyUrl,
                              boolean hasActiveCert) {
        this.orderId = orderId;
        this.orderHash = orderHash;
        this.signingUrl = signingUrl;
        this.signToolUrl = signToolUrl;
        this.privateKeyUrl = privateKeyUrl;
        this.hasActiveCert = hasActiveCert;
    }

    public boolean isHasActiveCert() {
        return hasActiveCert;
    }

    public void setHasActiveCert(boolean hasActiveCert) {
        this.hasActiveCert = hasActiveCert;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getOrderHash() {
        return orderHash;
    }

    public void setOrderHash(String orderHash) {
        this.orderHash = orderHash;
    }

    public String getSigningUrl() {
        return signingUrl;
    }

    public void setSigningUrl(String signingUrl) {
        this.signingUrl = signingUrl;
    }

    public String getSignToolUrl() {
        return signToolUrl;
    }

    public void setSignToolUrl(String signToolUrl) {
        this.signToolUrl = signToolUrl;
    }

    public String getPrivateKeyUrl() {
        return privateKeyUrl;
    }

    public void setPrivateKeyUrl(String privateKeyUrl) {
        this.privateKeyUrl = privateKeyUrl;
    }

    public boolean hasPrivateKeyUrl() {
        return privateKeyUrl != null && !privateKeyUrl.isBlank();
    }
}
