<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Thông báo tạo tài khoản mới</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f9fc;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        .header {
            background-color: #007bff;
            color: white;
            text-align: center;
            padding: 15px 0;
        }
        .content {
            padding: 20px;
        }
        .footer {
            background-color: #f1f1f1;
            text-align: center;
            padding: 10px 0;
            color: #777;
        }
        .btn {
            display: inline-block;
            background-color: #28a745;
            color: white;
            padding: 10px 20px;
            margin-top: 15px;
            text-decoration: none;
            border-radius: 5px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="header">
        <h2>Thông báo tạo mật khẩu  mới</h2>
    </div>
    <div class="content">
        <p>Xin chào,</p>
        <p>Tài khoản của bạn đã được tạo thành công!</p>

        <p><strong>Thông tin đăng nhập:</strong></p>
        <ul>
<%--            <li><strong>Email đăng nhập:</strong> ${emailLogin}</li>--%>
            <li><strong>Mã OTP là:</strong> ${OTP}</li>
        </ul>

        <p>Vui lòng đăng nhập và thay đổi mật khẩu sớm nhất có thể để bảo mật tài khoản.</p>

        <a href="http://localhost:8080/login" class="btn">Đăng nhập ngay</a>
    </div>
    <div class="footer">
        <p>Trân trọng,<br>Phòng kĩ thuật</p>
    </div>
</div>

</body>
</html>
