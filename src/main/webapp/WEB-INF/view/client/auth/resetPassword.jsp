<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %> <%-- Thêm taglib cho Spring
Form --%>
<!-- JSP Path: client/auth/resetPassword.jsp -->
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Đặt lại mật khẩu</title>
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
    />
    <style>
      .error-message {
        color: red;
        font-size: 0.9em;
      }
    </style>
  </head>
  <body>
    <div class="container mt-5">
      <div class="row justify-content-center">
        <div class="col-md-6">
          <div class="card shadow-lg">
            <div class="card-header bg-primary text-white text-center">
              <h4>Đặt lại mật khẩu</h4>
            </div>

            <div class="card-body">
              <%-- Hiển thị thông báo chung từ verifyOtp (nếu có) --%>
              <c:if test="${not empty message}">
                <div class="alert alert-info my-2" role="alert">${message}</div>
              </c:if>

              <%-- Hiển thị thông báo lỗi từ postResetPassword (nếu có) --%>
              <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger my-2" role="alert">
                  ${errorMessage}
                </div>
              </c:if>

              <%-- Sử dụng spring form tag. modelAttribute="resetPasswordDTO"
              phải khớp với tên attribute trong model. Controller đã add
              "resetPasswordDTO" vào model. --%>
              <form:form
                modelAttribute="resetPasswordDTO"
                action="${pageContext.request.contextPath}/resetPassword"
                method="post"
              >
                <%-- Trường ẩn để gửi email, bind tới resetPasswordDTO.email
                --%>
                <form:hidden path="email" />
                <%-- Nếu bạn muốn hiển thị email cho người dùng (chỉ đọc) --%>
                <div class="mb-3">
                  <label class="form-label">Email:</label>
                  <input
                    type="text"
                    class="form-control"
                    value="${resetPasswordDTO.email}"
                    readonly
                  />
                </div>

                <div class="mb-3">
                  <label for="password" class="form-label">Mật khẩu mới:</label>
                  <form:password
                    path="password"
                    cssClass="form-control"
                    id="password"
                    placeholder="Nhập mật khẩu mới"
                  />
                  <form:errors
                    path="password"
                    cssClass="error-message d-block"
                  />
                  <%-- Hiển thị lỗi cho trường password --%>
                </div>

                <div class="mb-3">
                  <label for="confirmPassword" class="form-label"
                    >Xác nhận mật khẩu mới:</label
                  >
                  <form:password
                    path="confirmPassword"
                    cssClass="form-control"
                    id="confirmPassword"
                    placeholder="Xác nhận mật khẩu mới"
                  />
                  <form:errors
                    path="confirmPassword"
                    cssClass="error-message d-block"
                  />
                  <%-- Hiển thị lỗi cho trường confirmPassword --%>
                </div>

                <%-- Hiển thị lỗi chung của cả DTO (từ class-level validation
                @ResetPasswordChecked) --%> <%-- Spring không tự động hiển thị
                lỗi toàn cục (object error) cho DTO với form:errors path="*" khi
                dùng addPropertyNode. Nó sẽ gắn lỗi đó vào node đã chỉ định. Tuy
                nhiên, nếu custom validator của bạn có lỗi chung không gắn với
                field cụ thể, hoặc nếu bạn muốn một chỗ chung để hiển thị lỗi từ
                @ResetPasswordChecked, bạn có thể kiểm tra
                BindingResult.globalErrors. Trong trường hợp validator của bạn,
                nó đã addPropertyNode nên lỗi sẽ xuất hiện ở field. --%>
                <form:errors
                  path="*"
                  cssClass="error-message alert alert-danger"
                  element="div"
                />

                <button type="submit" class="btn btn-primary w-100">
                  Đặt lại mật khẩu
                </button>
              </form:form>

              <div class="text-center mt-3">
                <a href="<c:url value='/login'/>">Quay lại Đăng nhập</a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
