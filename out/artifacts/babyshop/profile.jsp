<%-- Profile Page - Modern UI --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin cá nhân</title>
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
        <a href="${pageContext.request.contextPath}/">
            Trang chủ
        </a>
        <span class="dot">•</span>
        <span>Thông tin cá nhân</span>
    </nav>

    <div class="pf-container">

        <!-- SIDEBAR -->
        <aside class="pf-sidebar">
            <h2><i class="fas fa-user-circle"></i> ${sessionScope.USER.username}</h2>
            <ul>
                <li class="active">
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
            </ul>
        </aside>

        <!-- CONTENT -->
        <main class="pf-content">

            <section class="pf-section pf-section-active">
                <h3><i class="fas fa-id-card"></i> Thông tin cá nhân</h3>

                <div class="pf-info-box">
                    <div class="pf-info">

                        <!-- AVATAR -->
                        <div class="pf-avatar">
                            <img src="${empty PROFILE.avatarUrl ? 'https://ui-avatars.com/api/?name=${sessionScope.USER.username}&background=6366f1&color=fff&size=200' : PROFILE.avatarUrl}"
                                 alt="Avatar"
                                 onerror="this.src='https://ui-avatars.com/api/?name=User&background=6366f1&color=fff&size=200'">

                            <label for="pf-avatar-upload" class="pf-upload-btn">
                                <i class="fas fa-camera"></i> Tải ảnh lên
                            </label>
                            <input type="file" id="pf-avatar-upload" accept="image/*" hidden>
                        </div>

                        <!-- FORM -->
                        <form class="pf-form" method="post"
                              action="${pageContext.request.contextPath}/profile">

                            <div class="pf-form-group">
                                <label><i class="fas fa-user"></i> Họ và tên</label>
                                <input type="text" name="fullName" value="${PROFILE.fullName}"
                                       placeholder="Nhập họ và tên">
                            </div>

                            <div class="pf-form-group">
                                <label><i class="fas fa-envelope"></i> Email</label>
                                <input type="email" value="${PROFILE.email}" disabled
                                       placeholder="Email không thể thay đổi">
                            </div>

                            <div class="pf-form-group">
                                <label><i class="fas fa-phone"></i> Số điện thoại</label>
                                <input type="text" name="phone" value="${PROFILE.phone}"
                                       placeholder="Nhập số điện thoại">
                            </div>

                            <div class="pf-form-group">
                                <label><i class="fas fa-map-marker-alt"></i> Địa chỉ</label>
                                <input type="text" name="address" value="${PROFILE.address}"
                                       placeholder="Nhập địa chỉ">
                            </div>

                            <div class="pf-form-group">
                                <label><i class="fas fa-venus-mars"></i> Giới tính</label>
                                <select name="gender">
                                    <option value="MALE" ${PROFILE.gender=='MALE' ? 'selected' : '' }>
                                        Nam
                                    </option>
                                    <option value="FEMALE" ${PROFILE.gender=='FEMALE' ? 'selected' : '' }>
                                        Nữ
                                    </option>
                                </select>
                            </div>

                            <div class="pf-form-group">
                                <label><i class="fas fa-calendar-alt"></i> Ngày sinh</label>
                                <input type="date" name="birthDate" value="${PROFILE.birthDate}">
                            </div>

                            <div class="pf-form-group full-width" style="margin-top: 10px;">
                                <button id="pf-save-btn" type="submit">
                                    <i class="fas fa-save"></i> Lưu thay đổi
                                </button>
                            </div>
                        </form>

                    </div>
                </div>
            </section>

        </main>
    </div>
</div>

<jsp:include page="footer.jsp"/>

<script src="${pageContext.request.contextPath}/js/profile.js"></script>
</body>

</html>