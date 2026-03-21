<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <title>Admin - Quản lý đơn hàng</title>

<%--                <!-- FONT -->--%>
<%--                <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"--%>
<%--                    rel="stylesheet">--%>

                <!-- CSS -->
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin_style.css" />
                <link rel="stylesheet"
                    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" />

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

                            <a href="${pageContext.request.contextPath}/admin/orders" class="active">
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

                    <!-- MAIN CONTENT -->
                    <main class="main">
                        <h2>Quản lý đơn hàng</h2>

                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Mã đơn</th>
                                    <th>Khách hàng</th>
                                    <th>Ngày đặt</th>
                                    <th>Tổng tiền</th>
                                    <th>Thanh toán</th>
                                    <th>Trạng thái</th>
                                </tr>
                            </thead>

                            <tbody>
                                <c:forEach var="order" items="${orders}">
                                    <tr>
                                        <td>#${order.orderId}</td>

                                        <td>${order.username}</td>

                                        <td>${order.orderDate}</td>
                                        <td>
                                            <fmt:formatNumber value="${order.totalAmount}" type="number" />đ
                                        </td>

                                        <td>${order.paymentMethod}</td>
                                        <td>
                                            <select class="status-select ${order.statusOrder}"
                                                data-id="${order.orderId}" data-previous="${order.statusOrder}"
                                                onchange="updateStatus(this)" ${order.statusOrder eq 'Cancelled' ||
                                                order.statusOrder eq 'Done' ? 'disabled' : '' }>
                                                <option value="Pending" ${order.statusOrder eq 'Pending' ? 'selected'
                                                    : '' }>
                                                    Chưa xác nhận
                                                </option>

                                                <option value="Done" ${order.statusOrder eq 'Done' ? 'selected' : '' }>
                                                    Đã giao hàng
                                                </option>

                                                <option value="Cancelled" ${order.statusOrder eq 'Cancelled'
                                                    ? 'selected' : '' }>
                                                    Đã hủy
                                                </option>
                                            </select>
                                        </td>
                                    </tr>
                                </c:forEach>

                                <c:if test="${empty orders}">
                                    <tr>
                                        <td colspan="6" style="text-align:center">
                                            Không có đơn hàng
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </main>

                    <!-- RIGHT PANEL -->
                    <aside class="right-panel"></aside>

                </div>

                <script>
                    function updateStatus(select) {
                        var id = select.getAttribute('data-id');
                        var status = select.value;
                        var previousValue = select.getAttribute('data-previous') || 'Pending';

                        // Xác nhận khi chọn Cancelled
                        if (status === 'Cancelled') {
                            var confirmed = confirm('Bạn chắc chắn muốn huỷ đơn hàng này không?\nHành động này sẽ không được hoàn tác.');
                            if (!confirmed) {
                                // Khôi phục giá trị cũ nếu user hủy
                                select.value = previousValue;
                                return;
                            }
                        }

                        var url = '${pageContext.request.contextPath}/admin/orders/status?id=' + id + '&status=' + status;

                        fetch(url)
                            .then(function (res) { return res.text(); })
                            .then(function (txt) {
                                if (txt === "OK") {
                                    console.log("Cập nhật thành công");
                                    // Cập nhật previous value và disable nếu cần
                                    select.setAttribute('data-previous', status);
                                    if (status === 'Cancelled' || status === 'Done') {
                                        select.disabled = true;
                                    }
                                } else if (txt === "PARTIAL") {
                                    alert("Trạng thái đã cập nhật nhưng có lỗi khi xử lý kho hàng");
                                    select.setAttribute('data-previous', status);
                                    if (status === 'Cancelled' || status === 'Done') {
                                        select.disabled = true;
                                    }
                                } else {
                                    alert("Cập nhật trạng thái thất bại: " + txt);
                                    // Khôi phục giá trị cũ nếu thất bại
                                    select.value = previousValue;
                                }
                            })
                            .catch(function (err) {
                                alert("Lỗi kết nối: " + err);
                                select.value = previousValue;
                            });
                    }
                </script>
            </body>

            </html>