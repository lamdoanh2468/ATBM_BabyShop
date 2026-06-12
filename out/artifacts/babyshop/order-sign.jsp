<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ký điện tử đơn hàng</title>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/favicon.ico">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/orderSign.css">
</head>
<body>
<jsp:include page="header.jsp" />

<nav class="breadcrumb-nav">
    <a href="${pageContext.request.contextPath}/">Trang chủ</a>
    <span class="dot">•</span>
    <a href="${pageContext.request.contextPath}/cart">Giỏ hàng</a>
    <span class="dot">•</span>
    <span>Xác thực & Ký đơn</span>
</nav>

<main class="sign-page">
    <section class="sign-panel">
        <div class="sign-status-card">
            <div class="status-icon">
                <i class="fa-solid fa-file-signature"></i>
            </div>

            <div class="status-copy">
                <p class="eyebrow">Bước cuối cùng</p>
                <h1>Đơn hàng #045 đã được tạo và đang chờ chữ ký điện tử.</h1>

            </div>
        </div>

        <div class="sign-grid">
            <!-- Cột 1: Thông tin & Download -->
            <section class="download-box">
                <h2><i class="fa-solid fa-1"></i> Tải thông tin đơn hàng</h2>

                <div class="order-meta">
                    <div>
                        <span>Mã đơn hàng</span>
                        <strong>#045</strong>
                    </div>
                    <div>
                        <span>Thuật toán Hash</span>
                        <strong>SHA-256</strong>
                    </div>
                    <div>
                        <span>Tổng thanh toán</span>
                        <strong>1,500,000 đ</strong>
                    </div>
                </div>

                <div class="hash-preview">
                    <span>Order Hash (Dữ liệu gốc):</span>
                    <code>e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855</code>
                </div>

                <div class="download-actions">
                    <button class="download-btn primary" onclick="alert('Demo: Tải gói ký đơn hàng (ZIP)')">
                        <i class="fa-solid fa-download"></i>
                        Tải tool tạo chữ kí
                    </button>
                </div>
            </section>

            <!-- Cột 2: Upload chữ ký -->
            <section class="upload-box">
                <h2><i class="fa-solid fa-2"></i> Ký và tải lên</h2>

                <div class="notice success">
                    <i class="fa-solid fa-circle-check"></i>
                    Đã tải lên chữ ký thành công!
                </div>

                <form class="upload-form" id="uploadForm" onsubmit="handleVerify(event)">
                    <p style="font-size: 0.9rem; color: #475569; margin-bottom: 20px;">
                        Mở công cụ ký, chọn file <b>Private Key</b> và <b>Thông tin đơn hàng</b> bạn vừa tải về để tạo ra file chữ ký (có đuôi .sig hoặc .json có chứa signature). Sau đó tải file đó lên đây.
                    </p>

                    <label class="file-drop" for="signedOrder">
                        <i class="fa-solid fa-cloud-arrow-up"></i>
                        <span>Kéo thả file chữ ký vào đây</span>
                        <small id="fileName">hoặc click để chọn file (.json, .sig)</small>
                    </label>
                    <input id="signedOrder" type="file" name="signedOrder" accept=".json,.sig" required>

                    <button type="submit" id="btnSubmit" class="submit-signature-btn" disabled style="background: #94a3b8; cursor: not-allowed;">
                        <i class="fa-solid fa-shield-check"></i>
                        Xác nhận & Hoàn tất đơn hàng
                    </button>
                </form>

                <div class="verify-steps" id="verifySteps">
                    <div class="step" id="step1">
                        <i class="fa-solid fa-circle-notch fa-spin"></i>
                        <span>1. Xác thực Certificate bằng CA Public Key...</span>
                    </div>
                    <div class="step" id="step2">
                        <i class="fa-regular fa-circle"></i>
                        <span>2. Lấy Public Key của user từ Certificate...</span>
                    </div>
                    <div class="step" id="step3">
                        <i class="fa-regular fa-circle"></i>
                        <span>3. Kiểm tra tính toàn vẹn của chữ ký...</span>
                    </div>
                    <div class="step" id="step4">
                        <i class="fa-regular fa-circle"></i>
                        <span>4. So sánh Hash hiện tại với dữ liệu đơn hàng...</span>
                    </div>
                </div>
            </section>
        </div>
    </section>
</main>

<jsp:include page="footer.jsp" />

<script>
    const signedOrderInput = document.getElementById('signedOrder');
    const fileName = document.getElementById('fileName');
    const dropZone = document.querySelector('.file-drop');
    const btnSubmit = document.getElementById("btnSubmit");

    signedOrderInput.addEventListener('change', () => {
        if(signedOrderInput.files.length > 0) {
            fileName.textContent = signedOrderInput.files[0].name;
            dropZone.style.borderColor = 'var(--primary)';
            dropZone.style.background = '#eef2ff';
            btnSubmit.disabled = false;
            btnSubmit.style.background = 'var(--primary)';
            btnSubmit.style.cursor = 'pointer';
        } else {
            fileName.textContent = 'hoặc click để chọn file (.json, .sig)';
            dropZone.style.borderColor = '#cbd5e1';
            dropZone.style.background = '#fafafa';
            btnSubmit.disabled = true;
            btnSubmit.style.background = '#94a3b8';
            btnSubmit.style.cursor = 'not-allowed';
        }
    });

    function updateStep(stepId, status) {
        const step = document.getElementById(stepId);
        const icon = step.querySelector("i");
        step.className = "step " + status;
        if (status === "success") {
            icon.className = "fa-solid fa-circle-check";
        } else if (status === "error") {
            icon.className = "fa-solid fa-circle-xmark";
        } else if (status === "active") {
            icon.className = "fa-solid fa-circle-notch fa-spin";
        } else {
            icon.className = "fa-regular fa-circle";
        }
    }

    function handleVerify(event) {
        event.preventDefault();
        
        document.getElementById("uploadForm").style.display = "none";
        document.getElementById("verifySteps").style.display = "block";

        updateStep("step1", "active");
        
        setTimeout(() => {
            updateStep("step1", "success");
            updateStep("step2", "active");
            
            setTimeout(() => {
                updateStep("step2", "success");
                updateStep("step3", "active");
                
                setTimeout(() => {
                    updateStep("step3", "success");
                    updateStep("step4", "active");
                    
                    setTimeout(() => {
                        updateStep("step4", "success");
                        
                        Swal.fire({
                            icon: "success",
                            title: "Hoàn tất đơn hàng!",
                            html: "Chữ ký hợp lệ. Đơn hàng của bạn đã được xác nhận thành công.<br>Cảm ơn bạn đã mua sắm!",
                            confirmButtonColor: "#10b981",
                            confirmButtonText: "Xem đơn hàng của tôi"
                        }).then(() => {
                            window.location.href = "${pageContext.request.contextPath}/bought-product";
                        });

                    }, 1200);
                }, 1200);
            }, 800);
        }, 1000);
    }




    // Kéo thả file UI demo
    ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
        dropZone.addEventListener(eventName, preventDefaults, false);
    });

    function preventDefaults (e) {
        e.preventDefault();
        e.stopPropagation();
    }

    ['dragenter', 'dragover'].forEach(eventName => {
        dropZone.addEventListener(eventName, highlight, false);
    });

    ['dragleave', 'drop'].forEach(eventName => {
        dropZone.addEventListener(eventName, unhighlight, false);
    });

    function highlight(e) {
        dropZone.style.borderColor = 'var(--primary)';
        dropZone.style.background = '#eef2ff';
    }

    function unhighlight(e) {
        if(signedOrderInput.files.length === 0) {
            dropZone.style.borderColor = '#cbd5e1';
            dropZone.style.background = '#fafafa';
        }
    }

    dropZone.addEventListener('drop', handleDrop, false);

    function handleDrop(e) {
        let dt = e.dataTransfer;
        let files = dt.files;
        signedOrderInput.files = files;
        
        // Trigger change event
        const event = new Event('change');
        signedOrderInput.dispatchEvent(event);
    }
</script>
</body>
</html>
