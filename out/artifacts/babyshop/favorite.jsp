<%-- Favorite Products Page - Modern UI --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sản phẩm yêu thích</title>
    <link rel="icon" type="image/x-icon"
          href="${pageContext.request.contextPath}/favicon.ico">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
          rel="stylesheet">

    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/profile.css">

    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</head>

<body>
<jsp:include page="header.jsp"/>

<div class="pf-page">

    <!-- BREADCRUMB -->
    <nav class="pf-breadcrumb">
        <a href="${pageContext.request.contextPath}/">
            Trang chủ
        </a>
        <span class="dot">•</span>
        <span>Sản phẩm yêu thích</span>
    </nav>

    <div class="pf-container">

        <!-- SIDEBAR -->
        <aside class="pf-sidebar">
            <h2><i class="fas fa-user-circle"></i> ${sessionScope.USER.username}</h2>
            <ul>
                <li onclick="location.href='${pageContext.request.contextPath}/profile'">
                    <i class="fas fa-user"></i> Thông tin cá nhân
                </li>
                <li onclick="location.href='${pageContext.request.contextPath}/bought-product'">
                    <i class="fas fa-shopping-bag"></i> Đơn hàng đã mua
                </li>
                <li class="active">
                    <i class="fas fa-heart"></i> Sản Phẩm Yêu Thích
                </li>
                <li onclick="location.href='${pageContext.request.contextPath}/change-password'">
                    <i class="fas fa-key"></i> Đổi mật khẩu
                </li>
            </ul>
        </aside>

        <!-- CONTENT -->
        <main class="pf-content">

            <section class="pf-section pf-section-active">
                <h3><i class="fas fa-heart"></i> Sản phẩm yêu thích</h3>

                <c:if test="${empty FAVORITES}">
                    <div class="pf-empty">
                        <span class="pf-empty-icon">💖</span>
                        <h4>Chưa có sản phẩm yêu thích</h4>
                        <p>Hãy khám phá và thêm sản phẩm vào danh sách yêu thích của bạn!</p>
                        <a href="${pageContext.request.contextPath}/product-list"
                           class="pf-empty-btn">
                            <i class="fas fa-search"></i> Khám phá ngay
                        </a>
                    </div>
                </c:if>

                <div class="pf-favorite-list">
                    <c:forEach items="${FAVORITES}" var="f" varStatus="loop">
                        <div class="pf-favorite-row">

                            <img src="${f.productImage}" alt="${f.productName}"
                                 onerror="this.src='${pageContext.request.contextPath}/images/placeholder.png'">

                            <div class="pf-fav-info">
                                <h4>${f.productName}</h4>
                                <div class="pf-fav-price">
                                    <i class="fas fa-tag"></i>
                                    <fmt:setLocale value="vi_VN"/>
                                    <fmt:formatNumber value="${f.productPrice}" type="number"
                                                      groupingUsed="true"/>đ
                                </div>
                            </div>

                            <!-- Add to Cart Button -->
                            <a href="${pageContext.request.contextPath}/cart?action=add&product_id=${f.productId}&quantity=1&returnUrl=${pageContext.request.contextPath}/my-favorite"
                               class="pf-add-cart">
                                <i class="fas fa-cart-plus"></i>
                                Thêm vào giỏ
                            </a>

                            <!-- Remove from Favorites -->
                            <form method="post"
                                  action="${pageContext.request.contextPath}/my-favorite"
                                  style="margin: 0;">
                                <input type="hidden" name="action" value="remove">
                                <input type="hidden" name="product_id" value="${f.productId}">
                                <button class="pf-remove-fav" type="submit"
                                        onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này khỏi danh sách yêu thích?')">
                                    <i class="fas fa-trash-alt"></i>
                                </button>
                            </form>

                        </div>
                    </c:forEach>
                </div>

            </section>

        </main>
    </div>
</div>

<jsp:include page="footer.jsp"/>
</body>

</html>