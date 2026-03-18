<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông báo hệ thống</title>
    <style>
        body {
            background: #f8f9fa;
            color: #343a40;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }
        .card {
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.05);
            text-align: center;
            max-width: 400px;
            width: 90%;
            border-top: 5px solid #ffc107; /* Màu vàng cảnh báo */
        }
        .icon {
            font-size: 4rem;
            margin-bottom: 20px;
        }
        h1 {
            font-size: 1.8rem;
            margin-bottom: 10px;
            color: #212529;
        }
        p {
            color: #6c757d;
            line-height: 1.6;
            margin-bottom: 30px;
        }
        .btn {
            display: block;
            width: 100%;
            padding: 12px 0;
            background: #212529;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            transition: background 0.2s;
        }
        .btn:hover {
            background: #000;
        }
    </style>
</head>
<body>
<div class="card">
    <div class="icon">🔒</div>
    <h1>Truy cập bị từ chối</h1>
    <p>Bạn không có quyền truy cập vào khu vực này. Nếu bạn nghĩ đây là sự nhầm lẫn, vui lòng liên hệ quản trị viên.</p>
    <a href="<c:url value='/home'/>" class="btn">Trở về an toàn</a>
</div>
</body>
</html>