<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="Đăng ký tài khoản Laptopshop" />
    <meta name="author" content="" />
    <title>Đăng Ký - Laptopshop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <style>
        body {
            background-color: #f0f2f5;
        }
        .card {
            border: none;
            border-radius: 0.75rem;
        }
        .card-header {
            border-top-left-radius: 0.75rem;
            border-top-right-radius: 0.75rem;
            background-color: #0d6efd;
            color: white;
        }
        .card-footer {
            border-bottom-left-radius: 0.75rem;
            border-bottom-right-radius: 0.75rem;
            background-color: #f8f9fa;
        }
        .form-error {
            color: #dc3545;
            font-size: 0.875em;
            margin-top: 0.25rem;
            display: block;
        }
        .btn-google { /* Style cho nút Google */
            background-color: #DB4437;
            color: white;
            transition: background-color 0.3s;
        }
        .btn-google:hover {
            background-color: #c1392b;
            color: white;
        }
        .divider-text { /* Style cho đường kẻ "HOẶC" */
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
            color: #6c757d;
        }
        .divider-text:before {
            content: "";
            position: absolute;
            width: 100%;
            height: 1px;
            background-color: #dee2e6;
            left: 0;
            top: 50%;
            z-index: 0;
        }
    </style>
</head>

<body class="bg-light">
<div id="layoutAuthentication">
    <div id="layoutAuthentication_content">
        <main>
            <div class="container py-5">
                <div class="row justify-content-center">
                    <div class="col-lg-7 col-md-9">
                        <div class="card shadow-lg mt-5">
                            <div class="card-header">
                                <h3 class="text-center font-weight-light my-3">Tạo Tài Khoản Mới</h3>
                            </div>
                            <div class="card-body p-4">
                                <c:if test="${message != null}">
                                    <div class="alert alert-danger my-3" role="alert">
                                            ${message}
                                    </div>
                                </c:if>
                                <c:if test="${param.oauth2_error != null}">
                                    <div class="alert alert-danger my-3" role="alert">
                                        Đăng nhập/Đăng ký bằng Google thất bại. Vui lòng thử lại.
                                    </div>
                                </c:if>


                                <form:form method="post" action="/register" modelAttribute="registerDTO">
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <div class="form-floating mb-3 mb-md-0">
                                                <form:input path="firstName" cssClass="form-control" id="inputFirstName" type="text" placeholder="Họ" />
                                                <label for="inputFirstName">Họ</label>
                                                <form:errors path="firstName" cssClass="form-error" />
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-floating">
                                                <form:input path="lastName" cssClass="form-control" id="inputLastName" type="text" placeholder="Tên" />
                                                <label for="inputLastName">Tên</label>
                                                <form:errors path="lastName" cssClass="form-error" />
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-floating mb-3">
                                        <form:input path="email" cssClass="form-control" id="inputEmail" type="email" placeholder="name@example.com" />
                                        <label for="inputEmail">Địa chỉ Email</label>
                                        <form:errors path="email" cssClass="form-error" />
                                    </div>

                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <div class="form-floating mb-3 mb-md-0">
                                                <form:input path="password" cssClass="form-control" id="inputPassword" type="password" placeholder="Tạo mật khẩu" />
                                                <label for="inputPassword">Mật khẩu</label>
                                                <form:errors path="password" cssClass="form-error" />
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-floating">
                                                <form:input path="confirmPassword" cssClass="form-control" id="inputPasswordConfirm" type="password" placeholder="Xác nhận mật khẩu" />
                                                <label for="inputPasswordConfirm">Xác nhận Mật khẩu</label>
                                                <form:errors path="confirmPassword" cssClass="form-error" />
                                            </div>
                                        </div>
                                    </div>


                                    <div class="mt-4 mb-0">
                                        <div class="d-grid">
                                            <button type="submit" class="btn btn-primary btn-lg">
                                                Tạo Tài Khoản
                                            </button>
                                        </div>
                                    </div>
                                </form:form>

                                <%-- Đường kẻ phân cách VÀ NÚT GOOGLE --%>
                                <div class="divider-text my-4">
                                    <span>HOẶC TIẾP TỤC VỚI</span>
                                </div>

                                <div class="d-grid mb-3">
                                    <a href="/oauth2/authorization/google" class="btn btn-google btn-lg">
                                        <i class="fab fa-google me-2"></i> Google
                                    </a>
                                </div>
                                <%-- Kết thúc phần nút Google --%>

                            </div>
                            <div class="card-footer text-center py-3">
                                <div class="small">
                                    <a href="/login" class="text-primary">Đã có tài khoản? Đăng nhập</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>