<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <title>Admin - Quản lý liên hệ</title>

    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin_style.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin_chart.css"/>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"/>

    <!-- JS LIB -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>

<body>

<div class="dashboard">

    <!-- SIDEBAR -->
    <aside class="sidebar">
        <nav class="menu">
            <a href="${pageContext.request.contextPath}/admin/overview">
                <i class="fa-solid fa-house"></i>
                <span>Dashboard</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/accounts">
                <i class="fa-solid fa-user"></i>
                <span>Tài khoản</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/orders">
                <i class="fa-solid fa-box"></i>
                <span>Đơn hàng</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/products">
                <i class="fa-solid fa-cubes"></i>
                <span>Sản phẩm</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/categories">
                <i class="fa-solid fa-layer-group"></i>
                <span>Danh mục sản phẩm</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/brands">
                <i class="fa-solid fa-tags"></i>
                <span>Thương hiệu</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/contacts" class="active">
                <i class="fa-solid fa-envelope"></i>
                <span>Liên hệ</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/stocks">
                <i class="fa-solid fa-warehouse"></i>
                <span>Kho hàng</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/vouchers">
                <i class="fa-solid fa-ticket"></i>
                <span>Vouchers</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/settings">
                <i class="fa-solid fa-gear"></i>
                <span>Cài đặt</span>
            </a>
        </nav>
    </aside>

    <!-- MAIN -->
    <main class="main">
        <h2>Quản lý liên hệ</h2>

        <table class="data-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Khách hàng</th>
                <th>Điện thoại</th>
                <th>Email</th>
                <th>Địa chỉ</th>
                <th>Thao tác</th>
            </tr>
            </thead>

            <tbody id="contactBody">
            <c:if test="${empty contactList}">
                <tr>
                    <td colspan="7" style="text-align:center;padding:20px;">
                        Không có liên hệ nào
                    </td>
                </tr>
            </c:if>

            <c:forEach var="c" items="${contactList}">
                <tr>
                    <td>#${c.contactId}</td>

                    <td>
                        <strong>${c.fullName}</strong>
                    </td>

                    <td>${c.phone}</td>

                    <td>
                        <a href="mailto:${c.email}" style="color:#6C63FF">
                                ${c.email}
                        </a>
                    </td>

                    <td>${c.address}</td>
                    <td>
                        <a class="btn-small btn-on"
                           href="${pageContext.request.contextPath}/admin/contacts?action=view&id=${c.contactId}">
                            <i class="fa-solid fa-eye"></i>
                        </a>

                        <a class="btn-small btn-delete"
                           onclick="return confirm('Bạn chắc chắn muốn xóa liên hệ này?')"
                           href="${pageContext.request.contextPath}/admin/contacts?action=delete&id=${c.contactId}">
                            <i class="fa-solid fa-trash"></i>
                        </a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

    </main>
    <!-- CONTENT -->
    <aside class="right-panel">
        <c:if test="${not empty selectedContact}">
            <div style="margin-top:25px" class="voucher-form">
                <h3>Chi tiết liên hệ #${selectedContact.contactId}</h3>

                <p><strong>Khách hàng:</strong> ${selectedContact.fullName}</p>
                <p><strong>Điện thoại:</strong> ${selectedContact.phone}</p>
                <p><strong>Email:</strong> ${selectedContact.email}</p>
                <p><strong>Địa chỉ:</strong> ${selectedContact.address}</p>

                <hr style="margin:15px 0">

                <p><strong>Nội dung:</strong></p>
                <p>${selectedContact.message}</p>
            </div>
        </c:if>
    </aside>
</div>
</body>
</html>
