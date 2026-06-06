<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tải lên chữ ký đơn hàng</title>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/favicon.ico">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/profile.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/upload-signature.css">
</head>
<body>
<jsp:include page="header.jsp" />

<div class="pf-page">
    <nav class="pf-breadcrumb">
        <a href="${pageContext.request.contextPath}/">Trang chủ</a>
        <span class="dot">•</span>
        <a href="${pageContext.request.contextPath}/cart">Giỏ hàng</a>
        <span class="dot">•</span>
        <span>Xác minh chữ ký</span>
    </nav>

    <div class="upload-page">
        <div class="upload-card">
            <h2><i class="fa-solid fa-file-shield" style="color: #6366f1;"></i> Xác minh chữ ký điện tử</h2>
            <p>Vui lòng tải lên file <strong>signed_order.json</strong> mà bạn vừa ký bằng công cụ.</p>

            <form id="uploadForm" onsubmit="handleVerify(event)">
                <label class="file-drop" id="dropZone" for="signedOrder">
                    <i class="fa-solid fa-cloud-arrow-up"></i>
                    <span id="fileName">Kéo thả file .json vào đây</span>
                    <small>hoặc click để chọn file từ máy tính</small>
                </label>
                <input id="signedOrder" type="file" accept=".json" required>

                <button type="submit" id="btnSubmit" class="btn-submit" disabled>
                    <i class="fa-solid fa-shield-check"></i> Xác minh & Hoàn tất
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
                    <span>3. Kiểm tra tính toàn vẹn của chữ ký (Verify Signature)...</span>
                </div>
                <div class="step" id="step4">
                    <i class="fa-regular fa-circle"></i>
                    <span>4. So sánh Hash hiện tại với dữ liệu đơn hàng...</span>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />

<script>
    const fileInput = document.getElementById("signedOrder");
    const fileNameDisplay = document.getElementById("fileName");
    const dropZone = document.getElementById("dropZone");
    const btnSubmit = document.getElementById("btnSubmit");

    fileInput.addEventListener("change", function() {
        if (this.files && this.files.length > 0) {
            fileNameDisplay.textContent = this.files[0].name;
            dropZone.classList.add("active");
            btnSubmit.disabled = false;
        } else {
            fileNameDisplay.textContent = "Kéo thả file .json vào đây";
            dropZone.classList.remove("active");
            btnSubmit.disabled = true;
        }
    });

    // Drag & Drop
    ["dragenter", "dragover", "dragleave", "drop"].forEach(eventName => {
        dropZone.addEventListener(eventName, preventDefaults, false);
    });

    function preventDefaults(e) {
        e.preventDefault();
        e.stopPropagation();
    }

    ["dragenter", "dragover"].forEach(eventName => {
        dropZone.addEventListener(eventName, () => dropZone.classList.add("active"), false);
    });

    ["dragleave", "drop"].forEach(eventName => {
        dropZone.addEventListener(eventName, () => {
            if (!fileInput.files || fileInput.files.length === 0) {
                dropZone.classList.remove("active");
            }
        }, false);
    });

    dropZone.addEventListener("drop", (e) => {
        let dt = e.dataTransfer;
        let files = dt.files;
        fileInput.files = files;
        const event = new Event("change");
        fileInput.dispatchEvent(event);
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
        
        btnSubmit.style.display = "none";
        document.getElementById("verifySteps").style.display = "block";

        // Mock verification process
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
</script>
</body>
</html>