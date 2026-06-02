package vn.edu.nlu.fit.be.model;

public enum OrderStatus {
    PENDING,
    WAITING_SIGNATURE,
    CERTIFICATE_INVALID,
    SIGNATURE_INVALID,
    TAMPERED,
    VERIFIED,
    DONE,
    CANCELLED
}
