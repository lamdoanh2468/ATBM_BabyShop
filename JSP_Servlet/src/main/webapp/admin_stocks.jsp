<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Admin - Quản lý kho hàng</title>

    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin_style.css"/>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"/>
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

            <a href="${pageContext.request.contextPath}/admin/contacts">
                <i class="fa-solid fa-envelope"></i>
                <span>Liên hệ</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/stocks" class="active">
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

    <!-- CONTENT -->
    <div class="content-wrapper">

        <!-- MAIN -->
        <main class="main">
            <h2>Quản lý kho hàng</h2>

            <!-- FORM THÊM / SỬA KHO -->
            <section class="voucher-form">
                <h3>
                    <c:choose>
                        <c:when test="${param.action == 'edit'}">Sửa kho hàng</c:when>
                        <c:otherwise>Thêm kho mới</c:otherwise>
                    </c:choose>
                </h3>

                <form class="form-grid"
                      action="${pageContext.request.contextPath}/admin/stocks"
                      method="post">

                    <input type="hidden" name="action"
                           value="${param.action == 'edit' ? 'edit' : 'add'}"/>

                    <c:if test="${param.action == 'edit'}">
                        <input type="hidden" name="id" value="${stockToEdit.stockId}"/>
                    </c:if>

                    <div class="form-item">
                        <label>Tên kho</label>
                        <input type="text"
                               name="name"
                               value="${stockToEdit != null ? stockToEdit.stockName : ''}"
                               placeholder="Ví dụ: Kho Hà Nội"
                               required>
                    </div>

                    <div class="form-item">
                        <label>Địa chỉ</label>
                        <input type="text"
                               name="address"
                               value="${stockToEdit != null ? stockToEdit.stockAddress : ''}"
                               placeholder="123 Nguyễn Trãi, Hà Nội"
                               required>
                    </div>

                    <button type="submit" class="btn-primary">
                        <c:choose>
                            <c:when test="${param.action == 'edit'}">Cập nhật kho</c:when>
                            <c:otherwise>Thêm kho hàng</c:otherwise>
                        </c:choose>
                    </button>
                </form>
            </section>

            <!-- DANH SÁCH KHO -->
            <section class="voucher-list">
                <h3>Danh sách kho hàng</h3>

                <table class="data-table">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên kho</th>
                        <th>Địa chỉ</th>
                        <th>Số lượng SP</th>
                        <th>Hành động</th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:if test="${empty stocks}">
                        <tr>
                            <td colspan="5" style="text-align:center;padding:20px;">
                                Chưa có kho hàng
                            </td>
                        </tr>
                    </c:if>

                    <c:forEach var="stock" items="${stocks}">
                        <tr>
                            <td>${stock.stockId}</td>
                            <td>${stock.stockName}</td>
                            <td>${stock.stockAddress}</td>
                            <td>${stock.productCount}</td>
                            <td>
                                <!-- Sửa -->
                                <a class="btn-small btn-on"
                                   href="${pageContext.request.contextPath}/admin/stocks?action=edit&id=${stock.stockId}">
                                    <i class="fa-solid fa-pen"></i>
                                </a>

                                <!-- Xóa -->
                                <form action="${pageContext.request.contextPath}/admin/stocks"
                                      method="post"
                                      style="display:inline"
                                      onsubmit="return confirm('Bạn chắc chắn muốn xóa kho này?')">

                                    <input type="hidden" name="action" value="delete"/>
                                    <input type="hidden" name="id" value="${stock.stockId}"/>

                                    <button type="submit" class="btn-small btn-delete">
                                        <i class="fa-solid fa-trash"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </section>
        </main>

        <aside class="right-panel"></aside>
    </div>
</div>
</body>
</html>
