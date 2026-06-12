<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<jsp:include page="header.jsp"/>

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

            <c:if test="${not empty error}">
                <div class="notice error">
                    <i class="fa-solid fa-circle-xmark"></i>
                        ${error}
                </div>
            </c:if>

            <c:if test="${not empty verifyResult}">
                <div class="verify-result ${verifyResult.success ? 'success' : 'error'}">
                    <div class="result-icon">
                        <i class="fa-solid ${verifyResult.success ? 'fa-circle-check' : 'fa-circle-xmark'}"></i>
                    </div>

                    <div class="result-content">
                        <h3>
                                ${verifyResult.success ? 'Xác minh chữ ký thành công' : 'Xác minh chữ ký thất bại'}
                        </h3>

                        <p>
                                ${verifyResult.success
                                        ? 'Chữ ký hợp lệ. Đơn hàng của bạn đã được xác thực.'
                                        : 'File chữ ký không hợp lệ hoặc dữ liệu đơn hàng không khớp. Vui lòng kiểm tra và tải lại file.'}
                        </p>

                        <c:if test="${verifyResult.success}">
                            <div class="result-actions">
                                <a class="btn-result primary"
                                   href="${pageContext.request.contextPath}/bought-product">
                                    <i class="fa-solid fa-box"></i>
                                    Xem đơn hàng của tôi
                                </a>
                            </div>
                        </c:if>
                    </div>
                </div>
            </c:if>

            <c:if test="${empty verifyResult or not verifyResult.success}">
                <form id="uploadForm"
                      action="${pageContext.request.contextPath}/upload-signature"
                      method="post"
                      enctype="multipart/form-data">

                    <div class="file-upload-box">
                        <div class="upload-icon">
                            <i class="fa-solid fa-file-arrow-up"></i>
                        </div>

                        <div class="upload-text">
                            <h3>Chọn file chữ ký</h3>
                            <p>Vui lòng tải lên file <strong>signed_order.json</strong> từ máy tính của bạn.</p>
                        </div>

                        <label class="btn-choose-file" for="signedOrder">
                            <i class="fa-solid fa-folder-open"></i>
                            Chọn file từ máy tính
                        </label>

                        <div class="selected-file" id="selectedFile" style="display: none;">
                            <i class="fa-solid fa-file-code"></i>
                            <span id="fileName">Chưa chọn file</span>
                        </div>
                    </div>

                    <input id="signedOrder"
                           type="file"
                           name="signedOrderFile"
                           accept=".json,application/json"
                           required>

                    <button type="submit" id="btnSubmit" class="btn-submit" disabled>
                        <i class="fa-solid fa-shield-check"></i>
                        Xác minh và Hoàn tất
                    </button>
                </form>

            </c:if>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp"/>

<script>
    const fileInput = document.getElementById("signedOrder");
    const fileNameDisplay = document.getElementById("fileName");
    const selectedFile = document.getElementById("selectedFile");
    const btnSubmit = document.getElementById("btnSubmit");
    const uploadForm = document.getElementById("uploadForm");

    let isSubmitting = false;

    if (fileInput && btnSubmit) {
        fileInput.addEventListener("change", function () {
            if (this.files && this.files.length > 0) {
                const file = this.files[0];

                if (!file.name.toLowerCase().endsWith(".json")) {
                    this.value = "";
                    btnSubmit.disabled = true;

                    if (selectedFile) {
                        selectedFile.style.display = "none";
                    }

                    Swal.fire({
                        icon: "error",
                        title: "File không hợp lệ",
                        text: "Vui lòng chọn file signed_order.json.",
                        confirmButtonColor: "#ef4444"
                    });

                    return;
                }

                fileNameDisplay.textContent = file.name;

                if (selectedFile) {
                    selectedFile.style.display = "inline-flex";
                }

                btnSubmit.disabled = false;
            } else {
                fileNameDisplay.textContent = "Chưa chọn file";

                if (selectedFile) {
                    selectedFile.style.display = "none";
                }

                btnSubmit.disabled = true;
            }
        });

        if (uploadForm) {
            uploadForm.addEventListener("submit", function (event) {
                if (isSubmitting) {
                    event.preventDefault();
                    return;
                }

                if (!fileInput.files || fileInput.files.length === 0) {
                    event.preventDefault();

                    Swal.fire({
                        icon: "warning",
                        title: "Chưa chọn file",
                        text: "Vui lòng chọn file signed_order.json trước khi xác minh.",
                        confirmButtonColor: "#6366f1"
                    });

                    return;
                }

                const file = fileInput.files[0];

                if (!file.name.toLowerCase().endsWith(".json")) {
                    event.preventDefault();

                    Swal.fire({
                        icon: "error",
                        title: "File không hợp lệ",
                        text: "Hệ thống chỉ nhận file .json.",
                        confirmButtonColor: "#ef4444"
                    });

                    return;
                }

                isSubmitting = true;
                btnSubmit.disabled = true;
                btnSubmit.classList.add("loading");
                btnSubmit.innerHTML = '<i class="fa-solid fa-circle-notch fa-spin"></i> Đang xác minh chữ ký...';
            });
        }
    }
</script>
</body>
</html>
