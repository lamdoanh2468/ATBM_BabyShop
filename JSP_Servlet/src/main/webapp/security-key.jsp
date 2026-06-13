<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Khóa bảo mật & Chứng thư số</title>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/favicon.ico">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/profile.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/securityKey.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
<jsp:include page="header.jsp"/>

<div class="pf-page">
    <nav class="pf-breadcrumb">
        <a href="${pageContext.request.contextPath}/">Trang chủ</a>
        <span class="dot">•</span>
        <span>Chữ ký điện tử</span>
    </nav>

    <div class="pf-container">
        <aside class="pf-sidebar">
            <h2><i class="fas fa-user-circle"></i> ${sessionScope.USER.username}</h2>
            <ul>
                <li onclick="location.href='${pageContext.request.contextPath}/profile'">
                    <i class="fas fa-user"></i> Thông tin cá nhân
                </li>
                <li onclick="location.href='${pageContext.request.contextPath}/bought-product'">
                    <i class="fas fa-shopping-bag"></i> Đơn hàng đã mua
                </li>
                <li onclick="location.href='${pageContext.request.contextPath}/my-favorite'">
                    <i class="fas fa-heart"></i> Sản Phẩm Yêu Thích
                </li>
                <li onclick="location.href='${pageContext.request.contextPath}/change-password'">
                    <i class="fas fa-key"></i> Đổi mật khẩu
                </li>
                <li onclick="location.href='${pageContext.request.contextPath}/security-key'">
                    <i class="fas fa-shield-halved"></i> Chữ ký điện tử
                </li>
                <li onclick="location.href='${pageContext.request.contextPath}/upload-signature'">
                    <i class="fas fa-file-shield"></i> Tải chữ ký đơn hàng
                </li>
            </ul>
        </aside>

        <main class="pf-content">
            <section class="pf-section pf-section-active">
                <h3><i class="fas fa-shield-halved"></i> Quản lý khóa và chứng thư số</h3>

                <c:if test="${not empty error}">
                    <div class="sk-message error">
                        <i class="fas fa-exclamation-circle"></i> ${error}
                    </div>
                </c:if>

                <c:if test="${param.downloadError == '1'}">
                    <div class="sk-message error">
                        <i class="fas fa-exclamation-circle"></i>
                        Private key không tồn tại hoặc đã được tải trước đó.
                    </div>
                </c:if>

                <c:if test="${param.created == '1'}">
                    <div class="sk-message success">
                        <i class="fas fa-check-circle"></i>
                        Đã tạo khóa/chứng thư mới thành công.
                        <c:if test="${canDownloadPrivateKey}">
                            Vui lòng tải private key ngay và lưu trữ an toàn.
                        </c:if>
                    </div>
                </c:if>

                <c:if test="${param.revoked == '1'}">
                    <div class="sk-message success">
                        <i class="fas fa-check-circle"></i>
                        Chứng thư hiện tại đã được thu hồi và hệ thống đã cấp chứng thư mới.
                    </div>
                </c:if>

                <div class="sk-card">
                    <div class="sk-card-header">
                        <div>
                            <p class="sk-eyebrow">Trạng thái khóa</p>
                            <h4>
                                <c:choose>
                                    <c:when test="${hasCertificate}">
                                        Bạn đã có chứng thư số đang hoạt động
                                    </c:when>
                                    <c:otherwise>
                                        Bạn chưa có chứng thư số đang hoạt động
                                    </c:otherwise>
                                </c:choose>
                            </h4>
                        </div>

                        <c:if test="${hasCertificate}">
                            <c:set var="statusClass" value="status-active"/>
                            <c:if test="${certificate.status == 'REVOKED'}">
                                <c:set var="statusClass" value="status-revoked"/>
                            </c:if>
                            <c:if test="${certificate.status == 'EXPIRED'}">
                                <c:set var="statusClass" value="status-expired"/>
                            </c:if>
                            <span class="sk-status-pill ${statusClass}">${certificate.status}</span>
                        </c:if>
                    </div>

                    <div class="sk-info-grid">
                        <div class="sk-info-item">
                            <span>Serial number</span>
                            <strong>
                                <c:choose>
                                    <c:when test="${hasCertificate}">
                                        ${certificate.serialNumber}
                                    </c:when>
                                    <c:otherwise>Chưa có</c:otherwise>
                                </c:choose>
                            </strong>
                        </div>

                        <div class="sk-info-item">
                            <span>Trạng thái chứng thư</span>
                            <strong>
                                <c:choose>
                                    <c:when test="${hasCertificate}">
                                        ${certificate.status}
                                    </c:when>
                                    <c:otherwise>Chưa có</c:otherwise>
                                </c:choose>
                            </strong>
                        </div>

                        <div class="sk-info-item">
                            <span>Ngày tạo khóa</span>
                            <strong>
                                <c:choose>
                                    <c:when test="${hasCertificate}">
                                        ${certificate.issuedAt}
                                    </c:when>
                                    <c:otherwise>Chưa có</c:otherwise>
                                </c:choose>
                            </strong>
                        </div>

                        <div class="sk-info-item">
                            <span>Ngày hết hạn</span>
                            <strong>
                                <c:choose>
                                    <c:when test="${hasCertificate}">
                                        ${certificate.expiredAt}
                                    </c:when>
                                    <c:otherwise>Chưa có</c:otherwise>
                                </c:choose>
                            </strong>
                        </div>
                    </div>

                    <div class="sk-actions">
                        <button type="button" class="sk-btn primary" onclick="showCreateModal()">
                            <i class="fas fa-plus-circle"></i>
                            Tạo khóa / chứng thư mới
                        </button>

                        <button type="button" class="sk-btn danger" onclick="showRevokeModal()">
                            <i class="fas fa-triangle-exclamation"></i>
                            Báo mất private key
                        </button>

                        <button type="button"
                                class="sk-btn"
                                onclick="window.location.href='${pageContext.request.contextPath}/signing-tool/download'">
                            <i class="fas fa-toolbox"></i>
                            Tải tool ký
                        </button>

                        <c:if test="${canDownloadPrivateKey}">
                            <a class="sk-btn"
                               href="${pageContext.request.contextPath}/security-key/download-private-key"
                               onclick="return confirmDownloadPrivateKey(event)">
                                <i class="fas fa-key"></i>
                                Tải private key
                            </a>
                        </c:if>
                    </div>
                </div>

                <div class="sk-history">
                    <h4><i class="fas fa-clock-rotate-left"></i> Lịch sử chứng thư</h4>
                    <div class="sk-history-table-wrap">
                        <table class="sk-history-table">
                            <thead>
                            <tr>
                                <th>Serial</th>
                                <th>Trạng thái</th>
                                <th>Ngày tạo</th>
                                <th>Hết hạn</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:if test="${hasCertificate}">
                                <tr>
                                    <td>${certificate.serialNumber}</td>
                                    <td>
                                        <span class="sk-status-pill sk-status-inline status-active">${certificate.status}</span>
                                    </td>
                                    <td><fmt:formatDate value="${certificate.issuedAt}" pattern="dd/MM/yyyy"/></td>
                                    <td><fmt:formatDate value="${certificate.expiredAt}" pattern="dd/MM/yyyy"/></td>
                                </tr>
                            </c:if>

                            <c:forEach var="revoked" items="${revokedCertificates}">
                                <tr>
                                    <td>${revoked.serialNumber}</td>
                                    <td>
                                        <span class="sk-status-pill sk-status-inline status-revoked">${revoked.status}</span>
                                    </td>
                                    <td><fmt:formatDate value="${revoked.issuedAt}" pattern="dd/MM/yyyy"/></td>
                                    <td><fmt:formatDate value="${revoked.expiredAt}" pattern="dd/MM/yyyy"/></td>
                                </tr>
                            </c:forEach>

                            <c:if test="${not hasCertificate and empty revokedCertificates}">
                                <tr>
                                    <td colspan="4">Chưa có lịch sử chứng thư.</td>
                                </tr>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </section>
        </main>
    </div>
</div>

<jsp:include page="footer.jsp"/>

<form id="createKeyForm" method="post" action="${pageContext.request.contextPath}/security-key/create" style="display:none"></form>
<form id="revokeKeyForm" method="post" action="${pageContext.request.contextPath}/security-key/revoke" style="display:none"></form>

<script>
    function showCreateModal() {
        Swal.fire({
            title: 'Tạo khóa / chứng thư mới?',
            html: 'Hệ thống sẽ tạo cặp khóa RSA 2048-bit mới.<br>' +
                'Private key chỉ được tải <strong>một lần</strong> ngay sau khi tạo.<br>' +
                'Chứng thư cũ nếu có sẽ bị thu hồi.',
            icon: 'question',
            showCancelButton: true,
            confirmButtonText: 'Xác nhận tạo',
            cancelButtonText: 'Hủy',
            confirmButtonColor: '#6366f1'
        }).then((result) => {
            if (result.isConfirmed) {
                document.getElementById('createKeyForm').submit();
            }
        });
    }

    function showRevokeModal() {
        Swal.fire({
            title: 'Báo mất private key?',
            text: 'Chứng thư hiện tại sẽ bị thu hồi. Hệ thống sẽ cấp lại khóa và chứng thư mới cho bạn.',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Xác nhận thu hồi',
            cancelButtonText: 'Hủy',
            confirmButtonColor: '#ef4444'
        }).then((result) => {
            if (result.isConfirmed) {
                document.getElementById('revokeKeyForm').submit();
            }
        });
    }

    function confirmDownloadPrivateKey(event) {
        event.preventDefault();

        const downloadUrl = event.currentTarget.href;

        Swal.fire({
            title: 'Tải private key?',
            html: 'Private key chỉ được tải <strong>một lần duy nhất</strong>.<br>' +
                'Sau khi tải xong, hệ thống sẽ xóa file này khỏi server.<br><br>' +
                '<strong>Hãy lưu file ở nơi an toàn.</strong>',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Tải ngay',
            cancelButtonText: 'Hủy',
            confirmButtonColor: '#6366f1',
            cancelButtonColor: '#64748b'
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = downloadUrl;
            }
        });

        return false;
    }

    <c:if test="${param.lostKey == '1'}">
    showRevokeModal();
    </c:if>
</script>
</body>
</html>
