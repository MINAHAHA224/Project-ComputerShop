<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!-- JSP Path: client/cart/thanks.jsp -->
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Đặt hàng thành công - Laptopshop</title>
    <%--
    <jsp:include page="../layout/common_head.jsp" />
    &lt;%&ndash; Giả sử bạn có file này cho common head &ndash;%&gt;--%>
    <link href="/client/css/bootstrap.min.css" rel="stylesheet" />
    <link href="/client/css/style.css" rel="stylesheet" />
    <style>
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
        color: #28a745; /* Màu xanh lá cây thành công */
        margin-bottom: 20px;
      }
      .icon-warning {
        font-size: 5rem;
        color: #ffc107; /* Màu vàng cảnh báo */
        margin-bottom: 20px;
      }
      .icon-error {
        font-size: 5rem;
        color: #dc3545; /* Màu đỏ lỗi */
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
          <h1 class="display-4">Cảm ơn bạn!</h1>
          <p class="lead">${successMessage}</p>
        </c:if>
        <c:if test="${not empty warningMessage}">
          <i class="fas fa-exclamation-triangle icon-warning"></i>
          <h1 class="display-4">Đặt hàng thành công!</h1>
          <p class="lead">${warningMessage}</p>
        </c:if>
        <c:if test="${not empty errorMessage}">
          <i class="fas fa-times-circle icon-error"></i>
          <h1 class="display-4">Đã có lỗi!</h1>
          <p class="lead">${errorMessage}</p>
        </c:if>

        <%-- Hiển thị thông báo mặc định nếu không có message cụ thể từ redirect
        --%>
        <c:if
          test="${empty successMessage && empty warningMessage && empty errorMessage}"
        >
          <i class="fas fa-check-circle icon-success"></i>
          <h1 class="display-4">Đặt hàng của bạn đã được tiếp nhận!</h1>
        </c:if>

        <c:if test="${not empty orderId}">
          <p>Mã đơn hàng của bạn là: <strong>#${orderId}</strong></p>
        </c:if>
        <p>Chúng tôi sẽ xử lý đơn hàng của bạn sớm nhất có thể.</p>
        <hr />
        <p>Gặp vấn đề? <a href="/contact">Liên hệ chúng tôi</a></p>
        <p class="lead">
          <a class="btn btn-primary btn-sm" href="/home" role="button"
            >Tiếp tục mua sắm</a
          >
        </p>
      </div>
    </div>
    <div
      class="toast-container position-fixed top-0 end-0 p-3"
      style="z-index: 1100"
    ></div>

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
    <%--<jsp:include page="../layout/common_scripts.jsp" /> &lt;%&ndash; Giả sử
    bạn có file này cho common scripts &ndash;%&gt;--%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/client/js/main.js"></script>
  </body>
</html>
