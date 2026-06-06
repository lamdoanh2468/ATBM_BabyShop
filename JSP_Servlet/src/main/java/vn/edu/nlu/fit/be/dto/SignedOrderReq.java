package vn.edu.nlu.fit.be.dto;

public class SignedOrderReq {
	private int orderId;
	private int certificateId;
	private String orderHash;
	private String signatureValue; // base64
	private String signatureAlgorithm;

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public int getCertificateId() {
		return certificateId;
	}
	public String getOrderHash() {
		return orderHash;
	}

	public void setCertificateId(int certificateId) {
		this.certificateId = certificateId;
	}
	public void setOrderHash(String orderHash) {
		this.orderHash = orderHash;
	}

	public String getSignatureValue() {
		return signatureValue;
	}

	public void setSignatureValue(String signatureValue) {
		this.signatureValue = signatureValue;
	}

	public String getSignatureAlgorithm() {
		return signatureAlgorithm;
	}

	public void setSignatureAlgorithm(String signatureAlgorithm) {
		this.signatureAlgorithm = signatureAlgorithm;
	}
}
