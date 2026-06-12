<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Giỏ hàng của bạn</title>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/favicon.ico">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css"
          integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <link rel="stylesheet" href="../fontawesome-free-7.1.0-web/css/all.min.css"/>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/cartStyle.css?v=sign-popup-2"/>
</head>

<body>
<jsp:include page="header.jsp"/>
<nav class="breadcrumb-nav">
    <a href="${pageContext.request.contextPath}/">Trang chủ</a>
    <span class="dot">•</span>
    <a href="">Giỏ hàng</a>
</nav>
<div class="cart-header">
    <h3 class="page-title">Giỏ hàng</h3>
</div>
<div class="cart-container">
    <c:choose>
        <c:when test="${sessionScope.cart == null || sessionScope.cart.getTotalQuantity() == 0}">
            <div class="empty-cart">
                <img src="../img/cart-null.png" alt=""/>

                <p style="font-weight: 550">Giỏ hàng trống</p>
                <p>
                    Bạn tham khảo thêm các sản phẩm
                    <a href="<c:url value='/product-list' />">tại đây</a> nhé!
                </p>
            </div>
        </c:when>
        <c:otherwise>
            <div class="cart-items">
                <div class="cart-items-header">
                                    <span class="cart-items-count">${sessionScope.cart.getTotalQuantity()} sản
                                        phẩm</span>
                    <button onclick="location.href='cart?action=remove_all'" class="clear-cart-btn">
                        🗑 Xoá tất cả
                    </button>
                </div>
                <c:forEach var="item" items="${sessionScope.cart.items}">
                    <div class="cart-item">
                        <div>
                            <img class="item-image" src="${item.product.productImage}"
                                 alt="${item.product.productName}"/>
                        </div>
                        <div class="item-details">
                            <h3 class="item-title">${item.product.productName}</h3>
                            <p class="item-variant">Mã SP: <c:choose>
                                <c:when test="${item.product.productId < 10}">
                                    00${item.product.productId}</c:when>
                                <c:when test="${item.product.productId < 100}">
                                    0${item.product.productId}</c:when>
                                <c:otherwise>${item.product.productId}</c:otherwise>
                            </c:choose>
                            </p>

                            <div class="item-price">
                                                <span class="current-price">
                                                    <fmt:setLocale value="vi_VN"/>
                                                    <fmt:formatNumber value="${item.price}" type="number"
                                                                      groupingUsed="true"/>đ
                                                </span>
                            </div>
                        </div>
                        <div class="item-actions">
                            <button type="button" class="delete-btn" title="Xóa sản phẩm"
                                    onclick="location.href='cart?action=remove&product_id=${item.product.productId}'">
                                <i class="fa-solid fa-trash"></i>
                            </button>

                            <div class="quantity-control">
                                <button type="button" class="quantity-btn"
                                        onclick="decreaseUI(${item.product.productId})">−
                                </button>

                                <input type="text" class="quantity-input" value="${item.quantity}"
                                       id="quantity-${item.product.productId}" readonly/>

                                <button type="button" class="quantity-btn"
                                        onclick="increaseUI(${item.product.productId})">+
                                </button>
                            </div>
                        </div>
                    </div>

                </c:forEach>

            </div>
            <div class="order-summary">
                <h2 class="summary-title">Thông tin thanh toán</h2>

                <!-- Form tạo Order -->
                <form method="post" action="${pageContext.request.contextPath}/order"
                      class="checkout-form">

                    <!-- Voucher -->
                    <div class="form-section voucher-section">
                        <div class="form-section-header">
                            <i class="fa-solid fa-ticket"></i>
                            <span>Mã giảm giá</span>
                        </div>

                        <c:choose>
                            <c:when test="${not empty sessionScope.voucherCode}">
                                <!-- Đã áp dụng voucher -->
                                <div class="voucher-applied">
                                    <div class="voucher-tag">
                                        <i class="fa-solid fa-check-circle"></i>
                                        <span class="voucher-code">${sessionScope.voucherCode}</span>
                                        <input type="hidden" name="voucherCode"
                                               value="${sessionScope.voucherCode}"/>
                                    </div>
                                    <button type="submit" name="action" value="removeVoucher"
                                            class="remove-voucher-btn"
                                            formaction="${pageContext.request.contextPath}/order"
                                            formnovalidate>
                                        <i class="fa-solid fa-times"></i>
                                        Hủy
                                    </button>
                                </div>
                                <c:if test="${empty requestScope.voucherError}">
                                    <div class="voucher-success-text">
                                        <i class="fa-solid fa-gift"></i>
                                        Bạn đã được giảm giá!
                                    </div>
                                </c:if>
                            </c:when>
                            <c:otherwise>
                                <!-- Chưa áp dụng voucher -->
                                <div class="voucher-input-wrapper">
                                    <input type="text" name="voucherCode" class="voucher-input"
                                           placeholder="Nhập mã voucher"/>
                                    <button type="submit" name="action" value="applyVoucher"
                                            class="voucher-apply-btn"
                                            formaction="${pageContext.request.contextPath}/order"
                                            formnovalidate>
                                        Áp dụng
                                    </button>
                                </div>
                            </c:otherwise>
                        </c:choose>

                        <!-- Error Message -->
                        <c:if test="${not empty requestScope.voucherError}">
                            <div class="voucher-error">
                                <i class="fa-solid fa-exclamation-circle"></i>
                                    ${voucherError}
                            </div>
                        </c:if>
                    </div>


                    <!-- Thông tin giao hàng -->
                    <div class="form-section">
                        <div class="form-section-header">
                            <i class="fa-solid fa-truck-fast"></i>
                            <span>Thông tin giao hàng</span>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="deliveryAddress">
                                <i class="fa-solid fa-location-dot"></i>
                                Địa chỉ giao hàng
                            </label>
                            <input type="text" id="deliveryAddress" name="deliveryAddress"
                                   class="form-input" placeholder="Nhập địa chỉ nhận hàng của bạn"
                                   value="${sessionScope.deliveryAddress}" required/>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="paymentMethod">
                                <i class="fa-solid fa-credit-card"></i>
                                Phương thức thanh toán
                            </label>
                            <div class="select-wrapper">
                                <c:set var="pm" value="${sessionScope.paymentMethod}"/>

                                <select id="paymentMethod" name="paymentMethod" class="form-select">
                                    <option value="COD" ${pm=='COD' ?selected:''}>💵 Thanh toán khi nhận
                                        hàng (COD)
                                    </option>
                                    <option value="Card" ${pm=='Card' ?selected:''}>💳 Thanh toán bằng
                                        thẻ
                                    </option>
                                </select>
                                <i class="fa-solid fa-chevron-down select-arrow"></i>
                            </div>
                        </div>
                    </div>

                    <!-- Chi tiết đơn hàng -->
                    <div class="form-section">
                        <div class="form-section-header">
                            <i class="fa-solid fa-receipt"></i>
                            <span>Chi tiết thanh toán</span>
                        </div>

                        <div class="summary-row">
                            <span class="label">Giá trị đơn hàng</span>
                            <span class="value" id="subtotal">
                                                <fmt:formatNumber value="${sessionScope.cart.getTotalPrice()}"
                                                                  type="currency" currencySymbol="đ"/>
                                            </span>
                        </div>

                        <div class="summary-row discount-row">
                            <span class="label">Tiết kiệm với mã giảm</span>
                            <span class="value discount-value" id="discount">
                                                <fmt:formatNumber value="${sessionScope.discountAmount}" type="currency"
                                                                  currencySymbol="đ"/>
                                            </span>
                        </div>

                        <div class="summary-row total">
                            <span class="label">Tổng thanh toán</span>
                            <span class="value" id="total">
                                                <fmt:formatNumber value="${sessionScope.finalPrice}" type="currency"
                                                                  currencySymbol="đ"/>
                                            </span>
                        </div>
                    </div>

                    <!-- Submit button -->
                    <button type="submit" class="submit-btn">
                        <i class="fa-solid fa-lock"></i>
                        Xác nhận thanh toán
                    </button>
                    <p class="secure-notice">
                        <i class="fa-solid fa-shield-halved"></i>
                        Giao dịch được bảo mật an toàn
                    </p>

                </form>
            </div>

        </c:otherwise>
    </c:choose>
    <c:if test="${param.paid == '1'}">
        <script>
            Swal.fire({
                icon: 'success',
                title: 'Thanh toán thành công!',
                text: 'Mã đơn hàng: <fmt:formatNumber value="${param.orderId}" pattern="000"/>'
            });
        </script>
    </c:if>

    <c:if test="${param.paid == '0'}">
        <script>
            Swal.fire({
                icon: 'error',
                title: 'Oops! Sản phẩm không đủ số lượng',
                text: 'Số lượng sản phẩm vượt quá tồn kho',
                confirmButtonText: 'Đã hiểu'
            });
        </script>
        <% session.removeAttribute("stockError"); %>
    </c:if>

    <c:if test="${not empty requestScope.error}">
        <script>
            if (window.Swal) {
                Swal.fire({
                    icon: 'error',
                    title: 'Lỗi tạo đơn hàng',
                    text: '${requestScope.error}',
                    confirmButtonText: 'Đã hiểu'
                });
            } else {
                alert('${requestScope.error}');
            }
        </script>
    </c:if>

    <c:if test="${not empty sessionScope.signOrderId}">
        <style>
            .sign-popup-hash span {
                display: block;
                margin-bottom: 0.45rem;
                color: #1e40af;
                font-size: 0.8rem;
                font-weight: 700;
                text-transform: uppercase;
            }

            .sign-popup-hash code {
                display: block;
                color: #0f172a;
                font-size: 0.85rem;
                line-height: 1.45;
                white-space: normal;
                word-break: break-all;
            }

        </style>
        <script>
            function disablePrivateKeyButton(btn) {
                setTimeout(function () {
                    btn.classList.add('disabled');
                    btn.removeAttribute('href');
                    btn.removeAttribute('onclick');
                    btn.innerHTML = '<i class="fa-solid fa-lock"></i> Bạn đã tải private key';
                    btn.style.pointerEvents = 'none';
                    btn.style.opacity = '0.6';
                    btn.style.cursor = 'not-allowed';
                }, 300);
            }

            if (!window.Swal) {
                window.Swal = {
                    fire: function (options) {
                        const overlay = document.createElement('div');
                        overlay.className = 'sign-popup-fallback';
                        overlay.innerHTML =
                            '<div class="sign-popup-fallback-panel">' +
                            '<button type="button" class="sign-popup-close" aria-label="Dong">&times;</button>' +
                            '<h2>' + (options.title || '') + '</h2>' +
                            (options.html || '<p>' + (options.text || '') + '</p>') +
                            '</div>';
                        overlay.querySelector('.sign-popup-close').addEventListener('click', function () {
                            overlay.remove();
                        });
                        document.body.appendChild(overlay);
                    }
                };
            }

            Swal.fire({
                icon: 'info',
                title: 'Đơn hàng #${sessionScope.signOrderId} đang chờ ký',
                width: 760,
                showConfirmButton: false,
                showCloseButton: true,
                allowOutsideClick: false,
                customClass: {
                    popup: 'sign-swal-popup',
                    title: 'sign-swal-title',
                    htmlContainer: 'sign-swal-html',
                    closeButton: 'sign-swal-close'
                },
                html: `
                                    <div class="sign-popup-content">
                                        <p class="sign-popup-desc">
                                            Đơn hàng đã được tạo ở trạng thái <strong>CHỜ KÝ</strong>.
                                            Vui lòng tải dữ liệu đơn hàng, ký bằng private key, rồi upload file chữ ký để hoàn tất xác nhận.
                                        </p>

                                        <div class="sign-popup-hash">
                                            <span>Order Hash (SHA-256)</span>
                                            <code>${sessionScope.signOrderHash}</code>
                                        </div>

                                        <div class="sign-popup-steps">
    <a class="sign-step-card primary"
       href="${pageContext.request.contextPath}${sessionScope.signingUrl}">
        <div class="sign-step-icon">
            <i class="fa-solid fa-file-arrow-down"></i>
        </div>
        <div class="sign-step-text">
            <strong>1. Tải dữ liệu đơn hàng để ký</strong>
            <span>Tải dữ liệu đã băm của đơn hàng về máy.</span>
        </div>
    </a>

    <a class="sign-step-card"
       href="${pageContext.request.contextPath}/order-sign/tool?orderId=${sessionScope.signOrderId}">
        <div class="sign-step-icon">
            <i class="fa-solid fa-screwdriver-wrench"></i>
        </div>
        <div class="sign-step-text">
            <strong>2. Tải tool ký</strong>
            <span>Dùng tool để ký dữ liệu đơn hàng bằng private key.</span>
        </div>
    </a>

    <a class="sign-step-card success"
       href="${pageContext.request.contextPath}/upload-signature" target="_blank">
        <div class="sign-step-icon">
            <i class="fa-solid fa-cloud-arrow-up"></i>
        </div>
        <div class="sign-step-text">
            <strong>3. Upload chữ ký</strong>
            <span>Tải file chữ ký lên để hoàn tất xác nhận.</span>
        </div>
    </a>
</div>

<div class="sign-key-box">
    <div class="sign-key-main">
        <div class="sign-key-icon">
            <i class="fa-solid fa-key"></i>
        </div>

        <div class="sign-key-text">
            <strong>Private key của bạn</strong>

            <c:choose>
                <c:when test="${not empty sessionScope.privateKeyUrl}">
                    <span>Hệ thống vừa cấp private key mới. Hãy tải ngay và lưu ở nơi an toàn.</span>
                </c:when>

                <c:otherwise>
                    <span>Hãy dùng file private key đã lưu trên máy cá nhân để ký đơn hàng.</span>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

                                            <div class="sign-key-actions">
                                                <c:choose>
                                                    <c:when test="${not empty sessionScope.privateKeyUrl}">
                                                        <a id="downloadPrivateKeyBtn"
                                                           class="sign-key-btn"
                                                           href="${pageContext.request.contextPath}${sessionScope.privateKeyUrl}"
                                                           onclick="disablePrivateKeyButton(this)">
                                                            <i class="fa-solid fa-download"></i>
                                                            Tải private key
                                                        </a>
                                                    </c:when>

                                                    <c:otherwise>
                                                        <button type="button"
                                                                class="sign-key-btn disabled"
                                                                disabled>
                                                            <i class="fa-solid fa-lock"></i>
                                                            Đã lưu trên máy
                                                        </button>
                                                    </c:otherwise>
                                                </c:choose>

                                                <a class="sign-lost-key-link"
                                                   href="${pageContext.request.contextPath}/security-key?lostKey=1">
                                                    <i class="fa-solid fa-triangle-exclamation"></i>
                                                    Tôi bị mất private key
                                                </a>
                                            </div>
                                        </div>

                                        <p class="sign-popup-note">
                                            Private key chỉ nên tải một lần khi hệ thống vừa cấp key mới. Nếu bạn đã có private key,
                                            hãy dùng key đang lưu trên máy cá nhân để ký order hash.
                                        </p>
                                    </div>
                                `
            });
        </script>
        <c:remove var="showSignPopup" scope="session"/>
        <c:remove var="signOrderId" scope="session"/>
        <c:remove var="signOrderHash" scope="session"/>
        <c:remove var="signingUrl" scope="session"/>
        <c:remove var="privateKeyUrl" scope="session"/>
    </c:if>

</div>
<script src="${pageContext.request.contextPath}/js/header.js"></script>
<script src="${pageContext.request.contextPath}/js/cart.js"></script>
</body>

</html>
