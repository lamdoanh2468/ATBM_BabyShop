<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <title>Admin - ${param.action == 'edit' ? 'Sửa' : 'Thêm'} kho hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin_style.css?v=20260502-2"/>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"/>
</head>
<body>
<div class="dashboard">
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

    <main class="main">
        <div class="product-form-shell">
            <div class="product-form-hero">
                <div class="product-form-copy">
                    <span class="product-form-eyebrow">Stock Workspace</span>
                    <h2>
                        <c:choose>
                            <c:when test="${param.action == 'edit'}">Sửa kho hàng</c:when>
                            <c:otherwise>Thêm kho hàng</c:otherwise>
                        </c:choose>
                    </h2>
                    <p>Cấu hình thông tin kho hàng. Trường số lượng sản phẩm hiện được tính tự động từ dữ liệu tồn kho.</p>
                </div>

                <a href="${pageContext.request.contextPath}/admin/stocks" class="product-back-link">
                    <i class="fa-solid fa-arrow-left"></i>
                    <span>Quay lại danh sách</span>
                </a>
            </div>

            <div class="product-form-layout">
                <section class="product-form-card">
                    <div class="product-form-card-head">
                        <div>
                            <h3>
                                <c:choose>
                                    <c:when test="${param.action == 'edit'}">Thông tin kho cần cập nhật</c:when>
                                    <c:otherwise>Thông tin kho mới</c:otherwise>
                                </c:choose>
                            </h3>
                            <p>Tên kho và địa chỉ có thể chỉnh trực tiếp. Số lượng SP là chỉ số tổng hợp hiện tại.</p>
                        </div>
                        <div class="product-form-state">
                            <i class="fa-solid fa-warehouse"></i>
                            <span>${param.action == 'edit' ? 'Editing' : 'Creating'}</span>
                        </div>
                    </div>

                    <form method="post" action="${pageContext.request.contextPath}/admin/stocks">
                        <input type="hidden" name="action" value="${param.action == 'edit' ? 'edit' : 'add'}"/>

                        <c:if test="${param.action == 'edit'}">
                            <input type="hidden" name="id" value="${stockToEdit.stockId}"/>
                        </c:if>

                        <div class="form-grid product-form-grid">
                            <div class="form-item">
                                <label>Tên kho</label>
                                <input type="text"
                                       name="name"
                                       value="${stockToEdit != null ? stockToEdit.stockName : ''}"
                                       placeholder="Ví dụ: Kho Hà Nội"
                                       required/>
                            </div>

                            <div class="form-item">
                                <label>Số lượng SP</label>
                                <input type="number"
                                       value="${stockFormProductCount}"
                                       readonly
                                       disabled/>
                            </div>

                            <div class="form-item textarea-full">
                                <label>Địa chỉ</label>
                                <input type="text"
                                       name="address"
                                       value="${stockToEdit != null ? stockToEdit.stockAddress : ''}"
                                       placeholder="123 Nguyễn Trãi, Hà Nội"
                                       required/>
                            </div>
                        </div>

                        <div class="product-form-actions">
                            <a href="${pageContext.request.contextPath}/admin/stocks" class="product-cancel-link">
                                Hủy
                            </a>
                            <button type="submit" class="btn-primary product-submit-btn">
                                <i class="fa-solid ${param.action == 'edit' ? 'fa-floppy-disk' : 'fa-plus'}"></i>
                                <span>
                                    <c:choose>
                                        <c:when test="${param.action == 'edit'}">Cập nhật kho</c:when>
                                        <c:otherwise>Tạo kho hàng</c:otherwise>
                                    </c:choose>
                                </span>
                            </button>
                        </div>
                    </form>
                </section>

                <aside class="product-preview-card">
                    <div class="product-preview-media">
                        <div class="product-preview-placeholder">
                            <i class="fa-solid fa-warehouse"></i>
                        </div>
                    </div>

                    <div class="product-preview-body">
                        <span class="product-preview-badge">${param.action == 'edit' ? 'Kho hiện tại' : 'Kho mới'}</span>
                        <h3>${stockToEdit != null && stockToEdit.stockName != null ? stockToEdit.stockName : 'Tên kho sẽ hiển thị ở đây'}</h3>
                        <p>${stockToEdit != null && stockToEdit.stockAddress != null ? stockToEdit.stockAddress : 'Thêm địa chỉ để đội vận hành dễ nhận biết vị trí kho.'}</p>

                        <div class="product-preview-meta">
                            <div>
                                <span>Số lượng SP</span>
                                <strong>${stockFormProductCount}</strong>
                            </div>
                            <div>
                                <span>Trạng thái form</span>
                                <strong>${param.action == 'edit' ? 'Đang sửa' : 'Tạo mới'}</strong>
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
