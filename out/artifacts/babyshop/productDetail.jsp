<%--
  Created by IntelliJ IDEA.
  User: lamdo
  Date: 11/14/2025
  Time: 7:25 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <title>Chi tiết sản phẩm</title>
    <link rel="icon" type="image/x-icon"
          href="${pageContext.request.contextPath}/favicon.ico">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
            crossorigin="anonymous"
    />
    <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
            crossorigin="anonymous"
    ></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css"
          integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/productDetail.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/footer.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/header.css"/>

</head>
<body>
<jsp:include page="header.jsp"/>
<nav class="breadcrumb-nav">
    <a href="${pageContext.request.contextPath}/">Trang chủ</a>
    <span class="dot">•</span>
    <a href="${pageContext.request.contextPath}/product-list">Danh sách sản phẩm</a>
    <span class="dot">•</span>
    <a href="">${product.productName}</a>
</nav>
<div class="product-detail-page">
    <div class="container">
        <div class="product-wrapper">
            <div class="product-image">
                <div id="carouselExampleIndicators" class="carousel slide">
                    <div class="carousel-indicators">
                        <c:forEach items="${productImages}" var="img" varStatus="status">
                            <button type="button" data-bs-target="#carouselExampleIndicators"
                                    data-bs-slide-to="${status.index}"
                                    class="${status.index ==0?'active':''}"
                                    aria-current="${status.index == 0 ? 'true' : 'false'}"
                                    aria-label="Slide ${status.count}"></button>
                        </c:forEach>
                    </div>
                    <div class="carousel-inner">
                        <c:forEach var="image" items="${productImages}" varStatus="status">
                            <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
                                <img
                                        src="${image}"
                                        class="d-block w-100"
                                        alt="Hình ảnh bị lỗi"
                                />
                            </div>
                        </c:forEach>
                    </div>

                    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators"
                            data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators"
                            data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
                </div>

            </div>
            <div class="product-right">
                <div class="product-details">
                    <div class="product-main-info">
                        <h2>${product.productName}</h2>
                        <p class="price">
                            <fmt:setLocale value="vi_VN"/>
                            <fmt:formatNumber value="${product.productPrice}" type="number"
                                              groupingUsed="true"/>đ
                        </p>
                        <p class="product-id">Mã sản phẩm:
                            <c:choose>
                                <c:when test="${product.productId < 10}">00${product.productId}</c:when>
                                <c:when test="${product.productId < 100}">0${product.productId}</c:when>
                                <c:otherwise>${product.productId}</c:otherwise>
                            </c:choose>
                        </p>

                        <div class="product-status">
                            <span>Đã bán ${soldQuantity}</span>
                            <span class="dot">•</span>
                            <span>Tình trạng:
                                <c:if test="${isAvailable}">
                                   <span class="status in-stock">
                                        <i class="fa-solid fa-check-circle"></i> Còn hàng
                                   </span>
                                </c:if>
                                <c:if test="${!isAvailable}">
                                   <span class="status out-of-stock">
                                       <i class="fa-solid fa-circle-xmark"></i> Hết hàng
                                   </span>
                                </c:if>
                        </span>
                        </div>
                    </div>
                    <div class="spec-box">
                        <h3>Thông số chi tiết</h3>
                        <table>
                            <tr>
                                <td>Loại sản phẩm</td>
                                <td>${category.categoryName}</td>
                            </tr>
                            <tr>
                                <td>Thương hiệu</td>
                                <td>${brand.brandName}</td>
                            </tr>
                            <tr>
                                <td>Vật liệu</td>
                                <td>${product.productMaterial}</td>
                            </tr>
                            <tr>
                                <td>Kích thước</td>
                                <td>${product.productSize}</td>
                            </tr>
                        </table>
                    </div>
                    <div class="buy-box">
                        <div class="quantity-control-group">
                            <label class="label-qty">Số lượng:</label>
                            <div class="quantity-input-box">
                                <button class="qty-btn" onclick="decreaseUI(${product.productId})"><i
                                        class="fa-solid fa-minus"></i></button>
                                <input type="number" id="quantity-${product.productId}" value="1" min="1" readonly/>
                                <button class="qty-btn" onclick="increaseUI(${product.productId})"><i
                                        class="fa-solid fa-plus"></i></button>
                            </div>
                        </div>
                        <div class="buy-section">
                            <c:choose>
                                <c:when test="${isAvailable}">
                                    <a href="<c:url value='/cart?action=add&product_id=${product.productId}'/>"
                                       data-product-id="${product.productId}"
                                       class="add-btn">
                                        <i class="fa-solid fa-cart-plus"></i> Thêm vào giỏ
                                    </a>

                                    <a href="<c:url value='/cart?action=buy_now&product_id=${product.productId}'/>"
                                       data-product-id="${product.productId}"
                                       class="buy-btn">
                                        Mua Ngay
                                    </a>
                                </c:when>

                                <c:otherwise>
                                    <button class="add-btn disabled" disabled>
                                        <i class="fa-solid fa-cart-plus"></i> Hết hàng
                                    </button>

                                    <button class="buy-btn disabled" disabled>
                                        Không thể mua
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <div class="clearfix"></div>

        <div class="product-info">
            <ul class="nav nav-tabs">
                <li class="nav-item">
                    <a class="nav-link active" data-target="#tab-detail">Chi tiết</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-target="#tab-feedback">Feedback</a>
                </li>
            </ul>
            <div class="tab-content-container">
                <div id="tab-detail" class="tab-content active">
                    <c:if test="${not empty details}">
                        <c:forEach var="detail" items="${details}">
                            <div class="content-block" style="margin-bottom: 20px;">
                                <c:if test="${not empty detail.description}">
                                    <div class="content-text">
                                        <c:out value="${detail.description}" escapeXml="false"/>
                                    </div>
                                </c:if>

                                <c:if test="${not empty detail.detail_image}">
                                    <div class="content-image" style="margin-top: 10px;">
                                        <img src="${detail.detail_image}" class="d-block w-100"
                                             alt="Chi tiết sản phẩm"/>
                                    </div>
                                </c:if>
                            </div>
                        </c:forEach>
                    </c:if>
                </div>
                <div id="tab-feedback" class="tab-content" style="display: none;">
                    <div class="feedback-area">

                        <form action="add-review" method="post" id="reviewForm">

                            <input type="hidden" name="product_id" value="${product.productId}">

                            <textarea name="comment" id="feedback-input" placeholder="Nhập đánh giá của bạn..." rows="5"
                                      required></textarea>

                            <button type="submit" id="btn-send-feedback">Gửi đánh giá</button>
                        </form>
                        <div id="comment-list">
                            <c:if test="${not empty reviewList}">
                                <c:forEach var="rv" items="${reviewList}">
                                    <div class="comment-item">
                                        <div class="comment-body">
                                            <div class="comment-header">
                                                <span class="user-name">${rv.username}</span>
                                                <span class="verified-badge">
                                            <i class="fa-solid fa-circle-check"></i> Đã mua tại BabyStore
                                            </span>
                                            </div>

                                            <div class="comment-content">
                                                    ${rv.comment}
                                            </div>

                                            <div class="comment-date">
                                                Thời gian: ${rv.created_at}
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:if>

                            <c:if test="${empty reviewList}">
                                <div class="no-reviews">
                                    <i class="fa-regular fa-comment-dots"></i>
                                    <p>Chưa có đánh giá nào.</p>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <button type="button" id="backToTop" title="Back To Top">
        <i class="fa-solid fa-arrow-up"></i>
    </button>
</div>

<jsp:include page="footer.jsp"/>
<script src="${pageContext.request.contextPath}/js/productDetail.js"></script>
</body>
</html>
