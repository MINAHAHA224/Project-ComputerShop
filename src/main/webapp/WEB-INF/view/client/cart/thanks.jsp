<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt Hàng Thành Công - Cảm Ơn Quý Khách!</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            text-align: center;
        }

        .thank-you-container {
            background-color: #ffffff;
            padding: 40px 50px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            width: 90%;
        }

        .thank-you-container h1 {
            color: #28a745; /* Màu xanh lá cây thành công */
            font-size: 2.5em;
            margin-bottom: 15px;
        }

        .thank-you-container .icon {
            font-size: 4em;
            color: #28a745;
            margin-bottom: 20px;
        }

        .thank-you-container p {
            color: #555;
            font-size: 1.1em;
            line-height: 1.6;
            margin-bottom: 25px;
        }

        .thank-you-container .order-details {
            background-color: #f9f9f9;
            border: 1px solid #eee;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 25px;
            font-size: 0.95em;
        }
        .thank-you-container .order-details strong {
            color: #333;
        }

        .thank-you-container .btn {
            display: inline-block;
            background-color: #007bff; /* Màu xanh dương chính */
            color: white;
            padding: 12px 25px;
            text-decoration: none;
            border-radius: 5px;
            font-size: 1em;
            transition: background-color 0.3s ease;
            margin-top: 10px;
        }

        .thank-you-container .btn:hover {
            background-color: #0056b3;
        }

        .btn-secondary {
            background-color: #6c757d; /* Màu xám */
            margin-left: 10px;
        }
        .btn-secondary:hover {
            background-color: #545b62;
        }

        /* Bạn có thể dùng FontAwesome hoặc một thư viện icon khác */
        /* Ví dụ đơn giản dùng ký tự Unicode */
        .icon::before {
            content: '✔'; /* Hoặc một icon SVG/FontAwesome */
            display: inline-block;
            border: 3px solid #28a745;
            border-radius: 50%;
            padding: 5px 10px;
            line-height: 1;
        }

    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>

<body>
<div class="thank-you-container">
    <div class="icon"></div>
    <h1>Cảm ơn bạn đã đặt hàng!</h1>
    <p>Đơn hàng của bạn đã được tiếp nhận và đang được xử lý. Chúng tôi sẽ thông báo cho bạn khi đơn hàng được vận chuyển.</p>

    <!-- Tùy chọn: Hiển thị mã đơn hàng hoặc thông tin khác nếu có -->
    <!-- Ví dụ:
    <div class="order-details">
        <p>Mã đơn hàng của bạn là: <strong>#DH0012345</strong></p>
        <p>Bạn có thể theo dõi đơn hàng <a href="/theo-doi-don-hang?id=DH0012345">tại đây</a>.</p>
    </div>
    -->

    <p>Nếu bạn có bất kỳ câu hỏi nào, vui lòng liên hệ với bộ phận chăm sóc khách hàng của chúng tôi.</p>

    <div>
        <a href="/home" class="btn">Tiếp tục mua sắm</a>
        <!-- Nếu có trang lịch sử đơn hàng -->
        <a href="/order-history" class="btn btn-secondary">Xem lịch sử đơn hàng</a>
    </div>
</div>

<!--
    Nếu bạn muốn sử dụng FontAwesome cho icon đẹp hơn:
    1. Thêm link FontAwesome vào <head>:
       <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    2. Thay thế <div class="icon"></div> bằng:
       <i class="fas fa-check-circle icon" style="font-size: 4em; color: #28a745; margin-bottom: 20px;"></i>
    3. Xóa class .icon::before trong CSS
-->
</body>

</html>