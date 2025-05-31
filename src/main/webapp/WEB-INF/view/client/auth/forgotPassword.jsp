<%-- JSP Path: src/main/webapp/WEB-INF/view/client/auth/forgotPassword.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
<head>
  <meta charset="utf-8" />
  <title><spring:message code="page.forgotPassword.meta.title"/></title>
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
    <spring:message code="page.forgotPassword.video.notSupported"/>
  </video>
</div>
<div class="auth-wrapper">
  <div class="card auth-card">
    <div class="card-header">
      <a href="<c:url value='/'/>" class="logo-text-auth"><spring:message code="page.forgotPassword.header.brandName"/></a>
      <h3 class="font-weight-light my-1"><spring:message code="page.forgotPassword.header.title"/></h3>
    </div>
    <div class="card-body">
      <jsp:include page="../layout/_language_switcher.jsp" />

      <p class="text-muted text-center mb-4">
        <spring:message code="page.forgotPassword.instruction"/>
      </p>
      <%-- Các message success/error từ flash attributes hoặc model attributes giữ nguyên --%>
      <%-- Nếu các biến này chứa key, bạn sẽ cần dùng <spring:message code="${...}"/> --%>
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
          <spring:message code="page.forgotPassword.form.placeholder.email" var="emailPlaceholder"/>
          <input type="email" class="form-control" id="email" name="email" placeholder="${emailPlaceholder}" required value="${email}"/>
          <label for="email"><spring:message code="page.forgotPassword.form.label.email"/></label>
          <%-- Nếu có DTO và dùng <form:input>, lỗi validation sẽ được xử lý bởi <form:errors> --%>
          <%-- Hiện tại đang dùng thẻ <input> HTML thường, nên không có <form:errors> ở đây --%>
        </div>
        <div class="d-grid mt-4 mb-0">
          <button type="submit" class="btn btn-primary btn-lg">
            <spring:message code="page.forgotPassword.form.button.submit"/>
          </button>
        </div>
        <security:csrfInput />
      </form>
    </div>
    <div class="card-footer">
      <div class="small">
        <a href="<c:url value='/login'/>" class="text-primary fw-medium"><spring:message code="page.forgotPassword.footer.backToLogin"/></a>
      </div>
    </div>
  </div>
</div>
<jsp:include page="../layout/common_scripts.jsp" />
</body>
</html>