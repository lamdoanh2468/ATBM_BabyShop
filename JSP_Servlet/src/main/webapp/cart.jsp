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

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css"
          integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw=="
          crossorigin="anonymous"
          referrerpolicy="no-referrer"/>

    <link rel="stylesheet" href="../fontawesome-free-7.1.0-web/css/all.min.css"/>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <link rel="stylesheet"
          type="text/css"
          href="${pageContext.request.contextPath}/css/cartStyle.css?v=sign-popup-3"/>

    <style>
        .sign-popup-content {
            text-align: left;
        }

        .sign-popup-desc {
            color: #334155;
            line-height: 1.6;
            margin-bottom: 1rem;
        }

        .sign-popup-hash {
            background: #eff6ff;
            border: 1px solid #bfdbfe;
            border-radius: 12px;
            padding: 0.85rem 1rem;
            margin-bottom: 1rem;
        }

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

        .sign-popup-steps {
            display: grid;
            gap: 0.75rem;
            margin-top: 1rem;
        }

        .sign-step-card {
            display: block;
            text-decoration: none;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 0.85rem 1rem;
            color: #0f172a;
            background: #ffffff;
            transition: 0.2s ease;
        }

        .sign-step-card:hover {
            border-color: #6366f1;
            background: #f8fafc;
        }

        .sign-step-card.primary {
            border-color: #6366f1;
            background: #eef2ff;
        }

        .sign-step-card.success {
            border-color: #10b981;
            background: #ecfdf5;
        }

        .sign-step-card.warning {
            border-color: #f59e0b;
            background: #fffbeb;
        }

        .sign-step-card strong {
            display: block;
            margin-bottom: 0.25rem;
        }

        .sign-step-card span {
            display: block;
            font-size: 0.85rem;
            color: #475569;
        }

        .sign-upload-box {
            border: 1px dashed #94a3b8;
            border-radius: 12px;
            padding: 1rem;
            background: #f8fafc;
        }

        .sign-upload-box label {
            display: block;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 0.5rem;
        }

        .sign-upload-box input[type="file"] {
            width: 100%;
            margin-bottom: 0.75rem;
        }

        #signStatusBox {
            margin-top: 0.75rem;
            font-size: 0.9rem;
            color: #334155;
        }

        .sign-status-error {
            color: #dc2626;
            font-weight: 600;
        }

        .sign-status-loading {
            color: #2563eb;
            font-weight: 600;
        }
    </style>
</head>

<body>
<jsp:include page="header.jsp"/>

<nav class="breadcrumb-nav">
    <a href="${pageContext.request.contextPath}/">Trang chủ</a>
    <span class="dot">•</span>
    <a href="${pageContext.request.contextPath}/cart">Giỏ hàng</a>
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
                    <span class="cart-items-count">
                        ${sessionScope.cart.getTotalQuantity()} sản phẩm
                    </span>

                    <button onclick="location.href='cart?action=remove_all'"
                            class="clear-cart-btn">
                        🗑 Xoá tất cả
                    </button>
                </div>

                <c:forEach var="item" items="${sessionScope.cart.items}">
                    <div class="cart-item">
                        <div>
                            <img class="item-image"
                                 src="${item.product.productImage}"
                                 alt="${item.product.productName}"/>
                        </div>

                        <div class="item-details">
                            <h3 class="item-title">${item.product.productName}</h3>

                            <p class="item-variant">
                                Mã SP:
                                <c:choose>
                                    <c:when test="${item.product.productId < 10}">
                                        00${item.product.productId}
                                    </c:when>
                                    <c:when test="${item.product.productId < 100}">
                                        0${item.product.productId}
                                    </c:when>
                                    <c:otherwise>
                                        ${item.product.productId}
                                    </c:otherwise>
                                </c:choose>
                            </p>

                            <div class="item-price">
                                <span class="current-price">
                                    <fmt:setLocale value="vi_VN"/>
                                    <fmt:formatNumber value="${item.price}"
                                                      type="number"
                                                      groupingUsed="true"/>đ
                                </span>
                            </div>
                        </div>

                        <div class="item-actions">
                            <button type="button"
                                    class="delete-btn"
                                    title="Xóa sản phẩm"
                                    onclick="location.href='cart?action=remove&product_id=${item.product.productId}'">
                                <i class="fa-solid fa-trash"></i>
                            </button>

                            <div class="quantity-control">
                                <button type="button"
                                        class="quantity-btn"
                                        onclick="decreaseUI(${item.product.productId})">
                                    −
                                </button>

                                <input type="text"
                                       class="quantity-input"
                                       value="${item.quantity}"
                                       id="quantity-${item.product.productId}"
                                       readonly/>

                                <button type="button"
                                        class="quantity-btn"
                                        onclick="increaseUI(${item.product.productId})">
                                    +
                                </button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <div class="order-summary">
                <h2 class="summary-title">Thông tin thanh toán</h2>

                <form id="checkoutForm"
                      method="post"
                      action="${pageContext.request.contextPath}/order"
                      class="checkout-form">

                    <div class="form-section voucher-section">
                        <div class="form-section-header">
                            <i class="fa-solid fa-ticket"></i>
                            <span>Mã giảm giá</span>
                        </div>

                        <c:choose>
                            <c:when test="${not empty sessionScope.voucherCode}">
                                <div class="voucher-applied">
                                    <div class="voucher-tag">
                                        <i class="fa-solid fa-check-circle"></i>
                                        <span class="voucher-code">${sessionScope.voucherCode}</span>

                                        <input type="hidden"
                                               name="voucherCode"
                                               value="${sessionScope.voucherCode}"/>
                                    </div>

                                    <button type="submit"
                                            name="action"
                                            value="removeVoucher"
                                            class="remove-voucher-btn"
                                            formaction="${pageContext.request.contextPath}/order"
                                            formnovalidate>
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
                                <div class="voucher-input-wrapper">
                                    <input type="text"
                                           name="voucherCode"
                                           class="voucher-input"
                                           placeholder="Nhập mã voucher"/>

                                    <button type="submit"
                                            name="action"
                                            value="applyVoucher"
                                            class="voucher-apply-btn"
                                            formaction="${pageContext.request.contextPath}/order"
                                            formnovalidate>
                                        Áp dụng
                                    </button>
                                </div>
                            </c:otherwise>
                        </c:choose>

                        <c:if test="${not empty requestScope.voucherError}">
                            <div class="voucher-error">
                                <i class="fa-solid fa-exclamation-circle"></i>
                                    ${voucherError}
                            </div>
                        </c:if>
                    </div>

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

                            <input type="text"
                                   id="deliveryAddress"
                                   name="deliveryAddress"
                                   class="form-input"
                                   placeholder="Nhập địa chỉ nhận hàng của bạn"
                                   value="${sessionScope.deliveryAddress}"
                                   required/>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="paymentMethod">
                                <i class="fa-solid fa-credit-card"></i>
                                Phương thức thanh toán
                            </label>

                            <div class="select-wrapper">
                                <c:set var="pm" value="${sessionScope.paymentMethod}"/>

                                <select id="paymentMethod"
                                        name="paymentMethod"
                                        class="form-select">
                                    <option value="COD" ${pm == 'COD' ? 'selected' : ''}>
                                        💵 Thanh toán khi nhận hàng (COD)
                                    </option>

                                    <option value="Card" ${pm == 'Card' ? 'selected' : ''}>
                                        💳 Thanh toán bằng thẻ
                                    </option>
                                </select>

                                <i class="fa-solid fa-chevron-down select-arrow"></i>
                            </div>
                        </div>
                    </div>

                    <div class="form-section">
                        <div class="form-section-header">
                            <i class="fa-solid fa-receipt"></i>
                            <span>Chi tiết thanh toán</span>
                        </div>

                        <div class="summary-row">
                            <span class="label">Giá trị đơn hàng</span>
                            <span class="value" id="subtotal">
                                <fmt:formatNumber value="${sessionScope.cart.getTotalPrice()}"
                                                  type="currency"
                                                  currencySymbol="đ"/>
                            </span>
                        </div>

                        <div class="summary-row discount-row">
                            <span class="label">Tiết kiệm với mã giảm</span>
                            <span class="value discount-value" id="discount">
                                <fmt:formatNumber value="${sessionScope.discountAmount}"
                                                  type="currency"
                                                  currencySymbol="đ"/>
                            </span>
                        </div>

                        <div class="summary-row total">
                            <span class="label">Tổng thanh toán</span>
                            <span class="value" id="total">
                                <fmt:formatNumber value="${sessionScope.finalPrice}"
                                                  type="currency"
                                                  currencySymbol="đ"/>
                            </span>
                        </div>
                    </div>

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
                icon: "success",
                title: "Thanh toán thành công!",
                text: "Mã đơn hàng: <fmt:formatNumber value="${param.orderId}" pattern="000"/>"
            });
        </script>
    </c:if>

    <c:if test="${param.paid == '0'}">
        <script>
            Swal.fire({
                icon: "error",
                title: "Oops! Sản phẩm không đủ số lượng",
                text: "Số lượng sản phẩm vượt quá tồn kho",
                confirmButtonText: "Đã hiểu"
            });
        </script>

        <% session.removeAttribute("stockError"); %>
    </c:if>

    <c:if test="${not empty requestScope.error}">
        <script>
            if (window.Swal) {
                Swal.fire({
                    icon: "error",
                    title: "Lỗi tạo đơn hàng",
                    text: "${requestScope.error}",
                    confirmButtonText: "Đã hiểu"
                });
            } else {
                alert("${requestScope.error}");
            }
        </script>
    </c:if>
</div>

<script>
    const CONTEXT_PATH = "${pageContext.request.contextPath}";
    const checkoutForm = document.getElementById("checkoutForm");

    if (checkoutForm) {
        checkoutForm.addEventListener("submit", async function (event) {
            const submitter = event.submitter;

            if (submitter && submitter.name === "action") {
                return;
            }

            event.preventDefault();

            const params = new URLSearchParams();

            const deliveryAddressInput = document.getElementById("deliveryAddress");
            const paymentMethodInput = document.getElementById("paymentMethod");
            const voucherInput = checkoutForm.querySelector("input[name='voucherCode']");

            const deliveryAddress = deliveryAddressInput ? deliveryAddressInput.value.trim() : "";
            const paymentMethod = paymentMethodInput ? paymentMethodInput.value : "COD";
            const voucherCode = voucherInput ? voucherInput.value.trim() : "";

            if (!deliveryAddress) {
                Swal.fire({
                    icon: "warning",
                    title: "Thiếu địa chỉ giao hàng",
                    text: "Vui lòng nhập địa chỉ giao hàng.",
                    confirmButtonText: "Đã hiểu"
                });
                return;
            }

            params.set("deliveryAddress", deliveryAddress);
            params.set("paymentMethod", paymentMethod);

            if (voucherCode) {
                params.set("voucherCode", voucherCode);
            }

            console.log("Params gửi lên:", params.toString());


            Swal.fire({
                title: "Đang tạo đơn hàng...",
                text: "Vui lòng không đóng trang.",
                allowOutsideClick: false,
                allowEscapeKey: false,
                showConfirmButton: false,
                showCloseButton: false,
                didOpen: function () {
                    Swal.showLoading();
                }
            });

            try {
                const checkoutUrl = checkoutForm.getAttribute("action") || CONTEXT_PATH + "/order";

                const response = await fetch(checkoutUrl, {
                    method: "POST",
                    body: params,
                    headers: {
                        "X-Requested-With": "XMLHttpRequest",
                        "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8"
                    }
                });

                const data = await readJsonResponse(response);

                if (!data.success) {
                    Swal.fire({
                        icon: "error",
                        title: "Không thể tạo đơn hàng",
                        text: data.message || "Vui lòng thử lại.",
                        confirmButtonText: "Đã hiểu"
                    });
                    return;
                }

                showSigningPopup(data);
            } catch (error) {
                Swal.fire({
                    icon: "error",
                    title: "Lỗi kết nối",
                    text: error.message || "Không thể gửi yêu cầu thanh toán.",
                    confirmButtonText: "Đã hiểu"
                });
            }
        });
    }

    function showSigningPopup(orderData) {
        const orderId = Number(orderData.orderId);
        const orderHash = orderData.orderHash || "";
        const signingUrl = orderData.signingUrl || "#";
        const signToolUrl = orderData.signToolUrl || (CONTEXT_PATH + "/signing-tool/download");
        const privateKeyUrl = normalizeAppUrl(orderData.privateKeyUrl || "");

        let privateKeyHtml = "";

        if (privateKeyUrl) {
            privateKeyHtml =
                '<a class="sign-step-card warning" href="' + escapeAttr(privateKeyUrl) + '">' +
                '   <strong>3. Tải private key</strong>' +
                '   <span>Private key chỉ nên tải một lần. Hãy lưu ở nơi an toàn.</span>' +
                '</a>';
        } else {
            privateKeyHtml =
                '<div class="sign-step-card">' +
                '   <strong>3. Dùng private key đã lưu</strong>' +
                '   <span>Nếu bạn vẫn còn private key, hãy dùng file đó để ký đơn hàng.</span>' +
                '   <button type="button" id="btnReissuePrivateKey" class="sign-lost-key-link">' +
                '       Tôi mất private key - cấp lại key mới' +
                '   </button>' +
                '</div>';
        }

        const html =
            '<div class="sign-popup-content">' +
            '   <p class="sign-popup-desc">' +
            '       Đơn hàng đã được tạo ở trạng thái <strong>CHỜ KÝ</strong>. ' +
            '       Vui lòng tải dữ liệu đơn hàng, ký bằng private key, rồi upload file chữ ký để xác minh.' +
            '   </p>' +

            '   <div class="sign-popup-hash">' +
            '       <span>Order Hash SHA-256</span>' +
            '       <code id="orderHashCode">' + escapeHtml(orderHash) + '</code>' +
            '       <div style="margin-top:0.5rem;">' +
            '           <button type="button" id="btnDownloadHash" class="sign-download-hash-btn" data-order-id="' + escapeAttr(String(orderId)) + '" data-order-hash="' + escapeAttr(orderHash) + '">Tải hash</button>' +
            '       </div>' +
            '   </div>' +

            '   <div class="sign-popup-steps">' +
            '       <a class="sign-step-card primary" href="' + escapeAttr(signingUrl) + '">' +
            '           <strong>1. Tải dữ liệu đơn hàng</strong>' +
            '           <span>Tải file dữ liệu đơn hàng để ký bằng công cụ ký.</span>' +
            '       </a>' +

            '       <a class="sign-step-card" href="' + escapeAttr(signToolUrl) + '">' +
            '           <strong>2. Tải tool ký</strong>' +
            '           <span>Dùng tool để ký order hash bằng private key.</span>' +
            '       </a>' +

            privateKeyHtml +

            '       <div class="sign-upload-box">' +
            '           <label for="signedOrderFile">4. Upload file chữ ký</label>' +
            '           <input id="signedOrderFile" type="file" accept=".json,application/json">' +
            '           <button type="button" id="btnUploadSignature" class="swal2-confirm swal2-styled">' +
            '               Upload chữ ký' +
            '           </button>' +
            '           <div id="signStatusBox"></div>' +
            '       </div>' +
            '   </div>' +
            '</div>';

        Swal.fire({
            icon: "info",
            title: "Đơn hàng #" + orderId + " đang chờ ký",
            width: 760,
            allowOutsideClick: false,
            allowEscapeKey: false,
            showCloseButton: false,
            showConfirmButton: false,
            html: html,
            didOpen: function () {
                const btnUploadSignature = document.getElementById("btnUploadSignature");
                const btnReissuePrivateKey = document.getElementById("btnReissuePrivateKey");

                const btnDownloadHash = document.getElementById("btnDownloadHash");

                if (btnDownloadHash) {
                    btnDownloadHash.addEventListener("click", function () {
                        const oid = this.getAttribute("data-order-id");
                        const hash = this.getAttribute("data-order-hash") || "";
                        downloadOrderHash(oid, hash);
                    });
                }

                if (btnUploadSignature) {
                    btnUploadSignature.addEventListener("click", function () {
                        uploadSignature(orderId);
                    });
                }

                if (btnReissuePrivateKey) {
                    btnReissuePrivateKey.addEventListener("click", function () {
                        reissuePrivateKey(orderData);
                    });
                }
            }
        });
    }

    async function uploadSignature(orderId) {
        const fileInput = document.getElementById("signedOrderFile");
        const statusBox = document.getElementById("signStatusBox");

        if (!fileInput || !fileInput.files || fileInput.files.length === 0) {
            if (statusBox) {
                statusBox.innerHTML =
                    '<p class="sign-status-error">Vui lòng chọn file signed_order.json.</p>';
            }
            return;
        }

        const file = fileInput.files[0];

        if (!file.name.toLowerCase().endsWith(".json")) {
            if (statusBox) {
                statusBox.innerHTML =
                    '<p class="sign-status-error">Hệ thống chỉ nhận file .json.</p>';
            }
            return;
        }

        const formData = new FormData();
        formData.append("orderId", orderId);
        formData.append("signedOrderFile", file);

        if (statusBox) {
            statusBox.innerHTML =
                '<p class="sign-status-loading">' +
                '<i class="fa-solid fa-circle-notch fa-spin"></i> Đang xác minh chữ ký...' +
                '</p>';
        }

        try {
            const response = await fetch(CONTEXT_PATH + "/upload-signature", {
                method: "POST",
                body: formData,
                headers: {
                    "X-Requested-With": "XMLHttpRequest"
                }
            });

            const data = await readJsonResponse(response);

            if (!data.success) {
                Swal.fire({
                    icon: "error",
                    title: "Xác minh thất bại",
                    text: data.message || "Chữ ký không hợp lệ hoặc dữ liệu đơn hàng đã bị thay đổi.",
                    allowOutsideClick: false,
                    allowEscapeKey: false,
                    showCloseButton: false,
                    confirmButtonText: "Thử lại"
                }).then(function () {
                    showSigningPopup({
                        orderId: orderId,
                        orderHash: data.orderHash || "",
                        signingUrl: data.signingUrl || "#",
                        signToolUrl: data.signToolUrl || (CONTEXT_PATH + "/signing-tool/download"),
                        privateKeyUrl: normalizeAppUrl(data.privateKeyUrl || "/security-key/download-private-key")
                    });
                });
                return;
            }

            Swal.fire({
                icon: "success",
                title: "Chữ ký hợp lệ",
                text: "Đơn hàng đã được xác minh. Đang chờ admin xử lý...",
                allowOutsideClick: false,
                allowEscapeKey: false,
                showCloseButton: false,
                showConfirmButton: false,
                didOpen: function () {
                    Swal.showLoading();
                }
            });

            pollOrderStatus(orderId);
        } catch (error) {
            Swal.fire({
                icon: "error",
                title: "Lỗi upload chữ ký",
                text: error.message || "Không thể upload hoặc xác minh chữ ký.",
                confirmButtonText: "Đã hiểu"
            });
        }
    }

    function pollOrderStatus(orderId) {
        const timer = setInterval(async function () {
            try {
                const response = await fetch(CONTEXT_PATH + "/order/status?orderId=" + encodeURIComponent(orderId), {
                    headers: {
                        "X-Requested-With": "XMLHttpRequest"
                    }
                });

                const data = await readJsonResponse(response);

                if (!data.success) {
                    return;
                }

                const status = data.status;

                if (status === "DONE") {
                    clearInterval(timer);

                    Swal.fire({
                        icon: "success",
                        title: "Đơn hàng đã hoàn tất",
                        text: "Admin đã xác nhận hoàn tất đơn hàng.",
                        confirmButtonText: "Xem đơn hàng",
                        allowOutsideClick: false,
                        allowEscapeKey: false,
                        showCloseButton: false
                    }).then(function () {
                        window.location.href = CONTEXT_PATH + "/bought-product";
                    });
                }

                if (status === "TAMPERED" || status === "SIGNATURE_INVALID") {
                    clearInterval(timer);

                    Swal.fire({
                        icon: "error",
                        title: "Chữ ký hoặc dữ liệu đơn hàng không hợp lệ",
                        text: "Admin đã xác nhận đơn hàng/chữ ký có dấu hiệu bị sửa đổi.",
                        confirmButtonText: "Xem đơn hàng",
                        allowOutsideClick: false,
                        allowEscapeKey: false,
                        showCloseButton: false
                    }).then(function () {
                        window.location.href = CONTEXT_PATH + "/bought-product";
                    });
                }

                if (status === "CANCELLED") {
                    clearInterval(timer);

                    Swal.fire({
                        icon: "warning",
                        title: "Đơn hàng đã bị hủy",
                        text: "Đơn hàng không thể tiếp tục xử lý.",
                        confirmButtonText: "Xem đơn hàng",
                        allowOutsideClick: false,
                        allowEscapeKey: false,
                        showCloseButton: false
                    }).then(function () {
                        window.location.href = CONTEXT_PATH + "/bought-product";
                    });
                }
                if (status === "VERIFIED") {
                    clearInterval(timer);

                    Swal.fire({
                        icon: "success",
                        title: "Ký điện tử thành công",
                        text: "Chữ ký đã được xác minh. Đơn hàng đang chờ admin xử lý.",
                        confirmButtonText: "Xem đơn hàng",
                        allowOutsideClick: false,
                        allowEscapeKey: false,
                        showCloseButton: false
                    }).then(function () {
                        window.location.href = CONTEXT_PATH + "/bought-product";
                    });
                }
            } catch (error) {
                console.error("Lỗi khi lấy trạng thái đơn hàng:", error);
            }
        }, 3000);
    }

    async function readJsonResponse(response) {
        const contentType = response.headers.get("content-type") || "";

        if (!contentType.includes("application/json")) {
            throw new Error("Server không trả JSON. Hãy kiểm tra lại.");
        }

        const data = await response.json();

        if (!response.ok) {
            throw new Error(data.message || "Request thất bại.");
        }

        return data;
    }

    function normalizeAppUrl(value) {
        if (!value) {
            return "";
        }

        if (value.startsWith("http://") || value.startsWith("https://")) {
            return value;
        }

        if (CONTEXT_PATH && value.startsWith(CONTEXT_PATH + "/")) {
            return value;
        }

        if (value.startsWith("/")) {
            return CONTEXT_PATH + value;
        }

        return value;
    }

    function escapeHtml(value) {
        return String(value)
            .replaceAll("&", "&amp;")
            .replaceAll("<", "&lt;")
            .replaceAll(">", "&gt;")
            .replaceAll('"', "&quot;")
            .replaceAll("'", "&#039;");
    }

    function escapeAttr(value) {
        return escapeHtml(value);
    }

    function downloadOrderHash(orderId, orderHash) {
        try {
            const filename = 'order_hash_' + String(orderId) + '.txt';
            const blob = new Blob([orderHash || ''], {type: 'text/plain;charset=utf-8'});

            if (window.navigator && window.navigator.msSaveOrOpenBlob) {
                window.navigator.msSaveOrOpenBlob(blob, filename);
                return;
            }

            const url = URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = filename;
            document.body.appendChild(a);
            a.click();
            document.body.removeChild(a);
            URL.revokeObjectURL(url);
        } catch (e) {
            console.error('Không thể tải hash:', e);
            Swal.fire({icon: 'error', title: 'Lỗi', text: 'Không thể tạo file hash.'});
        }
    }

    <c:if test="${not empty sessionScope.signOrderId}">
    window.addEventListener("load", function () {
        showSigningPopup({
            orderId: Number("${sessionScope.signOrderId}"),
            orderHash: "${sessionScope.signOrderHash}",
            signingUrl: "${pageContext.request.contextPath}${sessionScope.signingUrl}",
            signToolUrl: "${pageContext.request.contextPath}/signing-tool/download",
            privateKeyUrl: "${not empty sessionScope.privateKeyUrl ? pageContext.request.contextPath : ''}${not empty sessionScope.privateKeyUrl ? sessionScope.privateKeyUrl : ''}"
        });
    });
    </c:if>

    async function reissuePrivateKey(orderData) {
        const statusBox = document.getElementById("signStatusBox");

        const confirmResult = await Swal.fire({
            icon: "warning",
            title: "Tạo private key mới?",
            html:
                "Private key cũ sẽ được xem như đã mất.<br>" +
                "Chứng thư hiện tại sẽ bị thu hồi và hệ thống sẽ cấp cặp khóa mới.<br><br>" +
                "<strong>Bạn phải tải private key mới và lưu lại an toàn.</strong>",
            showCancelButton: true,
            confirmButtonText: "Tạo key mới",
            cancelButtonText: "Hủy",
            confirmButtonColor: "#f59e0b",
            allowOutsideClick: false,
            allowEscapeKey: false,
            showCloseButton: false
        });

        if (!confirmResult.isConfirmed) {
            showSigningPopup(orderData);
            return;
        }

        Swal.fire({
            title: "Đang tạo private key mới...",
            text: "Vui lòng không đóng trang.",
            allowOutsideClick: false,
            allowEscapeKey: false,
            showConfirmButton: false,
            showCloseButton: false,
            didOpen: function () {
                Swal.showLoading();
            }
        });

        try {
            const params = new URLSearchParams();
            params.set("orderId", orderData.orderId);

            const response = await fetch(CONTEXT_PATH + "/security-key/reissue", {
                method: "POST",
                body: params,
                headers: {
                    "X-Requested-With": "XMLHttpRequest",
                    "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8"
                }
            });

            const data = await readJsonResponse(response);

            if (!data.success) {
                Swal.fire({
                    icon: "error",
                    title: "Không thể tạo key mới",
                    text: data.message || "Vui lòng thử lại.",
                    confirmButtonText: "Đã hiểu",
                    allowOutsideClick: false,
                    allowEscapeKey: false,
                    showCloseButton: false
                }).then(function () {
                    showSigningPopup(orderData);
                });
                return;
            }

            showSigningPopup({
                orderId: orderData.orderId,
                orderHash: data.orderHash || orderData.orderHash || "",
                signingUrl: data.signingUrl || orderData.signingUrl || "#",
                signToolUrl: data.signToolUrl || orderData.signToolUrl || (CONTEXT_PATH + "/signing-tool/download"),
                privateKeyUrl: normalizeAppUrl(data.privateKeyUrl || "/security-key/download-private-key")
            });
        } catch (error) {
            Swal.fire({
                icon: "error",
                title: "Lỗi tạo private key mới",
                text: error.message || "Không thể tạo private key mới.",
                confirmButtonText: "Đã hiểu",
                allowOutsideClick: false,
                allowEscapeKey: false,
                showCloseButton: false
            }).then(function () {
                showSigningPopup(orderData);
            });
        }
    }
</script>

<script src="${pageContext.request.contextPath}/js/header.js"></script>
<script src="${pageContext.request.contextPath}/js/cart.js"></script>
</body>

</html>