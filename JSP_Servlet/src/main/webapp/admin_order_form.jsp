<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <title>Admin - Sửa đơn hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin_style.css?v=20260502-2"/>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"/>
</head>
<body>
<div class="dashboard">
    <aside class="sidebar">
        <nav class="menu">
            <a href="${pageContext.request.contextPath}/admin/overview"><i class="fa-solid fa-house"></i><span>Dashboard</span></a>
            <a href="${pageContext.request.contextPath}/admin/accounts"><i class="fa-solid fa-user"></i><span>Tài khoản</span></a>
            <a href="${pageContext.request.contextPath}/admin/orders" class="active"><i class="fa-solid fa-box"></i><span>Đơn hàng</span></a>
            <a href="${pageContext.request.contextPath}/admin/products"><i class="fa-solid fa-cubes"></i><span>Sản phẩm</span></a>
            <a href="${pageContext.request.contextPath}/admin/categories"><i class="fa-solid fa-layer-group"></i><span>Danh mục sản phẩm</span></a>
            <a href="${pageContext.request.contextPath}/admin/brands"><i class="fa-solid fa-tags"></i><span>Thương hiệu</span></a>
            <a href="${pageContext.request.contextPath}/admin/contacts"><i class="fa-solid fa-envelope"></i><span>Liên hệ</span></a>
            <a href="${pageContext.request.contextPath}/admin/stocks"><i class="fa-solid fa-warehouse"></i><span>Kho hàng</span></a>
            <a href="${pageContext.request.contextPath}/admin/vouchers"><i class="fa-solid fa-ticket"></i><span>Vouchers</span></a>
            <a href="${pageContext.request.contextPath}/admin/settings"><i class="fa-solid fa-gear"></i><span>Cài đặt</span></a>
        </nav>
    </aside>

    <main class="main">
        <div class="product-form-shell">
            <div class="product-form-hero">
                <div class="product-form-copy">
                    <span class="product-form-eyebrow">Order Workspace</span>
                    <h2>Sửa đơn hàng #${order.orderId}</h2>
                    <p>Chỉnh trạng thái, phương thức thanh toán và địa chỉ giao hàng của đơn.</p>
                </div>

                <a href="${pageContext.request.contextPath}/admin/orders/detail?id=${order.orderId}" class="product-back-link">
                    <i class="fa-solid fa-arrow-left"></i>
                    <span>Quay lại chi tiết</span>
                </a>
            </div>

            <div class="product-form-layout">
                <section class="product-form-card">
                    <div class="product-form-card-head">
                        <div>
                            <h3>Thông tin có thể chỉnh sửa</h3>
                            <p>Dữ liệu thay đổi sẽ được lưu trực tiếp vào đơn hàng hiện tại.</p>
                        </div>
                        <div class="product-form-state">
                            <i class="fa-solid fa-pen-to-square"></i>
                            <span>Editing</span>
                        </div>
                    </div>

                    <form method="post" action="${pageContext.request.contextPath}/admin/orders/edit">
                        <input type="hidden" name="orderId" value="${order.orderId}"/>

                        <div class="form-grid product-form-grid">
                            <div class="form-item">
                                <label>Khách hàng</label>
                                <input type="text" value="${order.username}" readonly disabled/>
                            </div>

                            <div class="form-item">
                                <label>Tổng tiền</label>
                                <input type="text" value="${order.totalAmount}đ" readonly disabled/>
                            </div>

                            <div class="form-item">
                                <label>Phương thức thanh toán</label>
                                <select name="paymentMethod">
                                    <option value="COD" ${order.paymentMethod.name() == 'COD' ? 'selected' : ''}>COD</option>
                                    <option value="Card" ${order.paymentMethod.name() == 'Card' ? 'selected' : ''}>Card</option>
                                </select>
                            </div>

                            <div class="form-item">
                                <label>Trạng thái</label>
                                <select name="status">
                                    <option value="Pending" ${order.statusOrder.name() == 'Pending' ? 'selected' : ''}>Pending</option>
                                    <option value="Done" ${order.statusOrder.name() == 'Done' ? 'selected' : ''}>Done</option>
                                    <option value="Cancelled" ${order.statusOrder.name() == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                                </select>
                            </div>

                            <div class="form-item textarea-full">
                                <label>Địa chỉ giao hàng</label>
                                <input type="text" name="deliveryAddress" value="${order.deliveryAddress}" required/>
                            </div>
                        </div>

                        <div class="product-form-actions">
                            <a href="${pageContext.request.contextPath}/admin/orders/detail?id=${order.orderId}" class="product-cancel-link">
                                Hủy
                            </a>
                            <button type="submit" class="btn-primary product-submit-btn">
                                <i class="fa-solid fa-floppy-disk"></i>
                                <span>Lưu thay đổi</span>
                            </button>
                        </div>
                    </form>
                </section>

                <aside class="product-preview-card">
                    <div class="product-preview-media">
                        <div class="product-preview-placeholder">
                            <i class="fa-solid fa-box"></i>
                        </div>
                    </div>

                    <div class="product-preview-body">
                        <span class="product-preview-badge">Sản phẩm trong đơn</span>
                        <h3>Đơn #${order.orderId} có ${orderDetails.size()} dòng sản phẩm</h3>
                        <p>Bạn đang sửa thông tin nghiệp vụ của đơn hàng. Danh sách sản phẩm được hiển thị để đối chiếu nhanh.</p>

                        <div class="product-preview-meta">
                            <div>
                                <span>Ngày đặt</span>
                                <strong>${order.orderDate}</strong>
                            </div>
                            <div>
                                <span>Tổng tiền</span>
                                <strong><fmt:formatNumber value="${order.totalAmount}" type="number"/>đ</strong>
                            </div>
                        </div>
                    </div>
                </aside>
            </div>
        </div>
    </main>
</div>
</body>
</html>
