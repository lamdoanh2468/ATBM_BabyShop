<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Liên Hệ - BabyShop</title>
            <link rel="icon" type="image/x-icon"
                  href="${pageContext.request.contextPath}/favicon.ico">
            <!-- CSS -->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/contact.css">

            <!-- SweetAlert -->
            <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        </head>

        <body>

            <!-- Header -->
            <jsp:include page="header.jsp" />

            <nav class="breadcrumb-nav">
                <a href="${pageContext.request.contextPath}/">Trang chủ</a>
                <span class="dot">•</span>
                <a>Liên hệ</a>
                <span class="dot">•</span>
                <a href="">${product.productName}</a>
            </nav>
            <div class="container main-contact-wrapper">
                <div class="row g-5">
                    <!-- Contact Info Column -->
                    <div class="col-lg-5">
                        <div class="contact-info-card">
                            <h3>Thông Tin Liên Hệ</h3>
                            <p class="desc">Bạn có câu hỏi hoặc cần hỗ trợ? Hãy liên hệ qua các kênh dưới đây hoặc điền
                                vào biểu mẫu.</p>

                            <div class="info-item">
                                <div class="icon-box">
                                    <i class="fa-solid fa-location-dot"></i>
                                </div>
                                <div class="info-content">
                                    <h4>Địa chỉ</h4>
                                    <p>Khu phố 6, Linh Trung, Thủ Đức, TP.HCM</p>
                                </div>
                            </div>

                            <div class="info-item">
                                <div class="icon-box">
                                    <i class="fa-solid fa-phone"></i>
                                </div>
                                <div class="info-content">
                                    <h4>Hotline</h4>
                                    <p><a href="tel:0123456789">0123 456 789</a></p>
                                </div>
                            </div>

                            <div class="info-item">
                                <div class="icon-box">
                                    <i class="fa-solid fa-envelope"></i>
                                </div>
                                <div class="info-content">
                                    <h4>Email</h4>
                                    <p><a href="mailto:support@babyshop.vn">support@babyshop.vn</a></p>
                                </div>
                            </div>

                            <div class="social-links mt-4">
                                <a href="#" class="social-btn facebook"><i class="fa-brands fa-facebook-f"></i></a>
                                <a href="#" class="social-btn instagram"><i class="fa-brands fa-instagram"></i></a>
                                <a href="#" class="social-btn twitter"><i class="fa-brands fa-twitter"></i></a>
                            </div>
                        </div>


                    </div>

                    <!-- Contact Form Column -->
                    <div class="col-lg-7">
                        <div class="contact-form-card">
                            <h2>Gửi Tin Nhắn</h2>
                            <form action="${pageContext.request.contextPath}/contact" method="post" class="needs-validation" novalidate>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="name" class="form-label">Họ và Tên <span
                                                class="text-danger">*</span></label>
                                        <input type="text" class="form-control" id="name" name="name"
                                            placeholder="Nhập họ tên" required>
                                        <div class="invalid-feedback">Vui lòng nhập họ tên.</div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="phone" class="form-label">Số điện thoại <span
                                                class="text-danger">*</span></label>
                                        <input type="tel" class="form-control" id="phone" name="phone"
                                            placeholder="Nhập SĐT" required>
                                        <div class="invalid-feedback">Vui lòng nhập số điện thoại.</div>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="email" class="form-label">Email <span
                                            class="text-danger">*</span></label>
                                    <input type="email" class="form-control" id="email" name="email"
                                        placeholder="example@email.com" required>
                                    <div class="invalid-feedback">Vui lòng nhập email hợp lệ.</div>
                                </div>

                                <div class="mb-3">
                                    <label for="address" class="form-label">Địa chỉ</label>
                                    <input type="text" class="form-control" id="address" name="address"
                                        placeholder="Nhập địa chỉ của bạn">
                                </div>

                                <div class="mb-4">
                                    <label for="message" class="form-label">Nội dung <span
                                            class="text-danger">*</span></label>
                                    <textarea class="form-control" id="message" name="message" rows="5"
                                        placeholder="Bạn cần hỗ trợ gì?" required></textarea>
                                    <div class="invalid-feedback">Vui lòng nhập nội dung.</div>
                                </div>

                                <button type="submit" class="btn btn-primary btn-send-contact">
                                    Gửi Tin Nhắn <i class="fa-solid fa-paper-plane ms-2"></i>
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Footer -->
            <jsp:include page="footer.jsp" />

            <!-- Bootstrap JS -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
            <script src="${pageContext.request.contextPath}/js/contact.js"></script>
        </body>

        </html>