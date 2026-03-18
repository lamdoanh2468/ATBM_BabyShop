<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>500 - Lỗi Máy Chủ</title>
    <style>
        body {
            background-color: #0f172a;
            color: #e2e8f0;
            font-family: 'Courier New', Courier, monospace;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            text-align: center;
        }
        .content {
            padding: 2rem;
            border: 1px solid #334155;
            border-radius: 10px;
            background: rgba(30, 41, 59, 0.5);
            backdrop-filter: blur(5px);
            box-shadow: 0 0 40px rgba(99, 102, 241, 0.1);
        }
        .gear-system {
            margin-bottom: 20px;
        }
        .gear {
            display: inline-block;
            fill: #6366f1;
            width: 80px;
            height: 80px;
            animation: spin 4s linear infinite;
        }
        .gear.small {
            width: 50px;
            height: 50px;
            fill: #94a3b8;
            animation: spin-reverse 4s linear infinite;
            margin-left: -20px;
            margin-bottom: -10px;
        }
        h1 {
            font-size: 5rem;
            margin: 0;
            color: #f87171;
            text-shadow: 2px 2px #000;
        }
        h3 {
            font-size: 1.5rem;
            margin: 10px 0;
        }
        p {
            color: #94a3b8;
            max-width: 400px;
            margin: 0 auto 30px auto;
        }
        .btn-retry {
            background: transparent;
            color: #6366f1;
            border: 2px solid #6366f1;
            padding: 10px 25px;
            font-family: inherit;
            font-weight: bold;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.3s;
            text-transform: uppercase;
            letter-spacing: 2px;
        }
        .btn-retry:hover {
            background: #6366f1;
            color: #fff;
            box-shadow: 0 0 15px #6366f1;
        }

        @keyframes spin { 100% { transform: rotate(360deg); } }
        @keyframes spin-reverse { 100% { transform: rotate(-360deg); } }
    </style>
</head>
<body>
<div class="content">
    <div class="gear-system">
        <svg class="gear" viewBox="0 0 24 24"><path d="M19.14 12.94c.04-.3.06-.61.06-.94 0-.32-.02-.64-.07-.94l2.03-1.58a.49.49 0 0 0 .12-.61l-1.92-3.32a.488.488 0 0 0-.59-.22l-2.39.96c-.5-.38-1.03-.7-1.62-.94l-.36-2.54a.484.484 0 0 0-.48-.41h-3.84c-.24 0-.43.17-.47.41l-.36 2.54c-.59.24-1.13.57-1.62.94l-2.39-.96c-.22-.08-.47 0-.59.22L2.74 8.87c-.04.17-.006.34.12.61l2.03 1.58c-.05.3-.09.63-.09.94s.02.64.07.94l-2.03 1.58a.49.49 0 0 0-.12.61l1.92 3.32c.12.22.37.29.59.22l2.39-.96c.5.38 1.03.7 1.62.94l.36 2.54c.05.24.24.41.48.41h3.84c.24 0 .44-.17.47-.41l.36-2.54c.59-.24 1.13-.56 1.62-.94l2.39.96c.22.08.47 0 .59-.22l1.92-3.32c.04-.17.006-.34-.12-.61l-2.01-1.58zM12 15.6c-1.98 0-3.6-1.62-3.6-3.6s1.62-3.6 3.6-3.6 3.6 1.62 3.6 3.6-1.62 3.6-3.6 3.6z"/></svg>
        <svg class="gear small" viewBox="0 0 24 24"><path d="M19.14 12.94c.04-.3.06-.61.06-.94 0-.32-.02-.64-.07-.94l2.03-1.58a.49.49 0 0 0 .12-.61l-1.92-3.32a.488.488 0 0 0-.59-.22l-2.39.96c-.5-.38-1.03-.7-1.62-.94l-.36-2.54a.484.484 0 0 0-.48-.41h-3.84c-.24 0-.43.17-.47.41l-.36 2.54c-.59.24-1.13.57-1.62.94l-2.39-.96c-.22-.08-.47 0-.59.22L2.74 8.87c-.04.17-.006.34.12.61l2.03 1.58c-.05.3-.09.63-.09.94s.02.64.07.94l-2.03 1.58a.49.49 0 0 0-.12.61l1.92 3.32c.12.22.37.29.59.22l2.39-.96c.5.38 1.03.7 1.62.94l.36 2.54c.05.24.24.41.48.41h3.84c.24 0 .44-.17.47-.41l.36-2.54c.59-.24 1.13-.56 1.62-.94l2.39.96c.22.08.47 0 .59-.22l1.92-3.32c.04-.17.006-.34-.12-.61l-2.01-1.58zM12 15.6c-1.98 0-3.6-1.62-3.6-3.6s1.62-3.6 3.6-3.6 3.6 1.62 3.6 3.6-1.62 3.6-3.6 3.6z"/></svg>
    </div>
    <h1>500</h1>
    <h3>Máy chủ đang "nghỉ giải lao"</h3>
    <p>Hệ thống gặp sự cố nội bộ. Chúng tôi đang nỗ lực khắc phục. Vui lòng thử lại sau ít phút.</p>
    <a href="javascript:location.reload()" class="btn-retry">Tải lại trang</a>
</div>
</body>
</html>