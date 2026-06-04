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
    
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/profile.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/securityKey.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
<jsp:include page="header.jsp"/>

<div class="pf-page">
    <!-- BREADCRUMB -->
    <nav class="pf-breadcrumb">
        <a href="${pageContext.request.contextPath}/">Trang chủ</a>
        <span class="dot">•</span>
        <span>Khóa bảo mật</span>
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
                <li onclick="location.href='${pageContext.request.contextPath}/my-favorite'">
                    <i class="fas fa-heart"></i> Sản Phẩm Yêu Thích
                </li>
                <li onclick="location.href='${pageContext.request.contextPath}/change-password'">
                    <i class="fas fa-key"></i> Đổi mật khẩu
                </li>
                <li class="active">
                    <i class="fas fa-shield-halved"></i> Khóa bảo mật
                </li>
            </ul>
        </aside>

        <!-- CONTENT -->
        <main class="pf-content">
            <section class="pf-section pf-section-active">
                <h3><i class="fas fa-shield-halved"></i> Quản lý khóa & chứng thư số</h3>

                <c:if test="${not empty error}">
                    <div class="sk-message error">
                        <i class="fas fa-exclamation-circle"></i> ${error}
                    </div>
                </c:if>

                <c:if test="${param.created == '1'}">
                    <div class="sk-message success">
                        <i class="fas fa-check-circle"></i>
                        Đã tạo khóa/chứng thư mới thành công.
                        <c:if test="${canDownloadPrivateKey}">
                            Vui lòng tải private key ngay và lưu trữ an toàn — hệ thống không lưu private key.
                        </c:if>
                    </div>
                </c:if>

                <c:if test="${param.revoked == '1'}">
                    <div class="sk-message success">
                        <i class="fas fa-check-circle"></i>
                        Chứng thư hiện tại đã được thu hồi do báo mất private key.
                    </div>
                </c:if>

                <c:if test="${param.revokeError == '1'}">
                    <div class="sk-message error">
                        <i class="fas fa-exclamation-circle"></i>
                        Không thể thu hồi chứng thư. Có thể bạn chưa có chứng thư đang hoạt động.
                    </div>
                </c:if>

                <c:if test="${param.downloadError == '1'}">
                    <div class="sk-message error">
                        <i class="fas fa-exclamation-circle"></i>
                        Không thể tải file. Link tải private key chỉ khả dụng ngay sau khi tạo khóa mới.
                    </div>
                </c:if>

                <!-- MAIN KEY CARD -->
                <div class="sk-card">
                    <div class="sk-card-header">
                        <div>
                            <p class="sk-eyebrow">Trạng thái khóa</p>
                            <h4>
                                <c:choose>
                                    <c:when test="${hasCertificate}">
                                        Bạn đã có public key / chứng thư số
                                    </c:when>
                                    <c:otherwise>
                                        Bạn chưa có public key / chứng thư số
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
                            <span class="sk-status-pill ${statusClass}">
                                ${certificate.status}
                            </span>
                        </c:if>
                    </div>

                    <!-- CERTIFICATE INFO -->
                    <div class="sk-info-grid">
                        <div class="sk-info-item">
                            <span>Serial number</span>
                            <strong>#7B5A-9D2E-1F4C-8A3B</strong>
                        </div>
                        <div class="sk-info-item">
                            <span>Trạng thái chứng thư</span>
                            <strong>Đang hoạt động</strong>
                        </div>
                        <div class="sk-info-item">
                            <span>Ngày tạo khóa</span>
                            <strong>15/05/2026 14:30</strong>
                        </div>
                        <div class="sk-info-item">
                            <span>Ngày hết hạn</span>
                            <strong>15/05/2027 14:30</strong>
                        </div>
                    </div>

                    <!-- ACTIONS -->
                    <div class="sk-actions">
                        <button class="sk-btn primary" onclick="showCreateModal()">
                            <i class="fas fa-plus-circle"></i>
                            Tạo khóa / chứng thư mới
                        </button>

                        <button class="sk-btn danger" onclick="showRevokeModal()">
                            <i class="fas fa-triangle-exclamation"></i>
                            Báo mất private key
                        </button>

                        <button class="sk-btn warning">
                            <i class="fas fa-download"></i>
                            Tải private key (một lần)
                        </button>

                        <button class="sk-btn">
                            <i class="fas fa-certificate"></i>
                            Tải chứng thư
                        </button>

                        <button class="sk-btn">
                            <i class="fas fa-toolbox"></i>
                            Tải lại tool ký
                        </button>
                    </div>
                </div>

                <!-- HISTORY SECTION -->
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
                            <tr>
                                <td>#7B5A-9D2E-1F4C-8A3B</td>
                                <td><span class="sk-status-pill sk-status-inline status-active">ACTIVE</span></td>
                                <td>15/05/2026</td>
                                <td>15/05/2027</td>
                            </tr>
                            <tr>
                                <td>#A1B2-C3D4-E5F6-G7H8</td>
                                <td><span class="sk-status-pill sk-status-inline status-revoked">REVOKED</span></td>
                                <td>01/01/2026</td>
                                <td>01/01/2027</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </section>
        </main>
    </div>
</div>

<jsp:include page="footer.jsp"/>

<script>
    function showCreateModal() {
        Swal.fire({
            title: 'Tạo khóa / chứng thư mới?',
            html: 'Hệ thống sẽ tạo cặp khóa RSA 2048-bit mới.<br>' +
                  'Private key chỉ được tải <strong>một lần</strong> ngay sau khi tạo.<br>' +
                  'Chứng thư cũ (nếu có) sẽ bị thu hồi.',
            icon: 'question',
            showCancelButton: true,
            confirmButtonText: 'Xác nhận tạo',
            cancelButtonText: 'Hủy',
            confirmButtonColor: '#6366f1'
        });
    }

    function showRevokeModal() {
        Swal.fire({
            title: 'Báo mất private key?',
            text: 'Chứng thư hiện tại sẽ bị thu hồi ngay lập tức. Bạn cần tạo khóa mới để tiếp tục ký đơn hàng.',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Xác nhận thu hồi',
            cancelButtonText: 'Hủy',
            confirmButtonColor: '#ef4444'
        });
    }
</script>
</body>
</html>
