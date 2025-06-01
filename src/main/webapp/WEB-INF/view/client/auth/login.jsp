<%-- JSP Path: src/main/webapp/WEB-INF/view/client/auth/login.jsp --%> <%@page
contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %> <%@ taglib prefix="security"
uri="http://www.springframework.org/security/tags" %> <%@ taglib prefix="spring"
uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="utf-8" />
    <title><spring:message code="page.login.title"/></title>
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
          <h3 class="font-weight-light my-1">
            <spring:message code="page.login.header" />
          </h3>
        </div>

        <div class="card-body">
          <%-- THÊM BỘ CHỌN NGÔN NGỮ Ở ĐÂY --%>
          <jsp:include page="../layout/_language_switcher.jsp" />

          <c:if test="${not empty param.error and empty messageError}">
            <div class="alert alert-danger alert-auth my-3" role="alert">
              <spring:message code="page.login.error.invalidCredentials" />
            </div>
          </c:if>
          <c:if test="${not empty param.logout}">
            <div class="alert alert-success alert-auth my-3" role="alert">
              <spring:message code="page.login.success.logout" />
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
            <%-- ... nội dung form ... --%>
            <div class="form-floating mb-3">
              <form:input
                path="email"
                cssClass="form-control"
                id="inputEmail"
                type="email"
                placeholder="name@example.com"
              />
              <label for="inputEmail"
                ><spring:message code="page.login.label.email"
              /></label>
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
              <label for="inputPassword"
                ><spring:message code="page.login.label.password"
              /></label>
              <form:errors path="password" cssClass="form-error" />
            </div>
            <div class="text-end mb-3">
              <a
                href="<c:url value='/forgotPassword'/>"
                class="small text-muted text-decoration-none"
                ><spring:message code="page.login.link.forgotPassword"
              /></a>
            </div>
            <div class="d-grid mb-3">
              <button type="submit" class="btn btn-primary btn-lg">
                <spring:message code="page.login.button.submit" />
              </button>
            </div>
            <security:csrfInput />
          </form:form>

          <div class="divider-text">
            <span><spring:message code="page.login.divider.or" /></span>
          </div>

          <div class="d-grid">
            <a
              href="<c:url value='/auth/google'/>"
              class="btn btn-google btn-lg"
            >
              <i class="fab fa-google me-2"></i
              ><spring:message code="page.login.button.google" />
            </a>
          </div>
        </div>
        <div class="card-footer">
          <div class="small">
            <spring:message code="page.login.footer.noAccount" />
            <a href="<c:url value='/register'/>" class="text-primary fw-medium"
              ><spring:message code="page.login.footer.registerNow"
            /></a>
          </div>
        </div>
      </div>
    </div>

    <jsp:include page="../layout/common_scripts.jsp" />
  </body>
</html>
