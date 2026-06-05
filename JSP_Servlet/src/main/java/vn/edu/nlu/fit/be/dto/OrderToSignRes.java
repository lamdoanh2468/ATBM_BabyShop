package vn.edu.nlu.fit.be.dto;

public class OrderToSignRes {
	private int orderId;
	private String orderHash;
	private String snapshotJson;
	private String hashAlgorithm = "SHA-256";

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
