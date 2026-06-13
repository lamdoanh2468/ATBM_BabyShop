<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="currentOrderId" value="${empty orderId ? param.orderId : orderId}" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ký điện tử đơn hàng</title>

    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/favicon.ico">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/orderSign.css">
</head>

<body>
<jsp:include page="header.jsp" />

<nav class="breadcrumb-nav">
    <a href="${pageContext.request.contextPath}/">Trang chủ</a>
    <span class="dot">•</span>
    <a href="${pageContext.request.contextPath}/cart">Giỏ hàng</a>
    <span class="dot">•</span>
    <span>Ký điện tử đơn hàng</span>
</nav>

<main class="sign-page">
    <section class="sign-panel">

        <div class="sign-status-card">
            <div class="status-icon">
                <i class="fa-solid fa-file-signature"></i>
            </div>

            <div class="status-copy">
                <p class="eyebrow">Đơn hàng đang chờ ký</p>

                <c:choose>
                    <c:when test="${not empty currentOrderId}">
                        <h1>Đơn hàng #${currentOrderId} đang chờ chữ ký điện tử.</h1>
                        <p>
                            Tải tool ký và file thông tin đơn hàng, ký bằng private key của bạn,
                            sau đó vào mục tải chữ ký điện tử để upload file đã ký có dạng <strong>signed_order.json</strong>.
                        </p>
                    </c:when>
                    <c:otherwise>
                        <h1>Không tìm thấy mã đơn hàng cần ký.</h1>
                        <p>Vui lòng quay lại trang đơn hàng hoặc giỏ hàng để thực hiện lại thao tác.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <c:if test="${empty currentOrderId}">
            <div class="notice error">
                <i class="fa-solid fa-circle-xmark"></i>
                Thiếu mã đơn hàng. Không thể tải dữ liệu ký.
            </div>
        </c:if>

        <c:if test="${not empty errorMessage}">
            <div class="notice error">
                <i class="fa-solid fa-circle-xmark"></i>
                ${errorMessage}
            </div>
        </c:if>

        <div class="sign-grid">
            <section class="download-box">
                <h2>
                    <i class="fa-solid fa-download"></i>
                    Tải dữ liệu ký đơn hàng
                </h2>

                <div class="order-meta">
                    <div>
                        <span>Mã đơn hàng</span>
                        <strong>
                            <c:choose>
                                <c:when test="${not empty currentOrderId}">#${currentOrderId}</c:when>
                                <c:otherwise>Không có</c:otherwise>
                            </c:choose>
                        </strong>
                    </div>

                    <div>
                        <span>Thuật toán hash</span>
                        <strong>
                            <c:choose>
                                <c:when test="${not empty orderToSign.hashAlgorithm}">${orderToSign.hashAlgorithm}</c:when>
                                <c:otherwise>SHA-256</c:otherwise>
                            </c:choose>
                        </strong>
                    </div>

                    <div>
                        <span>Trạng thái</span>
                        <strong>WAITING_SIGNATURE</strong>
                    </div>
                </div>

                <div class="hash-preview">
                    <span>Order Hash:</span>
                    <c:choose>
                        <c:when test="${not empty orderToSign.orderHash}">
                            <code>${orderToSign.orderHash}</code>
                        </c:when>
                        <c:otherwise>
                            <code>Hash sẽ được tải trong file order_to_sign.json.</code>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="download-actions">
                    <a class="download-btn primary"
                       href="${pageContext.request.contextPath}/signing-tool/download">
                        <i class="fa-solid fa-toolbox"></i>
                        Tải tool tạo chữ ký
                    </a>

                    <c:choose>
                        <c:when test="${not empty currentOrderId}">
                            <a class="download-btn secondary"
                               href="${pageContext.request.contextPath}/order-sign/order-json?orderId=${currentOrderId}">
                                <i class="fa-solid fa-file-code"></i>
                                Tải dữ liệu đơn hàng
                            </a>
                        </c:when>
                        <c:otherwise>
                            <button class="download-btn secondary" type="button" disabled>
                                <i class="fa-solid fa-file-code"></i>
                                Tải dữ liệu đơn hàng
                            </button>
                        </c:otherwise>
                    </c:choose>

                    <c:if test="${canDownloadPrivateKey}">
                        <a class="download-btn secondary"
                           href="${pageContext.request.contextPath}/security-key/download-private-key">
                            <i class="fa-solid fa-key"></i>
                            Tải private key
                        </a>
                    </c:if>
                </div>
            </section>

            <section class="download-box">
                <h2>
                    <i class="fa-solid fa-upload"></i>
                    Upload chữ ký sau khi ký xong
                </h2>

                <p class="sign-guide">
                    Sau khi tool xuất file có dạng <strong>signed_order.json</strong>, hãy upload file này ở trang tải chữ ký điện tử.
                    Trang này chỉ dùng để tải dữ liệu cần ký, không xử lý verify chữ ký.
                </p>

                <div class="download-actions">
                    <a class="download-btn primary"
                       href="${pageContext.request.contextPath}/upload-signature">
                        <i class="fa-solid fa-file-shield"></i>
                        Đi đến trang upload chữ ký
                    </a>

                    <a class="download-btn secondary"
                       href="${pageContext.request.contextPath}/bought-product">
                        <i class="fa-solid fa-box"></i>
                        Xem đơn hàng của tôi
                    </a>
                </div>
            </section>
        </div>
    </section>
</main>

<jsp:include page="footer.jsp" />
</body>
</html>
