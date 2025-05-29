<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ page
contentType="text/html;charset=UTF-8" language="java" %>
<!-- JSP Path: client/auth/forgotPassword.jsp -->
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Quên mật khẩu - Nhập Email</title>
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
    />
  </head>
  <body>
    <div class="container mt-5">
      <div class="row justify-content-center">
        <div class="col-md-5">
          <div class="card shadow-lg">
            <c:if test="${not empty message}">
              <%-- Sửa thành not empty cho an toàn hơn --%>
              <div class="alert alert-danger my-2 mx-3" role="alert">
                <%-- Thêm mx-3 cho đẹp hơn --%> ${message}
              </div>
            </c:if>
            <div class="card-header bg-primary text-white text-center">
              <h4>Quên mật khẩu</h4>
            </div>
            <div class="card-body">
              <%-- Sử dụng c:url để đảm bảo đường dẫn đúng, nhất là khi có
              context path --%>
              <form action="<c:url value='/forgotPassword'/>" method="post">
                <div class="mb-3">
                  <label for="email" class="form-label"
                    >Nhập địa chỉ Email của bạn:</label
                  >
                  <input
                    type="email"
                    class="form-control"
                    id="email"
                    name="email"
                    placeholder="example@gmail.com"
                    required
                    value="${email}"
                  />
                  <%-- Giữ lại email đã nhập nếu có lỗi: value="${param.email}"
                  hoặc value="${email}" nếu bạn add lại vào model --%>
                </div>
                <button type="submit" class="btn btn-primary w-100">
                  Gửi mã OTP
                </button>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
