<!-- JSP Path: client/auth/resetPassword.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %> <%@ taglib prefix="security"
uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="utf-8" />
    <title>Đặt Lại Mật Khẩu - 3TLap</title>
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

    <div class="auth-wrapper">
      <div class="card auth-card">
        <div class="card-header">
          <a href="<c:url value='/'/>" class="logo-text-auth">3TLap</a>
          <h3 class="font-weight-light my-1">Tạo Mật Khẩu Mới</h3>
        </div>
        <div class="card-body">
          <p class="text-muted text-center mb-3">
            Vui lòng nhập mật khẩu mới cho tài khoản:
            <strong class="text-dark">${resetPasswordDTO.email}</strong>
          </p>

          <c:if
            test="${not empty messageSuccess and not messageSuccess.contains('Xác thực mã OTP thành công')}"
          >
            <div class="alert alert-success alert-auth my-3" role="alert">
              ${messageSuccess}
            </div>
          </c:if>
          <c:if test="${not empty messageError}">
            <div class="alert alert-danger alert-auth my-3" role="alert">
              ${messageError}
            </div>
          </c:if>

          <c:if
            test="${param.from == 'verifyOtp' && not empty requestScope['SPRING_REDIRECT_FLASH_ATTRIBUTES'].messageSuccess}"
          >
            <div class="alert alert-info alert-auth my-3" role="alert">
              ${requestScope['SPRING_REDIRECT_FLASH_ATTRIBUTES'].messageSuccess}
            </div>
          </c:if>

          <form:form
            modelAttribute="resetPasswordDTO"
            action="/resetPassword"
            method="post"
          >
            <form:hidden path="email" />
            <security:csrfInput />

            <div class="form-floating mb-3">
              <form:password
                path="password"
                cssClass="form-control"
                id="inputPassword"
                placeholder="Mật khẩu mới"
              />
              <label for="inputPassword">Mật khẩu mới</label>
              <form:errors path="password" cssClass="form-error" />
            </div>

            <div class="form-floating mb-3">
              <form:password
                path="confirmPassword"
                cssClass="form-control"
                id="inputPasswordConfirm"
                placeholder="Xác nhận mật khẩu mới"
              />
              <label for="inputPasswordConfirm">Xác nhận mật khẩu mới</label>
              <form:errors path="confirmPassword" cssClass="form-error" />
            </div>

            <form:errors
              path="*"
              cssClass="form-error alert alert-danger p-2 small"
              element="div"
            />

            <div class="d-grid mt-4 mb-0">
              <button type="submit" class="btn btn-primary btn-lg">
                Đặt Lại Mật Khẩu
              </button>
            </div>
          </form:form>
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
