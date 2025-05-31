<!-- JSP Path: client/auth/register.jsp --><%@page contentType="text/html"
pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %> <%@ taglib prefix="security"
uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="utf-8" />
    <title>Đăng Ký Tài Khoản - 3TLap</title>
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
      <div class="card auth-card" style="max-width: 550px">
        <div class="card-header">
          <a href="<c:url value='/home'/>" class="logo-text-auth">3TLap</a>
          <h3 class="font-weight-light my-1">Tạo Tài Khoản Mới</h3>
        </div>
        <div class="card-body p-4">
          <c:if test="${not empty messageError}">
            <div class="alert alert-danger alert-auth my-3" role="alert">
              ${messageError}
            </div>
          </c:if>
          <c:if test="${param.oauth2_error != null}">
            <div class="alert alert-danger alert-auth my-3" role="alert">
              Đăng ký bằng Google thất bại. Vui lòng thử lại.
            </div>
          </c:if>

          <form:form
            method="post"
            action="/register"
            modelAttribute="registerDTO"
          >
            <div class="row mb-3">
              <div class="col-md-6">
                <div class="form-floating mb-3 mb-md-0">
                  <form:input
                    path="firstName"
                    cssClass="form-control"
                    id="inputFirstName"
                    type="text"
                    placeholder="Họ"
                  />
                  <label for="inputFirstName">Họ</label>
                  <form:errors path="firstName" cssClass="form-error" />
                </div>
              </div>
              <div class="col-md-6">
                <div class="form-floating">
                  <form:input
                    path="lastName"
                    cssClass="form-control"
                    id="inputLastName"
                    type="text"
                    placeholder="Tên"
                  />
                  <label for="inputLastName">Tên</label>
                  <form:errors path="lastName" cssClass="form-error" />
                </div>
              </div>
            </div>

            <div class="form-floating mb-3">
              <form:input
                path="email"
                cssClass="form-control"
                id="inputEmail"
                type="email"
                placeholder="name@example.com"
              />
              <label for="inputEmail">Địa chỉ Email</label>
              <form:errors path="email" cssClass="form-error" />
            </div>

            <div class="row mb-3">
              <div class="col-md-6">
                <div class="form-floating mb-3 mb-md-0">
                  <form:input
                    path="password"
                    cssClass="form-control"
                    id="inputPassword"
                    type="password"
                    placeholder="Tạo mật khẩu"
                  />
                  <label for="inputPassword">Mật khẩu</label>
                  <form:errors path="password" cssClass="form-error" />
                </div>
              </div>
              <div class="col-md-6">
                <div class="form-floating">
                  <form:input
                    path="confirmPassword"
                    cssClass="form-control"
                    id="inputPasswordConfirm"
                    type="password"
                    placeholder="Xác nhận mật khẩu"
                  />
                  <label for="inputPasswordConfirm">Xác nhận Mật khẩu</label>
                  <form:errors path="confirmPassword" cssClass="form-error" />
                </div>
              </div>
            </div>
            <form:errors
              path="*"
              cssClass="form-error alert alert-danger p-2 small"
              element="div"
            />

            <div class="mt-4 mb-3 d-grid">
              <button type="submit" class="btn btn-primary btn-lg">
                Tạo Tài Khoản
              </button>
            </div>
            <security:csrfInput />
          </form:form>

          <div class="divider-text my-4"><span>HOẶC</span></div>

          <div class="d-grid">
            <a
              href="<c:url value='/auth/google'/>"
              class="btn btn-google btn-lg"
            >
              <i class="fab fa-google me-2"></i> Tiếp tục với Google
            </a>
          </div>
        </div>
        <div class="card-footer">
          <div class="small">
            Đã có tài khoản?
            <a href="<c:url value='/login'/>" class="text-primary fw-medium"
              >Đăng nhập</a
            >
          </div>
        </div>
      </div>
    </div>

    <jsp:include page="../layout/common_scripts.jsp" />
  </body>
</html>
