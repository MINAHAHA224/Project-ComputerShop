<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Login - Laptopshop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <link href="/css/login.css" rel="stylesheet" /> <!-- Giữ lại CSS tùy chỉnh của bạn nếu có -->
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <style>
        body {
            background-color: #f0f2f5; /* Một màu xám nhẹ nhàng hơn */
        }

        .card {
            border: none; /* Bỏ viền mặc định nếu muốn */
            border-radius: 0.75rem; /* Bo góc mềm mại hơn */
        }
        .card-header {
            border-top-left-radius: 0.75rem;
            border-top-right-radius: 0.75rem;
        }
        .card-footer {
            border-bottom-left-radius: 0.75rem;
            border-bottom-right-radius: 0.75rem;
        }

        .btn-google {
            background-color: #DB4437; /* Màu đỏ của Google */
            color: white;
            transition: background-color 0.3s;
        }
        .btn-google:hover {
            background-color: #c1392b;
            color: white;
        }

        .divider-text {
            position: relative;
            text-align: center;
            margin-top: 15px;
            margin-bottom: 15px;
        }
        .divider-text span {
            padding: 0 10px;
            background-color: #fff; /* Hoặc màu nền của card-body */
            position: relative;
            z-index: 1;
            color: #6c757d; /* Màu xám cho chữ "HOẶC" */
        }
        .divider-text:before {
            content: "";
            position: absolute;
            width: 100%;
            height: 1px;
            background-color: #dee2e6; /* Màu đường kẻ nhạt hơn */
            left: 0;
            top: 50%;
            z-index: 0;
        }
        .form-error { /* Class cho thông báo lỗi của Spring form:errors */
            color: #dc3545; /* Màu đỏ của Bootstrap cho lỗi */
            font-size: 0.875em;
            margin-top: 0.25rem;
            display: block; /* Đảm bảo nó chiếm một dòng */
        }
    </style>
</head>

<body class="bg-light">
<div id="layoutAuthentication">
    <div id="layoutAuthentication_content">
        <main>
            <div class="container py-5">
                <div class="row justify-content-center">
                    <div class="col-lg-5 col-md-7 col-sm-9">
                        <div class="card shadow-lg mt-5">
                            <div class="card-header bg-primary text-white">
                                <h3 class="text-center font-weight-light my-3">Laptopshop Login</h3>
                            </div>
                            <div class="card-body p-4">
                                <%-- Các thông báo chung --%>
                                <c:if test="${param.error != null}">
                                    <div class="alert alert-danger my-2" role="alert">
                                        Email hoặc mật khẩu không đúng.
                                    </div>
                                </c:if>
                                <c:if test="${param.logout != null}">
                                    <div class="alert alert-success my-2" role="alert">
                                        Đăng xuất thành công!
                                    </div>
                                </c:if>
                                <c:if test="${message != null}">
                                    <div class="alert alert-danger my-2" role="alert">
                                            ${message}
                                    </div>
                                </c:if>

                                <%-- Form sử dụng Spring Form Tags --%>
                                <form:form method="post" action="/login" modelAttribute="loginDTO">
                                    <div class="form-floating mb-3">
                                        <form:input path="email" cssClass="form-control" id="inputEmail" type="email" placeholder="name@example.com" />
                                        <label for="inputEmail">Địa chỉ Email</label>
                                        <form:errors path="email" cssClass="form-error" />
                                    </div>
                                    <div class="form-floating mb-3">
                                        <form:input path="password" cssClass="form-control" id="inputPassword" type="password" placeholder="Password" />
                                        <label for="inputPassword">Mật khẩu</label>
                                        <form:errors path="password" cssClass="form-error" />
                                    </div>

                                    <%--
                                        CSRF Token: Spring Form Tag <form:form> sẽ tự động chèn token CSRF
                                        nếu Spring Security được cấu hình để sử dụng CSRF (mặc định là bật).
                                        Vì vậy, dòng input hidden _csrf thường không cần thiết khi dùng <form:form>.
                                    --%>
                                    <%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> --%>

                                    <div class="mt-4 mb-0">
                                        <div class="d-grid">
                                            <button type="submit" class="btn btn-primary btn-lg">
                                                Đăng nhập
                                            </button>
                                        </div>
                                    </div>
                                </form:form>
                                    <!-- Thêm phần Quên mật khẩu -->
                                    <div class="text-center mt-3">
                                        <a href="/forgotPassword" class="text-secondary">Quên mật khẩu?</a>
                                    </div>
                                <div class="divider-text my-4">
                                    <span>HOẶC</span>
                                </div>

                                <div class="d-grid mb-3">
                                    <a href="/auth/google" class="btn btn-google btn-lg">
                                        <i class="fab fa-google me-2"></i> Đăng nhập bằng Google
                                    </a>
                                </div>

                            </div>
                            <div class="card-footer text-center py-3 bg-light">
                                <div class="small"><a href="/register" class="text-primary">Chưa có tài khoản? Đăng ký ngay!</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
<script src="/js/scripts.js"></script>
</body>
</html>