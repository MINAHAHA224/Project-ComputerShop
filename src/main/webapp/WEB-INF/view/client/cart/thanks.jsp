<%--src/main/webapp/WEB-INF/view/client/cart/thanks.jsp--%> <%@page
contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="spring"
uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
  <head>
    <meta charset="UTF-8" />
    <title><spring:message code="page.thanks.meta.title"/></title>

    <jsp:include page="../layout/common_head_links.jsp" />

    <link
      href="<c:url value='/client/css/bootstrap.min.css'/>"
      rel="stylesheet"
    />
    <%-- Cân nhắc dùng c:url --%>
    <link href="<c:url value='/client/css/style.css'/>" rel="stylesheet" />
    <%-- Cân nhắc dùng c:url --%>
    <style>
      /* CSS giữ nguyên */
      .thank-you-container {
        min-height: 60vh;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        text-align: center;
      }
      .icon-success {
        font-size: 5rem;
        color: #28a745;
        margin-bottom: 20px;
      }
      .icon-warning {
        font-size: 5rem;
        color: #ffc107;
        margin-bottom: 20px;
      }
      .icon-error {
        font-size: 5rem;
        color: #dc3545;
        margin-bottom: 20px;
      }
    </style>
  </head>
  <body>
    <jsp:include page="../layout/header.jsp" />

    <div class="container-fluid py-5">
      <div class="container py-5 thank-you-container">
        <c:if test="${not empty successMessage}">
          <i class="fas fa-check-circle icon-success"></i>
          <h1 class="display-4">
            <spring:message code="page.thanks.header.success" />
          </h1>
          <p class="lead">${successMessage}</p>
          <%-- Nếu successMessage là key, dùng
          <spring:message code="${successMessage}" /> --%>
        </c:if>
        <c:if test="${not empty warningMessage}">
          <i class="fas fa-exclamation-triangle icon-warning"></i>
          <h1 class="display-4">
            <spring:message code="page.thanks.header.warning" />
          </h1>
          <p class="lead">${warningMessage}</p>
          <%-- Nếu warningMessage là key, dùng
          <spring:message code="${warningMessage}" /> --%>
        </c:if>
        <c:if test="${not empty errorMessage}">
          <i class="fas fa-times-circle icon-error"></i>
          <h1 class="display-4">
            <spring:message code="page.thanks.header.error" />
          </h1>
          <p class="lead">${errorMessage}</p>
          <%-- Nếu errorMessage là key, dùng
          <spring:message code="${errorMessage}" /> --%>
        </c:if>

        <c:if
          test="${empty successMessage && empty warningMessage && empty errorMessage}"
        >
          <i class="fas fa-check-circle icon-success"></i>
          <h1 class="display-4">
            <spring:message code="page.thanks.header.default" />
          </h1>
        </c:if>

        <c:if test="${not empty orderId}">
          <p>
            <spring:message code="page.thanks.orderId.prefix" />
            <strong>#${orderId}</strong
            ><spring:message code="page.thanks.orderId.suffix" />
          </p>
        </c:if>
        <p><spring:message code="page.thanks.processingMessage" /></p>
        <hr />
        <p>
          <spring:message code="page.thanks.issue.prompt" />
          <a href="<c:url value='/contact-us'/>"
            ><spring:message code="page.thanks.issue.contactLink"
          /></a>
        </p>
        <p class="lead">
          <a
            class="btn btn-primary btn-sm"
            href="<c:url value='/home'/>"
            role="button"
            ><spring:message code="page.thanks.button.continueShopping"
          /></a>
        </p>
      </div>
    </div>
    <c:if test="${not empty param.messageSuccess || not empty messageSuccess}">
      <div
        id="toast-message-success"
        class="d-none"
        data-message="${param.messageSuccess}${messageSuccess}"
      ></div>
    </c:if>
    <c:if test="${not empty param.messageError || not empty messageError}">
      <div
        id="toast-message-error"
        class="d-none"
        data-message="${param.messageError}${messageError}"
      ></div>
    </c:if>
    <c:if
      test="${not empty requestScope['SPRING_REDIRECT_FLASH_ATTRIBUTES'].messageSuccess}"
    >
      <div
        id="flash-toast-message-success"
        class="d-none"
        data-message="${requestScope['SPRING_REDIRECT_FLASH_ATTRIBUTES'].messageSuccess}"
      ></div>
    </c:if>
    <c:if
      test="${not empty requestScope['SPRING_REDIRECT_FLASH_ATTRIBUTES'].messageError}"
    >
      <div
        id="flash-toast-message-error"
        class="d-none"
        data-message="${requestScope['SPRING_REDIRECT_FLASH_ATTRIBUTES'].messageError}"
      ></div>
    </c:if>

    <jsp:include page="../layout/chatbot_widget.jsp" />
    <jsp:include page="../layout/footer.jsp" />
    <jsp:include page="../layout/common_scripts.jsp" />
  </body>
</html>
