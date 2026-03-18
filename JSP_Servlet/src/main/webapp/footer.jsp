<%-- Created by IntelliJ IDEA. To change this template use File | Settings | File Templates. --%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>

        <!-- Font Awesome 7.1.0 -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css"
            integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw=="
            crossorigin="anonymous" referrerpolicy="no-referrer" />
        <!-- Footer CSS -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/footer.css" />

        <footer id="footer-frame" class="shop-footer">
            <div class="footer-container">
                <div class="footer-grid">

                    <!-- CỘT 1 -->
                    <div class="footer-brand">
                        <h3 class="brand-name">BabyStore</h3>
                        <p class="brand-desc">Cung cấp linh kiện, laptop chính hãng với giá tốt nhất.</p>

                        <div class="contact-info">
                            <p><i class="fa-solid fa-location-dot"></i> 123 Đường ABC, TP. Hồ Chí Minh</p>
                            <p><i class="fa-solid fa-phone"></i> <a href="tel:0123456789">0123 456 789</a></p>
                            <p><i class="fa-solid fa-envelope"></i> <a
                                    href="mailto:babystore@gmail.com">babystore@gmail.com</a></p>
                        </div>
                    </div>

                    <!-- CỘT 2 -->
                    <div class="footer-links">
                        <h4>Hỗ trợ khách hàng</h4>
                        <ul>
                            <li><a href="#">Chính sách bảo hành</a></li>
                            <li><a href="#">Chính sách đổi trả</a></li>
                            <li><a href="#">Hướng dẫn thanh toán</a></li>
                            <li><a href="#">Hướng dẫn mua hàng</a></li>
                        </ul>
                    </div>

                    <!-- CỘT 3 -->
                    <div class="footer-socials">
                        <h4>Kết nối với chúng tôi</h4>

                        <div class="social-icons">
                            <a href="#"><i class="fa-brands fa-facebook-f"></i></a>
                            <a href="#"><i class="fa-brands fa-instagram"></i></a>
                            <a href="#"><i class="fa-brands fa-tiktok"></i></a>
                            <a href="#"><i class="fa-brands fa-youtube"></i></a>
                        </div>


                        <h4>Phương thức thanh toán</h4>
                        <div class="payment-icons">
                            <img src="https://upload.wikimedia.org/wikipedia/commons/4/41/Visa_Logo.png" alt="Visa">
                            <img src="https://upload.wikimedia.org/wikipedia/commons/0/04/Mastercard-logo.png"
                                alt="MasterCard">
                            <img src="https://m.momoshop.com.tw/img/momologo.svg" alt="Momo">
                            <img src="https://thienankids.edu.vn/icon/zaloicon.png" alt="ZaloPay">
                        </div>
                    </div>

                    <!-- CỘT 4 -->
                    <div class="footer-newsletter">
                        <h4>Đăng ký nhận tin</h4>
                        <p>Nhận thông tin khuyến mãi và sản phẩm mới nhất.</p>
                    </div>
                </div>

                <!-- DÒNG CUỐI -->
                <div class="footer-bottom">
                    <p>© <span id="year"></span> BabyStore. All rights reserved.</p>

                    <ul class="legal-links">
                        <li><a href="#">Điều khoản sử dụng</a></li>
                        <li><a href="#">Chính sách bảo mật</a></li>
                    </ul>
                </div>
            </div>
        </footer>

        <script>
            document.getElementById("year").textContent = new Date().getFullYear();
        </script>