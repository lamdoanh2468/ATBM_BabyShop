<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Chi Tiết Voucher</title>
    <link rel="icon" type="image/x-icon"
          href="${pageContext.request.contextPath}/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/voucherDetail.css">
</head>

<body>
<jsp:include page="header.jsp"/>
<nav>
    <a href="${pageContext.request.contextPath}/">Trang chủ</a>
    <span class="dot">•</span>
    <a href="${pageContext.request.contextPath}/voucher-list">Danh sách voucher</a>
    <span class="dot">•</span>
    <span>${voucher.voucherName}</span>
</nav>
<div class="voucher-detail-container">

    <c:if test="${empty voucher}">
        <div class="voucher-error">
            Voucher không tồn tại hoặc đã hết hạn
        </div>
    </c:if>

    <c:if test="${not empty voucher}">
        <div class="voucher-detail-card">

            <div class="voucher-detail-img-wrap">
                <img src="${voucher.voucherImage}" alt="${voucher.voucherName}"
                     class="voucher-detail-img">
            </div>

            <div class="voucher-detail-content">

                <h1 class="voucher-detail-title">
                        ${voucher.voucherName}
                </h1>

                <div class="voucher-detail-date">
                    <span>📅 Hiệu lực:</span>
                    <fmt:formatDate value="${voucher.startDate}" pattern="dd/MM/yyyy"/>
                    <span>–</span>
                    <fmt:formatDate value="${voucher.endDate}" pattern="dd/MM/yyyy"/>
                </div>

                <div class="voucher-code-box">
                    <span class="voucher-key-label">Mã giảm giá</span>
                    <div class="voucher-code-value">${voucher.voucherCode}</div>
                </div>

                <div class="voucher-detail-desc">
                        ${voucher.description}
                </div>

            </div>
        </div>
    </c:if>

</div>

<jsp:include page="footer.jsp"/>

</body>

</html>
