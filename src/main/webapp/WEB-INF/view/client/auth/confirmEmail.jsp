<!-- JSP Path: client/auth/confirmEmail.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="vi">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Xác Nhận Từ 3TLap</title>
    <style type="text/css">
      body {
        margin: 0;
        padding: 0;
        background-color: #f4f6f8;
        font-family: Arial, Helvetica, sans-serif;
        font-size: 16px;
        color: #333333;
      }
      .email-wrapper {
        width: 100%;
        background-color: #f4f6f8;
        padding: 20px 0;
      }
      .email-container {
        width: 100%;
        max-width: 600px;
        margin: 0 auto;
        background-color: #ffffff;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.07);
      }
      .email-header {
        background-color: #0a7aff;
        color: #ffffff;
        padding: 25px;
        text-align: center;
      }
      .email-header h1 {
        margin: 0;
        font-size: 24px;
        font-weight: 700;
        font-family: 'Poppins', Arial, sans-serif;
      }
      .email-body {
        padding: 30px 25px;
        line-height: 1.6;
      }
      .email-body p {
        margin: 0 0 15px 0;
      }
      .otp-code {
        background-color: #e9f2ff;
        color: #0a7aff;
        font-size: 28px;
        font-weight: 700;
        padding: 12px 20px;
        margin: 20px auto;
        border-radius: 6px;
        letter-spacing: 3px;
        display: inline-block;
        border: 1px dashed #0a7aff;
      }
      .email-body .text-center {
        text-align: center;
      }
      .button-primary {
        background-color: #ff8c00;
        color: #ffffff !important;
        padding: 12px 25px;
        text-decoration: none;
        border-radius: 5px;
        font-weight: bold;
        display: inline-block;
        margin-top: 15px;
        font-family: 'Poppins', Arial, sans-serif;
      }
      .email-footer {
        background-color: #f0f2f5;
        padding: 20px 25px;
        text-align: center;
        font-size: 12px;
        color: #777777;
      }
      .email-footer a {
        color: #0a7aff;
        text-decoration: none;
      }
    </style>
  </head>
  <body>
    <div class="email-wrapper">
      <div class="email-container">
        <div class="email-header">
          <h1>3TLap</h1>
        </div>
        <div class="email-body">
          <p>Xin chào,</p>
          <p>
            Cảm ơn bạn đã sử dụng dịch vụ của 3TLap. Vui lòng sử dụng mã OTP
            dưới đây để hoàn tất thao tác của bạn:
          </p>

          <div class="text-center">
            <div class="otp-code">${OTP}</div>
          </div>

          <p>
            Mã OTP này sẽ có hiệu lực trong vòng <strong>1 phút</strong>. Vui
            lòng không chia sẻ mã này với bất kỳ ai.
          </p>
          <p>
            Nếu bạn không yêu cầu mã này, vui lòng bỏ qua email này hoặc liên hệ
            với bộ phận hỗ trợ của chúng tôi ngay lập tức.
          </p>
        </div>
        <div class="email-footer">
          <p>© ${java.time.Year.now()} 3TLap. Đã đăng ký Bản quyền.</p>
          <p>123 Đường ABC, Phường XYZ, Quận 1, TP. HCM | (+84) 1900 8888</p>
          <p>
            <a href="<c:url value='/'/>" target="_blank">Website</a> |
            <a href="<c:url value='/privacy-policy'/>" target="_blank"
              >Chính sách bảo mật</a
            >
          </p>
        </div>
      </div>
    </div>
  </body>
</html>
