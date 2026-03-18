<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />

        <header class="site-header" id="siteHeader">
            <!-- Top bar -->
            <div class="sh-top-bar">
                <div class="sh-container sh-top-bar-inner">
                    <div class="sh-hotline">
                        Hotline: <a href="tel:0964163168">0964 163 168</a>
                    </div>

                    <div class="sh-auth-links">
                        <c:choose>
                            <c:when test="${empty sessionScope.USER}">
                                <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
                                <span class="sep">/</span>
                                <a href="${pageContext.request.contextPath}/register">Đăng ký</a>
                            </c:when>
                            <c:otherwise>
                                Xin chào, <strong>${sessionScope.USER.username}</strong>
                                <span class="sep">/</span>
                                <a class="logout-btn" href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <!-- Main header -->
            <div class="sh-container sh-main">
                <!-- Brand -->
                <div class="sh-brand">
                    <a href="${pageContext.request.contextPath}/" class="sh-logo" aria-label="BabyShop">
                        <span class="sh-brand-text sh-multi-logo" aria-hidden="true">
                            <span>B</span><span>a</span><span>b</span><span>y</span><span>S</span><span>h</span><span>o</span><span>p</span>
                        </span>
                    </a>
                </div>

                <!-- Search (desktop) -->
                <div class="sh-search-wrap">
                    <form action="${pageContext.request.contextPath}/search" method="get" class="sh-search-form"
                        role="search">
                        <button type="submit" class="sh-search-btn" aria-label="Tìm">🔍</button>
                        <input type="search" class="sh-search-input" placeholder="Tìm bàn ghế, tủ, đồ chơi..."
                            name="keyword" value="${param.keyword}" />
                    </form>
                </div>

                <!-- Right side -->
                <div class="sh-right">
                    <nav class="sh-nav" aria-label="Điều hướng chính">
                        <ul class="sh-nav-links">
                            <li><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
                            <li><a href="${pageContext.request.contextPath}/product-list">Sản phẩm</a></li>
                            <li><a href="${pageContext.request.contextPath}/voucher-list">Ưu đãi</a></li>
                            <li><a href="${pageContext.request.contextPath}/contact">Liên hệ</a></li>
                        </ul>
                    </nav>

                    <div class="sh-actions">
                        <a href="${pageContext.request.contextPath}/profile" class="icon-btn"
                            aria-label="Tài khoản">👤</a>

                        <a href="${pageContext.request.contextPath}/cart" class="icon-btn sh-cart"
                            aria-label="Giỏ hàng">
                            🛒
                            <span class="sh-cart-badge" aria-hidden="true">
                                <c:choose>
                                    <c:when test="${sessionScope.cart != null}">
                                        ${sessionScope.cart.totalQuantity}
                                    </c:when>
                                    <c:otherwise>0</c:otherwise>
                                </c:choose>
                            </span>
                        </a>

                        <button class="sh-hamburger icon-btn" type="button" aria-label="Mở menu"
                            aria-controls="mobileMenu" aria-expanded="false">
                            <span class="bar"></span><span class="bar"></span><span class="bar"></span>
                        </button>
                    </div>
                </div>
            </div>

            <!-- Mobile drawer -->
            <div class="sh-mobile" id="mobileMenu" aria-hidden="true">
                <div class="sh-mobile-inner">
                    <form action="${pageContext.request.contextPath}/search" method="get" class="sh-mobile-search"
                        role="search">
                        <input type="search" name="keyword" value="${param.keyword}" placeholder="Tìm sản phẩm..." />
                    </form>

                    <ul class="sh-mobile-links">
                        <li><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
                        <li><a href="${pageContext.request.contextPath}/product-list">Danh sách sản phẩm</a></li>
                        <li><a href="${pageContext.request.contextPath}/news">Tin tức</a></li>
                        <li><a href="${pageContext.request.contextPath}/voucher-list">Ưu đãi</a></li>
                        <li><a href="${pageContext.request.contextPath}/contact">Liên hệ</a></li>
                        <li><a href="${pageContext.request.contextPath}/profile">Tài khoản</a></li>
                        <li><a href="${pageContext.request.contextPath}/cart">Giỏ hàng</a></li>
                    </ul>
                </div>
            </div>
        </header>

        <script>

            document.addEventListener("DOMContentLoaded", () => {
                const header = document.getElementById('siteHeader');
                if (!header) return;

                const btn = header.querySelector('.sh-hamburger');
                const menu = document.getElementById('mobileMenu');
                if (!btn || !menu) return;

                function setOpen(open) {
                    btn.setAttribute('aria-expanded', String(open));
                    menu.setAttribute('aria-hidden', String(!open));
                    header.classList.toggle('is-open', open);
                    document.body.classList.toggle('no-scroll', open);
                }

                btn.addEventListener('click', () => {
                    const isOpen = btn.getAttribute('aria-expanded') === 'true';
                    setOpen(!isOpen);
                });

                menu.addEventListener('click', (e) => {
                    if (e.target === menu) setOpen(false);
                });

                document.addEventListener('keydown', (e) => {
                    if (e.key === 'Escape') setOpen(false);
                });
            });
            //Add cart
            const logOutBtn = document.querySelector(".logout-btn");
            if (logOutBtn) {
                logOutBtn.addEventListener("click", (event) => {
                    event.preventDefault();

                    // 1. Lấy đường dẫn từ thẻ a
                    const url = logOutBtn.getAttribute("href");

                    // 2. Gửi yêu cầu xuống Server bằng fetch (AJAX)
                    fetch(url)
                        .then(response => {

                            Swal.fire({
                                icon: "success",
                                title: "Đã đăng xuất",
                                text: "Đăng xuất khỏi tài khoản thành công.",
                                timer: 1500,
                                showConfirmButton: false,
                            }).then(() => {
                                window.location.href = response.url;
                            });
                            return;
                            // 3️⃣ LỖI KHÁC
                            throw new Error("Server error");

                        })
                        .catch(error => {
                            console.error(error);
                            Swal.fire({
                                icon: "error",
                                title: "Lỗi",
                                text: "Có lỗi xảy ra, vui lòng thử lại sau.",
                            });
                        });
                })
            }
        </script>