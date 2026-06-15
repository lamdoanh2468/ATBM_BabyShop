package vn.edu.nlu.fit.be.dto;

public class SignPackageRes {
	private int orderId;
	private String signingUrl;
	private String privateKeyUrl;

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public String getSigningUrl() {
		return signingUrl;
	}

	public void setSigningUrl(String signingUrl) {
		this.signingUrl = signingUrl;
	}

	public String getPrivateKeyUrl() {
		return privateKeyUrl;
	}

	public void setPrivateKeyUrl(String privateKeyUrl) {
		this.privateKeyUrl = privateKeyUrl;
	}
}
