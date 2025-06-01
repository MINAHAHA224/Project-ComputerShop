<%-- JSP Path: src/main/webapp/WEB-INF/view/client/auth/resetPassword.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %> <%@ taglib prefix="security"
uri="http://www.springframework.org/security/tags" %> <%@ taglib prefix="spring"
uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
  <head>
    <meta charset="utf-8" />
    <title><spring:message code="page.resetPassword.meta.title"/></title>
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
        <spring:message code="page.resetPassword.video.notSupported" />
      </video>
    </div>
    <div class="auth-wrapper">
      <div class="card auth-card">
        <div class="card-header">
          <a href="<c:url value='/'/>" class="logo-text-auth"
            ><spring:message code="page.resetPassword.header.brandName"
          /></a>
          <h3 class="font-weight-light my-1">
            <spring:message code="page.resetPassword.header.title" />
          </h3>
        </div>
        <div class="card-body">
          <jsp:include page="../layout/_language_switcher.jsp" />

          <p class="text-muted text-center mb-3">
            <spring:message code="page.resetPassword.instruction.text1" />
            <strong class="text-dark">${resetPasswordDTO.email}</strong> <%--
            Email giữ nguyên, không dịch --%>
          </p>
          <%-- Các message success/error từ flash attributes hoặc model
          attributes giữ nguyên --%> <%-- Nếu các biến này chứa key, bạn sẽ cần
          dùng <spring:message code="${...}" /> --%>
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
              <spring:message
                code="page.resetPassword.form.placeholder.newPassword"
                var="newPasswordPlaceholder"
              />
              <form:password
                path="password"
                cssClass="form-control"
                id="inputPassword"
                placeholder="${newPasswordPlaceholder}"
              />
              <label for="inputPassword"
                ><spring:message
                  code="page.resetPassword.form.label.newPassword"
              /></label>
              <form:errors path="password" cssClass="form-error" /> <%-- Lỗi từ
              validator tùy chỉnh đã được dịch --%>
            </div>
            <div class="form-floating mb-3">
              <spring:message
                code="page.resetPassword.form.placeholder.confirmNewPassword"
                var="confirmNewPasswordPlaceholder"
              />
              <form:password
                path="confirmPassword"
                cssClass="form-control"
                id="inputPasswordConfirm"
                placeholder="${confirmNewPasswordPlaceholder}"
              />
              <label for="inputPasswordConfirm"
                ><spring:message
                  code="page.resetPassword.form.label.confirmNewPassword"
              /></label>
              <form:errors path="confirmPassword" cssClass="form-error" /> <%--
              Lỗi từ validator tùy chỉnh đã được dịch --%>
            </div>
            <form:errors
              path="*"
              cssClass="form-error alert alert-danger p-2 small"
              element="div"
            />
            <%-- Lỗi chung từ validator tùy chỉnh đã được dịch --%>
            <div class="d-grid mt-4 mb-0">
              <button type="submit" class="btn btn-primary btn-lg">
                <spring:message code="page.resetPassword.form.button.submit" />
              </button>
            </div>
          </form:form>
        </div>
        <div class="card-footer">
          <div class="small">
            <a href="<c:url value='/login'/>" class="text-primary fw-medium"
              ><spring:message code="page.resetPassword.footer.backToLogin"
            /></a>
          </div>
        </div>
      </div>
    </div>
    <jsp:include page="../layout/common_scripts.jsp" />
  </body>
</html>
