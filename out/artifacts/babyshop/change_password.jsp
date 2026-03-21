<%-- Change Password Page - Modern UI --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đổi mật khẩu</title>
    <link rel="icon" type="image/x-icon"
          href="${pageContext.request.contextPath}/favicon.ico">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

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
        <a href="${pageContext.request.contextPath}/">Trang chủ
        </a>
        <span class="dot">•</span>
        <span>Đổi mật khẩu</span>
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
                <li class="active">
                    <i class="fas fa-key"></i> Đổi mật khẩu
                </li>
            </ul>
        </aside>

        <!-- CONTENT -->
        <main class="pf-content">

            <section class="pf-section pf-section-active">
                <h3><i class="fas fa-shield-alt"></i> Đổi mật khẩu</h3>

                <div class="pf-password-box">

                    <!-- MESSAGE -->
                    <c:if test="${not empty error}">
                        <div class="pf-message error">
                            <i class="fas fa-exclamation-circle"></i>
                                ${error}
                        </div>
                    </c:if>

                    <c:if test="${not empty success}">
                        <div class="pf-message success">
                            <i class="fas fa-check-circle"></i>
                                ${success}
                        </div>
                    </c:if>

                    <!-- FORM -->
                    <form class="pf-password-form" method="post"
                          action="${pageContext.request.contextPath}/change-password">

                        <div class="pf-form-group">
                            <label><i class="fas fa-lock"></i> Mật khẩu hiện tại</label>
                            <div class="password-input-wrapper">
                                <input type="password" name="oldPassword" id="oldPassword"
                                       placeholder="Nhập mật khẩu hiện tại" required>
                                <button type="button" class="password-toggle"
                                        onclick="togglePassword('oldPassword', this)">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </div>
                        </div>

                        <div class="pf-form-group">
                            <label><i class="fas fa-key"></i> Mật khẩu mới</label>
                            <div class="password-input-wrapper">
                                <input type="password" name="newPassword" id="newPassword"
                                       placeholder="Nhập mật khẩu mới (tối thiểu 6 ký tự)" required>
                                <button type="button" class="password-toggle"
                                        onclick="togglePassword('newPassword', this)">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </div>
                        </div>

                        <div class="pf-form-group">
                            <label><i class="fas fa-check-double"></i> Xác nhận mật khẩu mới</label>
                            <div class="password-input-wrapper">
                                <input type="password" name="confirmPassword" id="confirmPassword"
                                       placeholder="Nhập lại mật khẩu mới" required>
                                <button type="button" class="password-toggle"
                                        onclick="togglePassword('confirmPassword', this)">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </div>
                        </div>

                        <button id="pf-change-pass-btn" type="submit">
                            <i class="fas fa-sync-alt"></i> Đổi mật khẩu
                        </button>
                    </form>

                </div>
            </section>

        </main>
    </div>
</div>

<jsp:include page="footer.jsp"/>

<script>
    function togglePassword(inputId, button) {
        const input = document.getElementById(inputId);
        const icon = button.querySelector('i');

        if (input.type === 'password') {
            input.type = 'text';
            icon.classList.remove('fa-eye');
            icon.classList.add('fa-eye-slash');
        } else {
            input.type = 'password';
            icon.classList.remove('fa-eye-slash');
            icon.classList.add('fa-eye');
        }
    }
</script>
</body>

</html>