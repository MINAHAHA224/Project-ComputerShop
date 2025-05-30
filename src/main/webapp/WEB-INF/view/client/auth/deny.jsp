<!-- JSP Path: client/auth/deny.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="utf-8" />
    <title>Truy Cập Bị Từ Chối - 3TLap</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <jsp:include page="../layout/common_head_links.jsp" />
    <link href="<c:url value='/client/css/auth-pages.css'/>" rel="stylesheet" />
    <style>
      .deny-page-content {
        text-align: center;
        padding-top: 3rem;
        padding-bottom: 3rem;
      }
      .deny-page-content .icon-error {
        font-size: 5rem;
        color: var(--danger-color);
        margin-bottom: 1.5rem;
      }
      .deny-page-content h1 {
        font-family: var(--font-primary);
        font-weight: 700;
        color: var(--danger-color);
        margin-bottom: 1rem;
      }
      .deny-page-content p {
        font-size: 1.1rem;
        color: var(--text-muted-color);
        margin-bottom: 2rem;
      }
    </style>
  </head>
  <body class="auth-page-bg">
    <div
      id="spinner"
      class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center"
    >
      <div class="spinner-grow text-primary" role="status"></div>
    </div>

    <jsp:include page="../layout/header.jsp" />

    <div class="container">
      <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
          <div class="card auth-card my-5">
            <div class="card-body deny-page-content">
              <i class="fas fa-ban icon-error"></i>
              <h1>Truy Cập Bị Từ Chối!</h1>
              <p>
                Rất tiếc, bạn không có quyền truy cập vào trang này. Vui lòng
                kiểm tra lại quyền hạn tài khoản của bạn hoặc liên hệ với quản
                trị viên nếu bạn cho rằng đây là một nhầm lẫn.
              </p>
              <div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
                <a
                  href="<c:url value='/home' />"
                  class="btn btn-primary btn-lg px-4 gap-3"
                  >Về Trang Chủ</a
                >
                <a
                  href="javascript:history.back()"
                  class="btn btn-outline-secondary btn-lg px-4"
                  >Quay Lại</a
                >
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <jsp:include page="../layout/footer.jsp" />
    <jsp:include page="../layout/common_scripts.jsp" />
  </body>
</html>
