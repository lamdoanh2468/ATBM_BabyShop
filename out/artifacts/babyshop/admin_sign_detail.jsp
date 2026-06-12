<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Admin - Chi tiet chu ky</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin_style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
</head>
<body>
<div class="dashboard">
    <aside class="sidebar">
        <nav class="menu">
            <a href="${pageContext.request.contextPath}/admin/overview"><i class="fa-solid fa-house"></i><span>Dashboard</span></a>
            <a href="${pageContext.request.contextPath}/admin/orders"><i class="fa-solid fa-box"></i><span>Don hang</span></a>
            <a href="${pageContext.request.contextPath}/admin-sign" class="active"><i class="fa-solid fa-file-signature"></i><span>Chu ky so</span></a>
        </nav>
    </aside>

    <main class="main">
        <div class="product-form-shell">
            <div class="product-form-hero">
                <div class="product-form-copy">
                    <span class="product-form-eyebrow">Signature detail</span>
                    <h2>Don hang #${order.orderId}</h2>
                    <p>Kiem tra snapshot, hash, certificate va lich su verify cua don hang.</p>
                </div>
                <a href="${pageContext.request.contextPath}/admin-sign" class="product-back-link">
                    <i class="fa-solid fa-arrow-left"></i>
                    <span>Quay lai</span>
                </a>
            </div>

            <section class="product-form-card">
                <h3>Thong tin don hang</h3>
                <div class="product-preview-meta">
                    <div><span>Order ID</span><strong>#${order.orderId}</strong></div>
                    <div><span>Account ID</span><strong>${order.accountId}</strong></div>
                    <div><span>Trang thai</span><strong>${order.statusOrder}</strong></div>
                    <div><span>Tong tien</span><strong>${order.totalAmount}</strong></div>
                </div>
            </section>

            <section class="product-form-card">
                <h3>Snapshot ky</h3>
                <p><strong>Order hash:</strong> ${orderSign.orderHash}</p>
                <p><strong>Hash algorithm:</strong> ${orderSign.hashAlgorithm}</p>
                <pre style="white-space:pre-wrap;word-break:break-word;">${orderSign.snapshotJson}</pre>
            </section>

            <section class="product-form-card">
                <h3>Certificate</h3>
                <c:choose>
                    <c:when test="${not empty certificate}">
                        <p><strong>Certificate ID:</strong> ${certificate.certificateId}</p>
                        <p><strong>Account ID:</strong> ${certificate.accountId}</p>
                        <p><strong>Status:</strong> ${certificate.status}</p>
                        <form method="post" action="${pageContext.request.contextPath}/admin-sign/revoke-certificate">
                            <input type="hidden" name="certificateId" value="${certificate.certificateId}">
                            <input type="text" name="reason" placeholder="Reason" required>
                            <button type="submit">Revoke certificate</button>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <p>Khong tim thay certificate cho don hang nay.</p>
                    </c:otherwise>
                </c:choose>
            </section>

            <section class="product-form-card">
                <h3>Lich su verify</h3>
                <table class="admin-table">
                    <thead>
                    <tr>
                        <th>Action</th>
                        <th>Result</th>
                        <th>Message</th>
                        <th>Created at</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="log" items="${verifyLogs}">
                        <tr>
                            <td>${log.action}</td>
                            <td>${log.result}</td>
                            <td>${log.message}</td>
                            <td>${log.createdAt}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty verifyLogs}">
                        <tr><td colspan="4">Chua co log verify.</td></tr>
                    </c:if>
                    </tbody>
                </table>
                <form method="post" action="${pageContext.request.contextPath}/admin-sign/reverify">
                    <input type="hidden" name="orderId" value="${order.orderId}">
                    <button type="submit">Verify lai</button>
                </form>
            </section>
        </div>
    </main>
</div>
</body>
</html>
