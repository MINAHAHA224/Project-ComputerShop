<%-- JSP Path: src/main/webapp/WEB-INF/view/client/auth/register.jsp --%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
<head>
  <meta charset="utf-8" />
  <title><spring:message code="page.register.meta.title"/></title>
  <meta content="width=device-width, initial-scale=1.0" name="viewport" />
  <jsp:include page="../layout/common_head_links.jsp" />
  <link href="<c:url value='/client/css/auth-pages.css'/>" rel="stylesheet" />
</head>
<body class="auth-page-bg">
<div id="spinner" class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center">
  <div class="spinner-grow text-primary" role="status"></div>
</div>
<div class="auth-video-background-container">
  <video autoplay muted loop playsinline id="authVideoBackground">
    <source src="<c:url value='/client/video/auth-background.mp4'/>" type="video/mp4"/>
    <spring:message code="page.register.video.notSupported"/>
  </video>
</div>
<div class="auth-wrapper">
  <div class="card auth-card" style="max-width: 550px">
    <div class="card-header">
      <a href="<c:url value='/'/>" class="logo-text-auth"><spring:message code="page.register.header.brandName"/></a>
      <h3 class="font-weight-light my-1"><spring:message code="page.register.header.title"/></h3>
    </div>
    <div class="card-body p-4">
      <jsp:include page="../layout/_language_switcher.jsp" />

      <c:if test="${not empty messageError}">
        <div class="alert alert-danger alert-auth my-3" role="alert">
            ${messageError} <%-- Nếu messageError là key, dùng <spring:message code="${messageError}"/> --%>
        </div>
      </c:if>
      <c:if test="${param.oauth2_error != null}">
        <div class="alert alert-danger alert-auth my-3" role="alert">
          <spring:message code="page.register.error.googleFailed"/>
        </div>
      </c:if>

      <form:form method="post" action="/register" modelAttribute="registerDTO">
        <div class="row mb-3">
          <div class="col-md-6">
            <div class="form-floating mb-3 mb-md-0">
              <spring:message code="page.register.form.placeholder.firstName" var="firstNamePlaceholder"/>
              <form:input
                      path="firstName"
                      cssClass="form-control"
                      id="inputFirstName"
                      type="text"
                      placeholder="${firstNamePlaceholder}"
              />
              <label for="inputFirstName"><spring:message code="page.register.form.label.firstName"/></label>
              <form:errors path="firstName" cssClass="form-error" /> <%-- Error messages từ DTO đã được dịch --%>
            </div>
          </div>
          <div class="col-md-6">
            <div class="form-floating">
              <spring:message code="page.register.form.placeholder.lastName" var="lastNamePlaceholder"/>
              <form:input
                      path="lastName"
                      cssClass="form-control"
                      id="inputLastName"
                      type="text"
                      placeholder="${lastNamePlaceholder}"
              />
              <label for="inputLastName"><spring:message code="page.register.form.label.lastName"/></label>
              <form:errors path="lastName" cssClass="form-error" /> <%-- Error messages từ DTO đã được dịch --%>
            </div>
          </div>
        </div>
        <div class="form-floating mb-3">
          <spring:message code="page.register.form.placeholder.email" var="emailPlaceholder"/>
          <form:input
                  path="email"
                  cssClass="form-control"
                  id="inputEmail"
                  type="email"
                  placeholder="${emailPlaceholder}"
          />
          <label for="inputEmail"><spring:message code="page.register.form.label.email"/></label>
          <form:errors path="email" cssClass="form-error" /> <%-- Error messages từ DTO đã được dịch --%>
        </div>
        <div class="row mb-3">
          <div class="col-md-6">
            <div class="form-floating mb-3 mb-md-0">
              <spring:message code="page.register.form.placeholder.password" var="passwordPlaceholder"/>
              <form:input
                      path="password"
                      cssClass="form-control"
                      id="inputPassword"
                      type="password"
                      placeholder="${passwordPlaceholder}"
              />
              <label for="inputPassword"><spring:message code="page.register.form.label.password"/></label>
              <form:errors path="password" cssClass="form-error" /> <%-- Error messages từ DTO đã được dịch --%>
            </div>
          </div>
          <div class="col-md-6">
            <div class="form-floating">
              <spring:message code="page.register.form.placeholder.confirmPassword" var="confirmPasswordPlaceholder"/>
              <form:input
                      path="confirmPassword"
                      cssClass="form-control"
                      id="inputPasswordConfirm"
                      type="password"
                      placeholder="${confirmPasswordPlaceholder}"
              />
              <label for="inputPasswordConfirm"><spring:message code="page.register.form.label.confirmPassword"/></label>
              <form:errors path="confirmPassword" cssClass="form-error" /> <%-- Error messages từ DTO đã được dịch --%>
            </div>
          </div>
        </div>
        <form:errors
                path="*"
                cssClass="form-error alert alert-danger p-2 small"
                element="div"
        /> <%-- Các lỗi chung từ validator tùy chỉnh đã được dịch --%>
        <div class="mt-4 mb-3 d-grid">
          <button type="submit" class="btn btn-primary btn-lg">
            <spring:message code="page.register.form.button.submit"/>
          </button>
        </div>
        <security:csrfInput />
      </form:form>

      <div class="divider-text my-4"><span><spring:message code="page.register.divider.or"/></span></div>

      <div class="d-grid">
        <a
                href="<c:url value='/auth/google'/>"
                class="btn btn-google btn-lg"
        >
          <i class="fab fa-google me-2"></i> <spring:message code="page.register.button.google"/>
        </a>
      </div>
    </div>
    <div class="card-footer">
      <div class="small">
        <spring:message code="page.register.footer.hasAccount"/>
        <a href="<c:url value='/login'/>" class="text-primary fw-medium"><spring:message code="page.register.footer.login"/></a>
      </div>
    </div>
  </div>
</div>
<jsp:include page="../layout/common_scripts.jsp" />
</body>
</html>