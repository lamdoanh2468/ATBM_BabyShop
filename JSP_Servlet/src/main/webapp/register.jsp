<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Đăng ký</title>
    <link rel="icon" type="image/x-icon"
          href="${pageContext.request.contextPath}/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css"/>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css"/>
</head>

<body>
<div class="auth-container">
    <div class="auth-box">

        <form class="form active"
              action="${pageContext.request.contextPath}/register"
              method="post"
              id="register-form">

            <h2>Đăng ký</h2>

            <c:if test="${not empty error}">
                <p class="error">${error}</p>
            </c:if>

            <input type="text"
                   name="username"
                   placeholder="Tên người dùng"
                   required/>

            <input type="email"
                   name="email"
                   placeholder="Email"
                   required />

            <div class="password-container">
                <input type="password"
                       name="password"
                       id="register-password"
                       placeholder="Mật khẩu"
                       required/>
                <span class="toggle-password">
                    <i class="fa-solid fa-eye"></i>
                </span>
            </div>

            <div class="password-container">
                <input type="password"
                       name="confirmPassword"
                       id="confirm-password"
                       placeholder="Xác nhận mật khẩu"
                       required/>
                <span class="toggle-password">
                    <i class="fa-solid fa-eye"></i>
                </span>
            </div>

            <p class="error" id="password-error"></p>

            <button type="submit">Tạo tài khoản</button>

            <p class="switch">
                Đã có tài khoản?
                <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
            </p>

        </form>

    </div>
</div>

<script src="${pageContext.request.contextPath}/js/login.js"></script>
</body>
</html>