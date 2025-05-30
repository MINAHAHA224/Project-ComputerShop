<!-- JSP Path: client/auth/verifyOTP.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
prefix="security" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="utf-8" />
    <title>Xác Thực OTP - 3TLap</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <jsp:include page="../layout/common_head_links.jsp" />
    <link href="<c:url value='/client/css/auth-pages.css'/>" rel="stylesheet" />
    <style>
      .otp-input-group input {
        text-align: center;
        font-size: 1.5rem;
        letter-spacing: 0.5rem;
        border-radius: 0.375rem !important;
      }
      .form-actions {
        display: flex;
        gap: 0.75rem;
      }
      .form-actions .btn {
        flex: 1;
      }
      #resendOtpBtn {
        font-weight: 500;
      }
      #countdownTimer {
        font-weight: 500;
        color: var(--primary-color);
      }
    </style>
  </head>
  <body class="auth-page-bg">
    <div
      id="spinner"
      class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center"
    >
      <div class="spinner-grow text-primary" role="status"></div>
    </div>
    <div class="auth-video-background-container">
      <video autoplay muted loop playsinline id="authVideoBackground">
        <source
          src="<c:url value='/client/video/auth-background.mp4'/>"
          type="video/mp4"
        />
        Trình duyệt của bạn không hỗ trợ thẻ video.
      </video>
    </div>
    <div class="auth-wrapper">
      <div class="card auth-card" style="max-width: 500px">
        <div class="card-header">
          <a href="<c:url value='/home'/>" class="logo-text-auth">3TLap</a>
          <h3 class="font-weight-light my-1">Xác Thực Mã OTP</h3>
        </div>
        <div class="card-body">
          <p class="text-muted text-center mb-3">
            Một mã OTP gồm 6 chữ số đã được gửi đến địa chỉ email:
            <strong class="text-dark">${email}</strong>. Vui lòng kiểm tra và
            nhập mã vào ô bên dưới.
          </p>

          <c:if test="${not empty messageError}">
            <div class="alert alert-danger alert-auth my-3" role="alert">
              ${messageError}
            </div>
          </c:if>
          <c:if
            test="${not empty messageSuccess && not messageSuccess.contains('Xác thực mã OTP thành công')}"
          >
            <div class="alert alert-info alert-auth my-3" role="alert">
              ${messageSuccess}
            </div>
          </c:if>

          <form
            id="verifyOtpForm"
            action="<c:url value='/verifyOtp'/>"
            method="post"
          >
            <input type="hidden" name="email" value="${email}" />
            <security:csrfInput />

            <div class="form-floating mb-3 otp-input-group">
              <input
                type="text"
                class="form-control"
                id="otp"
                name="OTP"
                placeholder="123456"
                maxlength="6"
                pattern="[A-Z0-9]{6}"
                title="Mã OTP gồm 6 ký tự chữ hoa hoặc số."
                required
              />
              <label for="otp">Nhập mã OTP</label>
            </div>

            <div class="form-actions mb-3">
              <button
                type="submit"
                name="action"
                value="VERIFY-OTP"
                class="btn btn-primary btn-lg"
              >
                Xác Nhận
              </button>
              <button
                type="submit"
                id="resendOtpBtn"
                name="action"
                value="RESENT-OTP"
                class="btn btn-outline-secondary btn-lg"
                formnovalidate
              >
                Gửi lại OTP <span id="countdownTimer"></span>
              </button>
            </div>
          </form>
          <div class="text-center mt-3">
            <a
              href="<c:url value='/forgotPassword'/>"
              class="small text-muted text-decoration-none"
            >
              <i class="fas fa-arrow-left me-1"></i> Quay lại nhập email
            </a>
          </div>
        </div>
        <div class="card-footer">
          <div class="small">
            Cần hỗ trợ?
            <a
              href="<c:url value='/contact-us'/>"
              class="text-primary fw-medium"
              >Liên hệ chúng tôi</a
            >
          </div>
        </div>
      </div>
    </div>

    <jsp:include page="../layout/common_scripts.jsp" />
    <script>
      document.addEventListener('DOMContentLoaded', function () {
        const resendButton = document.getElementById('resendOtpBtn');
        const countdownTimerSpan = document.getElementById('countdownTimer');
        let countdownTime = 90;
        let timerInterval;

        function formatTime(seconds) {
          const minutes = Math.floor(seconds / 60);
          const remainingSeconds = seconds % 60;
          const formattedMinutes = String(minutes);
          const formattedSeconds = String(remainingSeconds).padStart(2, '0');
          return `(${formattedMinutes}:${formattedSeconds})`;
        }

        function startTimer() {
          resendButton.disabled = true;
          countdownTime = 90;
          countdownTimerSpan.textContent = formatTime(countdownTime);

          timerInterval = setInterval(function () {
            countdownTime--;
            countdownTimerSpan.textContent = formatTime(countdownTime);
            if (countdownTime <= 0) {
              clearInterval(timerInterval);
              resendButton.disabled = false;
              countdownTimerSpan.textContent = '';
            }
          }, 1000);
        }
        if (resendButton && countdownTimerSpan) {
          <c:choose>
            <c:when test="${not empty messageSuccess and messageSuccess.contains('Mã OTP đã được gửi lại')}">
              startTimer();
            </c:when>
            <c:otherwise>startTimer();</c:otherwise>
          </c:choose>;
        }
      });
    </script>
  </body>
</html>
