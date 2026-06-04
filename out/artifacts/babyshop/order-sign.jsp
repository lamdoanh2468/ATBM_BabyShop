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
    
    <style>
        /* orderSign.css inline for UI preview / Refactored */
        :root {
            --primary: #4f46e5;
            --primary-hover: #4338ca;
            --text-dark: #0f172a;
            --text-gray: #475569;
            --bg-body: #f8fafc;
            --bg-card: #ffffff;
            --border-light: #e2e8f0;
        }

        body {
            background-color: var(--bg-body);
            font-family: 'Inter', sans-serif;
            color: var(--text-dark);
            margin: 0;
            padding: 0;
            line-height: 1.5;
        }

        .breadcrumb-nav {
            padding: 20px 40px;
            font-size: 0.9rem;
            color: var(--text-gray);
        }
        
        .breadcrumb-nav a {
            color: var(--text-gray);
            text-decoration: none;
            transition: color 0.2s;
        }

        .breadcrumb-nav a:hover {
            color: var(--primary);
        }

        .breadcrumb-nav .dot {
            margin: 0 10px;
            color: #cbd5e1;
        }

        .sign-page {
            max-width: 1000px;
            margin: 0 auto;
            padding: 0 20px 60px;
        }

        .sign-panel {
            background: var(--bg-card);
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
            padding: 40px;
        }

        .sign-status-card {
            display: flex;
            align-items: center;
            gap: 24px;
            padding-bottom: 30px;
            border-bottom: 1px solid var(--border-light);
            margin-bottom: 30px;
        }

        .status-icon {
            width: 72px;
            height: 72px;
            border-radius: 50%;
            background: #eef2ff;
            color: var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            flex-shrink: 0;
        }

        .status-copy .eyebrow {
            text-transform: uppercase;
            font-size: 0.8rem;
            font-weight: 700;
            color: var(--text-gray);
            letter-spacing: 0.05em;
            margin: 0 0 6px 0;
        }

        .status-copy h1 {
            font-size: 1.4rem;
            margin: 0 0 12px 0;
            color: var(--text-dark);
        }

        .status-pill {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: #fffbeb;
            color: #b45309;
            padding: 6px 14px;
            border-radius: 999px;
            font-size: 0.85rem;
            font-weight: 600;
        }

        .sign-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 40px;
        }

        .sign-grid h2 {
            font-size: 1.15rem;
            margin: 0 0 20px 0;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .download-box, .upload-box {
            display: flex;
            flex-direction: column;
        }

        .order-meta {
            display: flex;
            flex-direction: column;
            gap: 12px;
            background: #f8fafc;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 24px;
        }

        .order-meta > div {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.95rem;
        }

        .order-meta span {
            color: var(--text-gray);
        }

        .order-meta strong {
            font-weight: 600;
            color: var(--text-dark);
        }

        .hash-preview {
            margin-bottom: 24px;
        }

        .hash-preview span {
            display: block;
            font-size: 0.85rem;
            color: var(--text-gray);
            margin-bottom: 8px;
        }

        .hash-preview code {
            display: block;
            background: #0f172a;
            color: #e2e8f0;
            padding: 12px 16px;
            border-radius: 8px;
            font-size: 0.8rem;
            word-break: break-all;
        }

        .download-actions {
            display: flex;
            flex-direction: column;
            gap: 12px;
            margin-top: auto;
        }

        .download-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            padding: 12px;
            border-radius: 10px;
            font-weight: 600;
            font-size: 0.95rem;
            text-decoration: none;
            transition: all 0.2s;
            border: 1px solid var(--border-light);
            color: var(--text-dark);
            background: #fff;
        }

        .download-btn:hover {
            border-color: #cbd5e1;
            background: #f8fafc;
        }

        .download-btn.primary {
            background: var(--primary);
            color: #fff;
            border-color: var(--primary);
        }

        .download-btn.primary:hover {
            background: var(--primary-hover);
        }

        .upload-form {
            display: flex;
            flex-direction: column;
            flex-grow: 1;
        }

        .file-drop {
            flex-grow: 1;
            border: 2px dashed #cbd5e1;
            border-radius: 12px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 12px;
            padding: 40px 20px;
            cursor: pointer;
            transition: all 0.2s;
            background: #fafafa;
            margin-bottom: 20px;
        }

        .file-drop:hover {
            border-color: var(--primary);
            background: #eef2ff;
        }

        .file-drop i {
            font-size: 3rem;
            color: #94a3b8;
            transition: color 0.2s;
        }

        .file-drop:hover i {
            color: var(--primary);
        }

        .file-drop span {
            font-weight: 600;
            color: var(--text-dark);
        }

        .file-drop small {
            color: var(--text-gray);
        }

        input[type="file"] {
            display: none;
        }

        .submit-signature-btn {
            background: var(--primary);
            color: #fff;
            border: none;
            padding: 14px;
            border-radius: 10px;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            transition: background 0.2s;
        }

        .submit-signature-btn:hover {
            background: var(--primary-hover);
        }

        .notice {
            padding: 14px 18px;
            border-radius: 10px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 0.9rem;
        }

        .notice.success {
            background: #ecfdf5;
            color: #047857;
            border: 1px solid #a7f3d0;
            display: none; /* Hide by default in UI preview */
        }

        @media (max-width: 768px) {
            .sign-grid {
                grid-template-columns: 1fr;
            }
            .sign-status-card {
                flex-direction: column;
                text-align: center;
            }
        }
    
        /* Verification steps */
        .verify-steps {
            text-align: left;
            margin-top: 20px;
            display: none;
        }
        .step {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 12px;
            color: var(--text-gray);
            font-size: 0.95rem;
        }
        .step i {
            font-size: 1.2rem;
            width: 24px;
            text-align: center;
        }
        .step.active {
            color: var(--text-dark);
            font-weight: 600;
        }
        .step.success {
            color: #10b981;
        }
        .step.error {
            color: #ef4444;
        }
    </style>
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
