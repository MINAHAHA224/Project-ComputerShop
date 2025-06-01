<%-- JSP Path: src/main/webapp/WEB-INF/view/client/auth/verifyOTP.jsp --%> <%@
page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
prefix="security" uri="http://www.springframework.org/security/tags" %> <%@
taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
  <head>
    <meta charset="utf-8" />
    <title><spring:message code="page.verifyOtp.meta.title"/></title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <jsp:include page="../layout/common_head_links.jsp" />
    <link href="<c:url value='/client/css/auth-pages.css'/>" rel="stylesheet" />
    <style>
      /* Giữ nguyên style này vì nó đặc thù cho trang OTP */
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
        color: var(--bs-primary);
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
        <spring:message code="page.verifyOtp.video.notSupported" />
      </video>
    </div>
    <div class="auth-wrapper">
      <div class="card auth-card" style="max-width: 500px">
        <div class="card-header">
          <a href="<c:url value='/'/>" class="logo-text-auth"
            ><spring:message code="page.verifyOtp.header.brandName"
          /></a>
          <h3 class="font-weight-light my-1">
            <spring:message code="page.verifyOtp.header.title" />
          </h3>
        </div>

        <div class="card-body">
          <jsp:include page="../layout/_language_switcher.jsp" />

          <p class="text-muted text-center mb-3">
            <spring:message code="page.verifyOtp.instruction.text1" />
            <strong class="text-dark">${email}</strong>. <%-- Email giữ nguyên
            --%>
            <spring:message code="page.verifyOtp.instruction.text2" />
          </p>
          <%-- Các message success/error từ flash attributes hoặc model
          attributes giữ nguyên --%> <%-- Nếu các biến này chứa key, bạn sẽ cần
          dùng <spring:message code="${...}" /> --%>
          <c:if test="${not empty messageError}">
            <div class="alert alert-danger alert-auth my-3" role="alert">
              ${messageError}
            </div>
          </c:if>
          <c:if
            test="${not empty messageSuccess and not messageSuccess.contains('Xác thực mã OTP thành công')}"
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
              <spring:message
                code="page.verifyOtp.form.placeholder.otp"
                var="otpPlaceholder"
              />
              <spring:message
                code="page.verifyOtp.form.title.otpValidation"
                var="otpTitleValidation"
              />
              <input
                type="text"
                class="form-control"
                id="otp"
                name="OTP"
                placeholder="${otpPlaceholder}"
                maxlength="6"
                pattern="[A-Z0-9]{6}"
                title="${otpTitleValidation}"
                required
              />
              <label for="otp"
                ><spring:message code="page.verifyOtp.form.label.otp"
              /></label>
            </div>
            <div class="form-actions mb-3">
              <button
                type="submit"
                name="action"
                value="VERIFY-OTP"
                class="btn btn-primary btn-lg"
              >
                <spring:message code="page.verifyOtp.form.button.verify" />
              </button>
              <button
                type="submit"
                id="resendOtpBtn"
                name="action"
                value="RESENT-OTP"
                class="btn btn-outline-secondary btn-lg"
                formnovalidate
              >
                <spring:message code="page.verifyOtp.form.button.resend" />
                <span id="countdownTimer"></span>
              </button>
            </div>
          </form>
          <div class="text-center mt-3">
            <a
              href="<c:url value='/forgotPassword'/>"
              class="small text-muted text-decoration-none"
            >
              <i class="fas fa-arrow-left me-1"></i>
              <spring:message code="page.verifyOtp.link.backToEmailInput" />
            </a>
          </div>
        </div>
        <div class="card-footer">
          <div class="small">
            <spring:message code="page.verifyOtp.footer.needSupport" />
            <a
              href="<c:url value='/contact-us'/>"
              class="text-primary fw-medium"
              ><spring:message code="page.verifyOtp.footer.contactUs"
            /></a>
          </div>
        </div>
      </div>
    </div>
    <jsp:include page="../layout/common_scripts.jsp" />
    <script>
      // Giữ nguyên script này
      document.addEventListener('DOMContentLoaded', function () {
        const resendButton = document.getElementById('resendOtpBtn');
        const countdownTimerSpan = document.getElementById('countdownTimer');
        let countdownTime = 90; // Thời gian countdown (giây)
        let timerInterval;

        function formatTime(seconds) {
          const minutes = Math.floor(seconds / 60);
          const remainingSeconds = seconds % 60;
          const formattedMinutes = String(minutes);
          const formattedSeconds = String(remainingSeconds).padStart(2, '0');
          return `(${formattedMinutes}:${formattedSeconds})`;
        }

        function startTimer() {
          if (!resendButton || !countdownTimerSpan) return;
          resendButton.disabled = true;
          countdownTime = 90; // Reset lại thời gian khi bắt đầu
          countdownTimerSpan.textContent = formatTime(countdownTime);

          clearInterval(timerInterval); // Xóa interval cũ nếu có
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
        // Kiểm tra nếu có thông báo gửi lại OTP thì bắt đầu timer
        <>
          <c:if test="${not empty messageSuccess and messageSuccess.contains('Mã OTP đã được gửi lại')}">
            startTimer();
          </c:if>

          <c:if test="${empty messageSuccess or !messageSuccess.contains('Mã OTP đã được gửi lại')}">
            {/* Nếu không có flash attribute nào từ resend thì mới start */}
            <c:if test="${empty requestScope['SPRING_REDIRECT_FLASH_ATTRIBUTES'].messageSuccess}">
              startTimer();
            </c:if>
          </c:if>
        </>;
      });
    </script>
  </body>
</html>
