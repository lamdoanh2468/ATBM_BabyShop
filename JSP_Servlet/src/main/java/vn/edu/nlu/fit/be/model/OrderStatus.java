package vn.edu.nlu.fit.be.model;

public enum OrderStatus {
    PENDING("Pending"),
    WAITING_SIGNATURE("WAITING_SIGNATURE"),
    CERTIFICATE_INVALID("CERTIFICATE_INVALID"),
    SIGNATURE_INVALID("SIGNATURE_INVALID"),
    TAMPERED("TAMPERED"),
    VERIFIED("VERIFIED"),
    DONE("Done"),
    CANCELLED("Cancelled");

    private final String dbValue;

    OrderStatus(String dbValue) {
        this.dbValue = dbValue;
    }

    public String getDbValue() {
        return dbValue;
    }

    public static OrderStatus fromDbValue(String value) {
        if (value == null || value.isBlank()) {
            return PENDING;
        }

        String normalized = value.trim();
        for (OrderStatus status : values()) {
            if (status.name().equalsIgnoreCase(normalized)
                    || status.dbValue.equalsIgnoreCase(normalized)) {
                return status;
            }
        }

        throw new IllegalArgumentException("Unknown order status: " + value);
    }
}
