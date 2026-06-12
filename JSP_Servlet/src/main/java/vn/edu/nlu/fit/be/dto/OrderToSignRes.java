package vn.edu.nlu.fit.be.dto;

public class OrderToSignRes {
	private int orderId;
	private int accountId;
	private int certificateId;
	private String orderHash;
	private String snapshotJson;
	private String hashAlgorithm = "SHA-256";

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public int getAccountId() {
		return accountId;
	}
	public int getCertificateId() {
		return certificateId;
	}
	public void setAccountId(int accountId) {
		this.accountId = accountId;
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

	public String getSnapshotJson() {
		return snapshotJson;
	}

	public void setSnapshotJson(String snapshotJson) {
		this.snapshotJson = snapshotJson;
	}

	public String getHashAlgorithm() {
		return hashAlgorithm;
	}

	public void setHashAlgorithm(String hashAlgorithm) {
		this.hashAlgorithm = hashAlgorithm;
	}
}
