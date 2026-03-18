<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <title>Xác thực OTP</title>

            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css" />
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" />
        </head>

        <body>
            <div class="auth-container">
                <div class="auth-box">

                    <form class="form active" action="${pageContext.request.contextPath}/verify-otp" method="post">

                        <h2>Xác thực OTP</h2>

                        <p style="text-align:center;color:#fff;margin-bottom:10px">
                            Mã OTP đã được gửi tới email của bạn
                        </p>

                        <c:if test="${not empty error}">
                            <p class="error">${error}</p>
                        </c:if>

                        <c:if test="${not empty message}">
                            <p class="success" style="color: #4CAF50; text-align: center; margin-bottom: 10px;">
                                ${message}</p>
                        </c:if>

                        <input type="text" name="otp" placeholder="Nhập mã OTP (6 số)" maxlength="6" required />

                        <!-- Countdown -->
                        <p id="countdown" style="text-align:center;color:#fff;font-size:14px;margin-top:10px">
                            OTP hết hạn sau <b>60</b> giây
                        </p>

                        <button type="submit">Xác nhận</button>

                        <p class="switch">
                            Không nhận được mã?
                            <a href="#" onclick="resendOTP()">Gửi lại OTP</a>
                        </p>

                    </form>

                </div>
            </div>

            <script>
                let timeLeft = 60;
                const countdown = document.getElementById("countdown");

                const timer = setInterval(() => {
                    timeLeft--;
                    countdown.innerHTML = "OTP hết hạn sau <b>" + timeLeft + "</b> giây";

                    if (timeLeft <= 0) {
                        clearInterval(timer);
                        countdown.innerHTML = "<span style='color:#ffb4b4'>OTP đã hết hạn</span>";
                    }
                }, 1000);

                function resendOTP() {
                    window.location.href = "${pageContext.request.contextPath}/resend-otp";
                }
            </script>

        </body>

        </html>