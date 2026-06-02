package vn.edu.nlu.fit.be.service;

import vn.edu.nlu.fit.be.model.Order;

import java.security.cert.Certificate;

public class AdminSignService {
    public Order getOrderSignByOrderId(int orderId) {
    }

    public Certificate getCertificateByOrderId(int orderId) {
    }

    public String getVerifyLogs(int orderId) {
    }

    public Order getInvalidSignOrders() {
    }

    public Order getWaitingSignOrders() {
    }

    public Order getTamperedOrders() {
    }

    public Certificate getRecentRevokedCerts() {
    }

    public void reverifyOrder(int orderId) {
    }

    public void revokeCert(int certificateId, String reason) {
    }
}
