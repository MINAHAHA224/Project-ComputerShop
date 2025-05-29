<!-- JSP Path: client/auth/login.jsp -->
<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %> <%@ taglib prefix="security"
uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="utf-8" />
    <title>Đăng Nhập - 3TLap</title>
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
          <h3 class="font-weight-light my-1">Đăng Nhập Tài Khoản</h3>
        </div>
        <div class="card-body">
          <c:if test="${not empty param.error and empty messageError}">
            <div class="alert alert-danger alert-auth my-3" role="alert">
              Email hoặc mật khẩu không đúng. Vui lòng thử lại.
            </div>
          </c:if>
          <c:if test="${not empty param.logout}">
            <div class="alert alert-success alert-auth my-3" role="alert">
              Đăng xuất thành công!
            </div>
          </c:if>
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

          <form:form method="post" action="/login" modelAttribute="loginDTO">
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
            <div class="form-floating mb-3">
              <form:input
                path="password"
                cssClass="form-control"
                id="inputPassword"
                type="password"
                placeholder="Mật khẩu"
              />
              <label for="inputPassword">Mật khẩu</label>
              <form:errors path="password" cssClass="form-error" />
            </div>
            <div class="text-end mb-3">
              <a
                href="<c:url value='/forgotPassword'/>"
                class="small text-muted text-decoration-none"
                >Quên mật khẩu?</a
              >
            </div>
            <div class="d-grid mb-3">
              <button type="submit" class="btn btn-primary btn-lg">
                Đăng Nhập
              </button>
            </div>
            <security:csrfInput />
          </form:form>

          <div class="divider-text"><span>HOẶC</span></div>

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
            Chưa có tài khoản?
            <a href="<c:url value='/register'/>" class="text-primary fw-medium"
              >Đăng ký ngay!</a
            >
          </div>
        </div>
      </div>
    </div>

    <jsp:include page="../layout/common_scripts.jsp" />
  </body>
</html>
