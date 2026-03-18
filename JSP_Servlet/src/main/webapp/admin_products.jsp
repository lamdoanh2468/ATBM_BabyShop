<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <title>Admin - Quản lý sản phẩm</title>

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

            <a href="${pageContext.request.contextPath}/admin/products" class="active">
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

    <!-- MAIN -->
    <main class="main">
        <h2>Quản lý sản phẩm</h2>

        <!-- ADD -->
        <a href="${pageContext.request.contextPath}/admin/products?action=add"
           class="btn-add" style="margin-bottom:20px;    display: inline-flex;
    align-items: center;
    gap: 8px;
    padding: 12px 20px;
    background: linear-gradient(135deg, #6C63FF, #A696FF);
    color: #fff;
    font-weight: 600;
    font-size: 14px;
    border-radius: 12px;
    text-decoration: none;
    transition: 0.3s ease, transform 0.2s;">
            <i class="fa-solid fa-plus"></i> Thêm sản phẩm
        </a>

        <!-- TABLE -->
        <table class="data-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Tên</th>
                <th>Danh mục</th>
                <th>Giá</th>
                <th>Ảnh</th>
                <th>Thao tác</th>
            </tr>
            </thead>

            <tbody>
            <c:if test="${empty products}">
                <tr>
                    <td colspan="6" style="text-align:center;padding:20px">
                        Không có sản phẩm
                    </td>
                </tr>
            </c:if>

            <c:forEach var="p" items="${products}">
                <tr>
                    <td>#${p.productId}</td>
                    <td><strong>${p.productName}</strong></td>
                    <td>${categoryMap[p.categoryId]}</td>
                    <td>${p.productPrice}</td>

                    <td>
                        <c:if test="${not empty p.productImage}">
                            <img src="${p.productImage}"
                                 style="width:60px;height:60px;object-fit:cover;border-radius:8px">
                        </c:if>
                    </td>

                    <td>
                        <a class="btn-small btn-on"
                           href="${pageContext.request.contextPath}/admin/products?action=edit&id=${p.productId}">
                            <i class="fa-solid fa-pen"></i>
                        </a>

                        <form method="post"
                              action="${pageContext.request.contextPath}/admin/products"
                              style="display:inline"
                              onsubmit="return confirm('Xóa sản phẩm này?')">
                            <input type="hidden" name="action" value="delete"/>
                            <input type="hidden" name="id" value="${p.productId}"/>
                            <button type="submit" class="btn-small btn-delete">
                                <i class="fa-solid fa-trash"></i>
                            </button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </main>

    <!-- RIGHT PANEL -->
    <aside class="right-panel">
        <c:if test="${param.action == 'add' || param.action == 'edit'}">
            <div class="voucher-form">
                <h3>
                    <c:choose>
                        <c:when test="${param.action == 'add'}">Thêm sản phẩm</c:when>
                        <c:otherwise>Sửa sản phẩm</c:otherwise>
                    </c:choose>
                </h3>

                <form method="post"
                      action="${pageContext.request.contextPath}/admin/products">

                    <!-- ACTION -->
                    <input type="hidden" name="action"
                           value="${param.action == 'add' ? 'create' : 'update'}"/>

                    <!-- ID -->
                    <c:if test="${param.action == 'edit'}">
                        <input type="hidden" name="productId" value="${product.productId}"/>
                    </c:if>

                    <div class="form-grid">

                        <div class="form-item">
                            <label>Tên sản phẩm</label>
                            <input type="text" name="productName"
                                   value="${product != null ? product.productName : ''}"
                                   required/>
                        </div>

                        <div class="form-item">
                            <label>Giá</label>
                            <input type="number" name="productPrice"
                                   value="${product != null ? product.productPrice : ''}"
                                   required/>
                        </div>

                        <div class="form-item">
                            <label>Danh mục</label>
                            <select name="categoryId">
                                <c:forEach var="c" items="${categories}">
                                    <option value="${c.categoryId}"
                                        ${product != null && product.categoryId == c.categoryId ? 'selected' : ''}>
                                            ${c.categoryName}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="form-item">
                            <label>Thương hiệu</label>
                            <select name="brandId">
                                <c:forEach var="b" items="${brands}">
                                    <option value="${b.brandId}"
                                        ${product != null && product.brandId == b.brandId ? 'selected' : ''}>
                                            ${b.brandName}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="form-item">
                            <label>Kích thước</label>
                            <input type="text" name="productSize"
                                   value="${product != null ? product.productSize : ''}"/>
                        </div>

                        <div class="form-item">
                            <label>Chất liệu</label>
                            <input type="text" name="productMaterial"
                                   value="${product != null ? product.productMaterial : ''}"/>
                        </div>

                        <div class="form-item textarea-full">
                            <label>Ảnh sản phẩm (URL)</label>
                            <input type="text" name="productImage"
                                   value="${product != null ? product.productImage : ''}"/>
                        </div>

                    </div>

                    <div style="margin-top:20px;text-align:right">
                        <button type="submit" class="btn-primary">
                            <c:choose>
                                <c:when test="${param.action == 'add'}">Thêm</c:when>
                                <c:otherwise>Cập nhật</c:otherwise>
                            </c:choose>
                        </button>
                    </div>
                </form>
            </div>
        </c:if>
    </aside>
</div>
</body>
</html>
