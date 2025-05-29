<%--<!-- verifyOTP.jsp -->--%> <%--<%@ page
contentType="text/html;charset=UTF-8" language="java" %>--%> <%--<%@ taglib
prefix="c" uri="http://java.sun.com/jstl/core" %>--%> <%--<!DOCTYPE html>--%>
<%--
<html lang="en">
  --%> <%--<head>
    --%> <%--
    <meta charset="UTF-8" />
    --%> <%--
    <title>Xác nhận mã OTP</title>
    --%> <%--
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
    />
    --%> <%--
    <style>
      --%>
      <%--        .form-actions {--%>
      <%--            display: flex;--%>
      <%--            gap: 10px; /* Khoảng cách giữa các nút */--%>
      <%--        }--%>
      <%--        .form-actions button {--%>
      <%--            flex-grow: 1; /* Các nút chia đều không gian */--%>
      <%--        }--%>
      <%--
    </style>
    --%> <%--</head
  >--%> <%--
  <body>
    --%> <%--
    <div class="container mt-5">
      --%> <%--
      <div class="row justify-content-center">
        --%> <%--
        <div class="col-md-6">
          &lt;%&ndash; Tăng độ rộng một chút để chứa thông báo và nút
          &ndash;%&gt;--%> <%--
          <div class="card shadow-lg">
            --%> <%--
            <div class="card-header bg-primary text-white text-center">
              --%> <%--
              <h4>Xác nhận mã OTP</h4>
              --%> <%--
            </div>
            --%> <%--
            <div class="card-body">
              --%> <%--
              <c:if test="${not empty message}"
                >--%> <%-- &lt;%&ndash; Kiểm tra message chứa "không đúng" để
                dùng alert-danger, còn lại dùng alert-info &ndash;%&gt;--%> <%--
                <c:choose
                  >--%> <%--
                  <c:when
                    test="${message.contains('không đúng') or message.contains('lỗi xảy ra')}"
                    >--%> <%--
                    <div class="alert alert-danger my-2" role="alert">
                      --%> <%-- ${message}--%> <%--
                    </div>
                    --%> <%-- </c:when
                  >--%> <%--
                  <c:otherwise
                    >--%> <%--
                    <div class="alert alert-info my-2" role="alert">
                      --%> <%-- ${message}--%> <%--
                    </div>
                    --%> <%-- </c:otherwise
                  >--%> <%-- </c:choose
                >--%> <%-- </c:if
              >--%> <%--
              <p class="text-center">
                Một mã OTP đã được gửi đến địa chỉ email:
                <strong>${email}</strong>. Vui lòng kiểm tra hộp thư của bạn.
              </p>
              --%> <%-- &lt;%&ndash; Controller sẽ đảm bảo ${email} có sẵn từ
              flashAttribute hoặc được thêm vào model khi render lại
              &ndash;%&gt;--%> <%--
              <form action="<c:url value='/verifyOtp'/>" method="post">
                --%> <%--
                <!-- Trường ẩn để gửi email -->--%> <%--
                <input type="hidden" name="email" value="${email}" />--%> <%--
                <div class="mb-3">
                  --%> <%--
                  <label for="otp" class="form-label">Nhập mã OTP:</label>--%>
                  <%--
                  <input
                    type="text"
                    class="form-control"
                    id="otp"
                    name="OTP"
                    placeholder="Nhập mã OTP"
                  />--%> <%-- &lt;%&ndash; name="OTP" khớp với
                  @RequestParam(name = "OTP") trong controller.--%> <%-- Không
                  cần required ở đây vì có thể người dùng nhấn "Gửi lại OTP"
                  &ndash;%&gt;--%> <%--
                </div>
                --%> <%--
                <div class="form-actions mb-3">
                  --%> <%--
                  <button
                    type="submit"
                    name="action"
                    value="VERIFY-OTP"
                    class="btn btn-primary"
                  >
                    Xác nhận OTP</button
                  >--%> <%--
                  <button
                    type="submit"
                    name="action"
                    value="RESENT-OTP"
                    class="btn btn-secondary"
                    formnovalidate
                  >
                    Gửi lại OTP</button
                  >--%> <%-- &lt;%&ndash; formnovalidate cho nút gửi lại để
                  không check required của OTP input &ndash;%&gt;--%> <%--
                </div>
                --%> <%--
                <div class="text-center">
                  --%> <%--
                  <a href="<c:url value='/forgotPassword'/>"
                    >Quay lại nhập email</a
                  >--%> <%--
                </div>
                --%> <%--
              </form>
              --%> <%--
            </div>
            --%> <%--
          </div>
          --%> <%--
        </div>
        --%> <%--
      </div>
      --%> <%--
    </div>
    --%> <%--
  </body>
  --%> <%--
</html>
--%>

<!-- verifyOTP.jsp -->
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--<!DOCTYPE html>--%> <%--
<html lang="en">
  --%> <%--<head>
    --%> <%--
    <meta charset="UTF-8" />
    --%> <%--
    <title>Xác nhận mã OTP</title>
    --%> <%--
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
    />
    --%> <%--
    <style>
      --%>
      <%--        .form-actions {--%>
      <%--            display: flex;--%>
      <%--            gap: 10px; /* Khoảng cách giữa các nút */--%>
      <%--        }--%>
      <%--        .form-actions button {--%>
      <%--            flex-grow: 1; /* Các nút chia đều không gian */--%>
      <%--        }--%>
      <%--        #resendOtpBtn:disabled {--%>
      <%--            cursor: not-allowed;--%>
      <%--        }--%>
      <%--
    </style>
    --%> <%--</head
  >--%> <%--
  <body>
    --%> <%--
    <div class="container mt-5">
      --%> <%--
      <div class="row justify-content-center">
        --%> <%--
        <div class="col-md-6">
          --%> <%--
          <div class="card shadow-lg">
            --%> <%--
            <div class="card-header bg-primary text-white text-center">
              --%> <%--
              <h4>Xác nhận mã OTP</h4>
              --%> <%--
            </div>
            --%> <%--
            <div class="card-body">
              --%> <%--
              <c:if test="${not empty message}"
                >--%> <%--
                <c:choose
                  >--%> <%--
                  <c:when
                    test="${message.contains('không đúng') or message.contains('lỗi xảy ra') or message.toLowerCase().contains('error')}"
                    >--%> <%--
                    <div class="alert alert-danger my-2" role="alert">
                      --%> <%-- ${message}--%> <%--
                    </div>
                    --%> <%-- </c:when
                  >--%> <%--
                  <c:otherwise
                    >--%> <%--
                    <div class="alert alert-info my-2" role="alert">
                      --%> <%-- ${message}--%> <%--
                    </div>
                    --%> <%-- </c:otherwise
                  >--%> <%-- </c:choose
                >--%> <%-- </c:if
              >--%> <%--
              <p class="text-center">
                Một mã OTP đã được gửi đến địa chỉ email:
                <strong>${email}</strong>. Vui lòng kiểm tra hộp thư của bạn.
              </p>
              --%> <%--
              <form
                id="verifyOtpForm"
                action="<c:url value='/verifyOtp'/>"
                method="post"
              >
                --%> <%--
                <input type="hidden" name="email" value="${email}" />--%> <%--
                <div class="mb-3">
                  --%> <%--
                  <label for="otp" class="form-label">Nhập mã OTP:</label>--%>
                  <%--
                  <input
                    type="text"
                    class="form-control"
                    id="otp"
                    name="OTP"
                    placeholder="Nhập mã OTP"
                  />--%> <%--
                </div>
                --%> <%--
                <div class="form-actions mb-3">
                  --%> <%--
                  <button
                    type="submit"
                    name="action"
                    value="VERIFY-OTP"
                    class="btn btn-primary"
                  >
                    Xác nhận OTP</button
                  >--%> <%--
                  <button
                    type="submit"
                    id="resendOtpBtn"
                    name="action"
                    value="RESENT-OTP"
                    class="btn btn-secondary"
                    formnovalidate
                  >
                    --%> <%-- Gửi lại OTP <span id="countdownTimer"></span>--%>
                    <%--</button
                  >--%> <%--
                </div>
                --%> <%--
                <div class="text-center">
                  --%> <%--
                  <a href="<c:url value='/forgotPassword'/>"
                    >Quay lại nhập email</a
                  >--%> <%--
                </div>
                --%> <%--
              </form>
              --%> <%--
            </div>
            --%> <%--
          </div>
          --%> <%--
        </div>
        --%> <%--
      </div>
      --%> <%--
    </div>
    --%> <%--
    <script>
      --%>
      <%--    document.addEventListener('DOMContentLoaded', function () {--%>
      <%--        const resendButton = document.getElementById('resendOtpBtn');--%>
      <%--        const countdownTimerSpan = document.getElementById('countdownTimer');--%>
      <%--        let countdownTime = 90; // 1 phút 30 giây = 90 giây--%>
      <%--        let timerInterval;--%>

      <%--        function startTimer() {--%>
      <%--            resendButton.disabled = true;--%>
      <%--            countdownTimerSpan.textContent = formatTime(countdownTime);--%>

      <%--            timerInterval = setInterval(function () {--%>
      <%--                countdownTime--;--%>
      <%--                countdownTimerSpan.textContent = formatTime(countdownTime);--%>

      <%--                if (countdownTime <= 0) {--%>
      <%--                    clearInterval(timerInterval);--%>
      <%--                    resendButton.disabled = false;--%>
      <%--                    countdownTimerSpan.textContent = ''; // Xóa bộ đếm khi hết giờ--%>
      <%--                    // Hoặc bạn có thể đổi lại text của nút--%>
      <%--                    // resendButton.innerHTML = 'Gửi lại OTP';--%>
      <%--                }--%>
      <%--            }, 1000);--%>
      <%--        }--%>

      <%--        function formatTime(seconds) {--%>
      <%--            const minutes = Math.floor(seconds / 60);--%>
      <%--            const remainingSeconds = seconds % 60;--%>
      <%--            const formattedMinutes = String(minutes).padStart(1, '0'); // Không cần padStart nếu chỉ là 1 chữ số phút--%>
      <%--            const formattedSeconds = String(remainingSeconds).padStart(2, '0');--%>
      <%--            return `(${formattedMinutes}:${formattedSeconds})`;--%>
      <%--        }--%>

      <%--        // Bắt đầu đếm ngược khi trang được tải--%>
      <%--        startTimer();--%>

      <%--        // Nếu người dùng click nút "Gửi lại OTP" và form được submit thành công (hoặc không thành công nhưng trang reload)--%>
      <%--        // và server có gửi lại thông báo "Đã gửi lại OTP", thì chúng ta cũng nên reset và bắt đầu lại timer.--%>
      <%--        // Điều này thường xảy ra khi trang được load lại sau khi nhấn "Gửi lại OTP".--%>
      <%--        // Vì vậy, việc startTimer() trong DOMContentLoaded là đủ trong hầu hết các trường hợp--%>
      <%--        // khi trang được render lại từ server.--%>

      <%--        // Nếu bạn muốn xử lý việc click nút "Gửi lại OTP" mà không reload trang (dùng AJAX),--%>
      <%--        // bạn sẽ cần gọi startTimer() sau khi gửi AJAX thành công.--%>
      <%--        // Với cách submit form truyền thống, việc gọi startTimer() khi trang tải là phù hợp.--%>
      <%--    });--%>
      <%--
    </script>
    --%> <%--
  </body>
  --%> <%--
</html>
--%>

<!-- JSP Path: client/auth/verifyOTP.jsp -->
<!-- verifyOTP.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Xác nhận mã OTP</title>
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
    />
    <style>
      .form-actions {
        display: flex;
        gap: 10px; /* Khoảng cách giữa các nút */
      }
      .form-actions button {
        flex-grow: 1; /* Các nút chia đều không gian */
      }
      #resendOtpBtn:disabled {
        cursor: not-allowed;
      }
    </style>
  </head>
  <body>
    <div class="container mt-5">
      <div class="row justify-content-center">
        <div class="col-md-6">
          <div class="card shadow-lg">
            <div class="card-header bg-primary text-white text-center">
              <h4>Xác nhận mã OTP</h4>
            </div>
            <div class="card-body">
              <c:if test="${not empty message}">
                <c:choose>
                  <c:when
                    test="${message.contains('không đúng') or message.contains('lỗi xảy ra') or message.toLowerCase().contains('error')}"
                  >
                    <div class="alert alert-danger my-2" role="alert">
                      ${message}
                    </div>
                  </c:when>
                  <c:otherwise>
                    <div class="alert alert-info my-2" role="alert">
                      ${message}
                    </div>
                  </c:otherwise>
                </c:choose>
              </c:if>

              <p class="text-center">
                Một mã OTP đã được gửi đến địa chỉ email:
                <strong>${email}</strong>. Vui lòng kiểm tra hộp thư của bạn.
              </p>

              <form
                id="verifyOtpForm"
                action="<c:url value='/verifyOtp'/>"
                method="post"
              >
                <input type="hidden" name="email" value="${email}" />

                <div class="mb-3">
                  <label for="otp" class="form-label">Nhập mã OTP:</label>
                  <input
                    type="text"
                    class="form-control"
                    id="otp"
                    name="OTP"
                    placeholder="123456"
                  />
                </div>

                <div class="form-actions mb-3">
                  <button
                    type="submit"
                    name="action"
                    value="VERIFY-OTP"
                    class="btn btn-primary"
                  >
                    Xác nhận OTP
                  </button>
                  <button
                    type="submit"
                    id="resendOtpBtn"
                    name="action"
                    value="RESENT-OTP"
                    class="btn btn-secondary"
                    formnovalidate
                  >
                    Gửi lại OTP <span id="countdownTimer"></span>
                  </button>
                </div>
                <div class="text-center">
                  <a href="<c:url value='/forgotPassword'/>"
                    >Quay lại nhập email</a
                  >
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>

    <script>
      document.addEventListener('DOMContentLoaded', function () {
        console.log('DOM fully loaded and parsed'); // DEBUG

        const resendButton = document.getElementById('resendOtpBtn');
        const countdownTimerSpan = document.getElementById('countdownTimer');

        // DEBUG: Kiểm tra xem element có được tìm thấy không
        if (!resendButton) {
          console.error("Element with ID 'resendOtpBtn' not found!");
          return;
        }
        if (!countdownTimerSpan) {
          console.error("Element with ID 'countdownTimer' not found!");
          return;
        }
        console.log('Elements found:', resendButton, countdownTimerSpan); // DEBUG

        let countdownTime = 90; // 1 phút 30 giây = 90 giây
        let timerInterval;

        function formatTime(seconds) {
          const minutes = Math.floor(seconds / 60);
          const remainingSeconds = seconds % 60;
          // Đảm bảo phút không cần pad nếu là 0 hoặc 1 chữ số, giây luôn 2 chữ số
          const formattedMinutes = String(minutes);
          const formattedSeconds = String(remainingSeconds).padStart(2, '0');
          const timeString = `(${formattedMinutes}:${formattedSeconds})`;
          // console.log(`formatTime: ${seconds}s -> ${timeString}`); // DEBUG (bỏ comment nếu cần)
          return timeString;
        }

        function startTimer() {
          console.log(
            'startTimer called. Initial countdownTime:',
            countdownTime
          ); // DEBUG
          resendButton.disabled = true;
          countdownTimerSpan.textContent = formatTime(countdownTime);
          console.log(
            'Initial time displayed:',
            countdownTimerSpan.textContent
          ); // DEBUG

          timerInterval = setInterval(function () {
            countdownTime--;
            countdownTimerSpan.textContent = formatTime(countdownTime);
            // console.log("Timer tick. New time:", countdownTimerSpan.textContent, "Raw seconds:", countdownTime); // DEBUG (có thể hơi nhiều log)

            if (countdownTime <= 0) {
              clearInterval(timerInterval);
              resendButton.disabled = false;
              countdownTimerSpan.textContent = ''; // Xóa bộ đếm khi hết giờ
              console.log('Timer finished. Button enabled.'); // DEBUG
            }
          }, 1000);
        }

        // Bắt đầu đếm ngược khi trang được tải
        startTimer();
      });
    </script>
  </body>
</html>
