<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <title>Admin - Tổng quan</title>

    <!-- CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/admin_style.css?v=2">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin_chart.css"/>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"/>

    <!-- Chart JS -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>

<body>

<div class="dashboard">

    <!-- SIDEBAR -->
    <aside class="sidebar">
        <nav class="menu">
            <a href="${pageContext.request.contextPath}/admin/overview" class="active">
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

    <!-- CONTENT -->
    <div class="content-wrapper">

        <main class="main">
            <h2>Thống kê dữ liệu</h2>

            <!-- CARDS -->
            <section class="dashboard-cards">

                <div class="card-large">
                    <div class="card-info">
                        <h4>Tổng doanh thu</h4>
                        <p class="value">
                            <fmt:formatNumber value="${totalRevenue}" type="number"/>đ
                        </p>
                    </div>
                    <i class="fa-solid fa-coins icon"></i>
                </div>

                <div class="card-large">
                    <div class="card-info">
                        <h4>Tổng đơn hàng</h4>
                        <p class="value">${totalOrders}</p>
                    </div>
                    <i class="fa-solid fa-cart-shopping icon"></i>
                </div>

                <div class="card-small">
                    <div class="card-info">
                        <h4>Số lượng tài khoản</h4>
                        <p class="value">${totalCustomers}</p>
                    </div>
                    <i class="fa-solid fa-user-group icon"></i>
                </div>

                <div class="card-small">
                    <div class="card-info">
                        <h4>Số lượng sản phẩm</h4>
                        <p class="value">${totalProducts}</p>
                    </div>
                    <i class="fa-solid fa-boxes-stacked icon"></i>
                </div>

            </section>

            <!-- CHARTS -->
            <section class="charts-upgraded">

                <div class="chart-card">
                    <div class="chart-header">
                        <h3>Doanh thu theo tháng</h3>
                    </div>
                    <canvas id="revenueChart"></canvas>
                </div>

                <div class="chart-card">
                    <div class="chart-header">
                        <h3>Đơn hàng theo danh mục</h3>
                    </div>
                    <canvas id="categoryChart"></canvas>
                </div>
            </section>

            <!-- RECENT ORDERS -->
            <section class="recent-orders">
                <h3>Đơn hàng gần nhất</h3>

                <table class="data-table">
                    <thead>
                    <tr>
                        <th>Mã đơn</th>
                        <th>Khách hàng</th>
                        <th>Tổng tiền</th>
                        <th>Ngày</th>
                        <th>Trạng thái</th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:forEach items="${recentOrders}" var="o">
                        <tr>
                            <td>#${o.orderId}</td>
                            <td>${o.username}</td>
                            <td>
                                <fmt:formatNumber value="${o.totalAmount}" type="number"/>đ
                            </td>
                            <td>
                                <fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy"/>
                            </td>
                            <td>
                                <span class="status ${o.statusOrder == 'Done' ? 'on' : 'off'}">
                                        ${o.statusOrder}
                                </span>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </section>
        </main>
    </div>
</div>
<script>
    window.ADMIN_DATA = {
        revenueByMonth: ${revenueByMonthJson},
        ordersByCategory: ${ordersByCategoryJson},
        contextPath: "${pageContext.request.contextPath}"
    };
</script>
<script src="${pageContext.request.contextPath}/js/admin_script.js"></script>
</body>
</html>
