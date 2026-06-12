<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Admin - Chu ky don hang</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin_style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
</head>
<body>
<div class="dashboard">
    <aside class="sidebar">
        <nav class="menu">
            <a href="${pageContext.request.contextPath}/admin/overview"><i class="fa-solid fa-house"></i><span>Dashboard</span></a>
            <a href="${pageContext.request.contextPath}/admin/accounts"><i class="fa-solid fa-user"></i><span>Tai khoan</span></a>
            <a href="${pageContext.request.contextPath}/admin/orders"><i class="fa-solid fa-box"></i><span>Don hang</span></a>
            <a href="${pageContext.request.contextPath}/admin-sign" class="active"><i class="fa-solid fa-file-signature"></i><span>Chu ky so</span></a>
            <a href="${pageContext.request.contextPath}/admin/products"><i class="fa-solid fa-cubes"></i><span>San pham</span></a>
            <a href="${pageContext.request.contextPath}/admin/settings"><i class="fa-solid fa-gear"></i><span>Cai dat</span></a>
        </nav>
    </aside>

    <main class="main">
        <div class="product-form-shell">
            <div class="product-form-hero">
                <div class="product-form-copy">
                    <span class="product-form-eyebrow">Order signatures</span>
                    <h2>Quan ly chu ky don hang</h2>
                    <p>Theo doi don cho ky, don loi chu ky, don nghi bi thay doi va certificate bi thu hoi.</p>
                </div>
            </div>

            <section class="product-form-card">
                <h3>Don hang dang cho ky</h3>
                <table class="admin-table">
                    <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Account ID</th>
                        <th>Trang thai</th>
                        <th>Thao tac</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="order" items="${waitingOrders}">
                        <tr>
                            <td>#${order.orderId}</td>
                            <td>${order.accountId}</td>
                            <td>${order.statusOrder}</td>
                            <td><a href="${pageContext.request.contextPath}/admin-sign/detail?orderId=${order.orderId}">Chi tiet</a></td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty waitingOrders}">
                        <tr><td colspan="4">Khong co don hang dang cho ky.</td></tr>
                    </c:if>
                    </tbody>
                </table>
            </section>

            <section class="product-form-card">
                <h3>Don hang loi chu ky</h3>
                <table class="admin-table">
                    <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Account ID</th>
                        <th>Trang thai</th>
                        <th>Thao tac</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="order" items="${invalidOrders}">
                        <tr>
                            <td>#${order.orderId}</td>
                            <td>${order.accountId}</td>
                            <td>${order.statusOrder}</td>
                            <td><a href="${pageContext.request.contextPath}/admin-sign/detail?orderId=${order.orderId}">Chi tiet</a></td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty invalidOrders}">
                        <tr><td colspan="4">Khong co don hang loi chu ky.</td></tr>
                    </c:if>
                    </tbody>
                </table>
            </section>

            <section class="product-form-card">
                <h3>Certificate bi thu hoi gan day</h3>
                <table class="admin-table">
                    <thead>
                    <tr>
                        <th>Certificate ID</th>
                        <th>Account ID</th>
                        <th>Ly do</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="cert" items="${revokedCertificates}">
                        <tr>
                            <td>#${cert.certificateId}</td>
                            <td>${cert.accountId}</td>
                            <td>${cert.revokeReason}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty revokedCertificates}">
                        <tr><td colspan="3">Khong co certificate bi thu hoi.</td></tr>
                    </c:if>
                    </tbody>
                </table>
            </section>
        </div>
    </main>
</div>
</body>
</html>
