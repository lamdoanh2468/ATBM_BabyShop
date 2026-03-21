<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 - Không tìm thấy trang</title>
    <style>
        body {
            background: #28254C;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #fff;
            height: 100vh;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .container {
            text-align: center;
            position: relative;
        }

        h1 {
            font-size: 10rem;
            margin: 0;
            letter-spacing: 10px;
            background: linear-gradient(135deg, #fff, #8E84F5);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            opacity: 0.8;
        }

        h2 {
            font-size: 2rem;
            margin-bottom: 10px;
        }

        p {
            font-size: 1.1rem;
            color: #D1D1D1;
            margin-bottom: 30px;
        }

        .btn-home {
            padding: 12px 30px;
            background: #FF6B6B;
            color: white;
            text-decoration: none;
            border-radius: 50px;
            font-weight: bold;
            transition: transform 0.3s, box-shadow 0.3s;
            display: inline-block;
        }

        .btn-home:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(255, 107, 107, 0.4);
        }

        /* Ghost Animation */
        .ghost {
            animation: float 3s ease-in-out infinite;
            margin-bottom: 20px;
        }

        .ghost svg {
            width: 120px;
            height: auto;
            fill: #fff;
            filter: drop-shadow(0 0 15px rgba(255, 255, 255, 0.4));
        }

        .shadow {
            width: 100px;
            height: 20px;
            background: rgba(0, 0, 0, 0.3);
            border-radius: 50%;
            margin: 0 auto;
            animation: scale 3s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% {
                transform: translateY(0);
            }
            50% {
                transform: translateY(-20px);
            }
        }

        @keyframes scale {
            0%, 100% {
                transform: scale(1);
                opacity: 0.3;
            }
            50% {
                transform: scale(0.8);
                opacity: 0.1;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="ghost">
        <svg viewBox="0 0 24 24">
            <path d="M12 2C7.58 2 4 5.58 4 10v10c0 .55.45 1 1 1s1-.45 1-1v-1c0-.55.45-1 1-1s1 .45 1 1v1c0 .55.45 1 1 1s1-.45 1-1v-1c0-.55.45-1 1-1s1 .45 1 1v1c0 .55.45 1 1 1s1-.45 1-1v-10c0-4.42 3.58-8 8-8s8 3.58 8 8v10c0 .55.45 1 1 1s1-.45 1-1v-1c0-.55.45-1 1-1s1 .45 1 1v1c0 .55.45 1 1 1s1-.45 1-1v-1c0-.55.45-1 1-1s1 .45 1 1v1c0 .55.45 1 1 1s1-.45 1-1V10c0-4.42-3.58-8-8-8zm-3 8c-.55 0-1 .45-1 1s.45 1 1 1 1-.45 1-1-.45-1-1-1zm6 0c-.55 0-1 .45-1 1s.45 1 1 1 1-.45 1-1-.45-1-1-1z"/>
        </svg>
    </div>
    <div class="shadow"></div>
    <h1>404</h1>
    <h2>Úi! Bạn đi lạc rồi</h2>
    <p>Trang bạn đang tìm kiếm không tồn tại hoặc đã bị di chuyển.</p>
    <a href="<c:url value='/home'/>" class="btn-home">Quay về Trang Chủ</a>
</div>
</body>
</html>