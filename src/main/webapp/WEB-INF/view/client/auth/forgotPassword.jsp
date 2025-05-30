<!-- JSP Path: client/auth/forgotPassword.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="utf-8" />
    <title>Quên Mật Khẩu - 3TLap</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <jsp:include page="../layout/common_head_links.jsp" />
    <link href="<c:url value='/client/css/auth-pages.css'/>" rel="stylesheet" />
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
      <div class="card auth-card">
        <div class="card-header">
          <a href="<c:url value='/'/>" class="logo-text-auth">3TLap</a>
          <h3 class="font-weight-light my-1">Quên Mật Khẩu</h3>
        </div>
        <div class="card-body">
          <p class="text-muted text-center mb-4">
            Nhập địa chỉ email đã đăng ký để nhận mã OTP đặt lại mật khẩu.
          </p>
          <c:if test="${not empty messageError}">
            <div class="alert alert-danger alert-auth my-3" role="alert">
              ${messageError}
            </div>
          </c:if>
          <c:if test="${not empty messageSuccess}">
            <div class="alert alert-success alert-auth my-3" role="alert">
              ${messageSuccess}
            </div>
          </c:if>

          <form action="<c:url value='/forgotPassword'/>" method="post">
            <div class="form-floating mb-3">
              <input
                type="email"
                class="form-control"
                id="email"
                name="email"
                placeholder="example@gmail.com"
                required
                value="${email}"
              />
              <label for="email">Địa chỉ Email</label>
            </div>
            <div class="d-grid mt-4 mb-0">
              <button type="submit" class="btn btn-primary btn-lg">
                Gửi Mã OTP
              </button>
            </div>
            <security:csrfInput />
          </form>
        </div>
        <div class="card-footer">
          <div class="small">
            <a href="<c:url value='/login'/>" class="text-primary fw-medium"
              >Quay lại Đăng nhập</a
            >
          </div>
        </div>
      </div>
    </div>

    <jsp:include page="../layout/common_scripts.jsp" />
  </body>
</html>
