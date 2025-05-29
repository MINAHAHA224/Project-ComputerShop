<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8">
    <title>Thông Tin Cá Nhân - Laptopshop</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
            href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
            rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
          rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="${pageContext.request.contextPath}/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


    <!-- Customized Bootstrap Stylesheet -->
    <link href="${pageContext.request.contextPath}/client/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="${pageContext.request.contextPath}/client/css/style.css" rel="stylesheet">
    <style>
        .profile-avatar {
            width: 150px;
            height: 150px;
            object-fit: cover;
            border: 3px solid #ddd;
        }
        .nav-pills .nav-link.active, .nav-pills .show>.nav-link {
            color: #fff;
            background-color: var(--bs-primary); /* Sử dụng màu primary của template */
        }
        .form-control:disabled, .form-control[readonly] {
            background-color: #e9ecef;
            opacity: 1;
        }
    </style>
</head>

<body>

<!-- Spinner Start -->
<div id="spinner"
     class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
    <div class="spinner-grow text-primary" role="status"></div>
</div>
<!-- Spinner End -->

<%-- Include Header --%>
<jsp:include page="../layout/header.jsp" />

<!-- Single Page Header start -->
<div class="container-fluid page-header py-5">
    <h1 class="text-center text-white display-6">Thông Tin Cá Nhân</h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
        <li class="breadcrumb-item active text-white">Thông tin cá nhân</li>
    </ol>
</div>
<!-- Single Page Header End -->


<!-- User Profile Content Start -->
<div class="container-fluid py-5">
    <div class="container py-5">
        <div class="row">
            <div class="col-md-3">
                <!-- Profile Sidebar -->
                <div class="card">
                    <div class="card-body text-center">
                        <img src="${pageContext.request.contextPath}/images/profile/${not empty userProfileUpdateDTO.avatar ? userProfileUpdateDTO.avatar : 'default-avatar.png'}"
                             alt="Ảnh đại diện"
                             class="rounded-circle img-fluid profile-avatar mb-3">
                        <h5 class="card-title">${userProfileUpdateDTO.fullName}</h5>
                        <p class="card-text text-muted">${userProfileUpdateDTO.email}</p>
                    </div>
                    <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                        <a class="nav-link active" id="v-pills-info-tab" data-bs-toggle="pill" href="#v-pills-info" role="tab" aria-controls="v-pills-info" aria-selected="true">
                            <i class="fas fa-user me-2"></i>Thông tin tài khoản
                        </a>
                        <a class="nav-link" id="v-pills-password-tab" data-bs-toggle="pill" href="#v-pills-password" role="tab" aria-controls="v-pills-password" aria-selected="false">
                            <i class="fas fa-key me-2"></i>Đổi mật khẩu
                        </a>
                        <a class="nav-link" id="v-pills-avatar-tab" data-bs-toggle="pill" href="#v-pills-avatar" role="tab" aria-controls="v-pills-avatar" aria-selected="false">
                            <i class="fas fa-image me-2"></i>Đổi ảnh đại diện
                        </a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/order-history"> <%-- Link tới trang lịch sử đơn hàng --%>
                            <i class="fas fa-history me-2"></i>Lịch sử đơn hàng
                        </a>
                    </div>
                </div>
            </div>

            <div class="col-md-9">
                <!-- Profile Content -->
                <div class="tab-content" id="v-pills-tabContent">
                    <!-- Thông tin tài khoản Tab -->
                    <div class="tab-pane fade show active" id="v-pills-info" role="tabpanel" aria-labelledby="v-pills-info-tab">
                        <div class="card">
                            <div class="card-header">
                                <h4>Cập nhật thông tin cá nhân</h4>
                            </div>
                            <div class="card-body">
                                <%-- Thông báo thành công/lỗi (nếu có từ controller) --%>
                                <c:if test="${not empty messageSuccess}">
                                    <div class="alert alert-success" role="alert">${messageSuccess}</div>
                                </c:if>
                                <c:if test="${not empty messageError}">
                                    <div class="alert alert-danger" role="alert">${messageError}</div>
                                </c:if>

                                <%-- Form cập nhật thông tin --%>
                                <%-- Giả sử modelAttribute là "userProfileUpdateDTO" --%>
                                <form:form method="POST" action="${pageContext.request.contextPath}/user/profile/update-info" modelAttribute="userProfileUpdateDTO">
                                    <div class="mb-3 row">
                                        <label for="email" class="col-sm-3 col-form-label">Email</label>
                                        <div class="col-sm-9">
                                                <%-- Email thường không cho sửa trực tiếp --%>
                                            <form:input type="email" class="form-control" path="email" id="email" readonly="true" />
                                        </div>
                                    </div>
                                    <div class="mb-3 row">
                                        <label for="fullName" class="col-sm-3 col-form-label">Họ và tên</label>
                                        <div class="col-sm-9">
                                            <form:input type="text" class="form-control" path="fullName" id="fullName" />
                                            <form:errors path="fullName" cssClass="text-danger" />
                                        </div>
                                    </div>
                                    <div class="mb-3 row">
                                        <label for="phone" class="col-sm-3 col-form-label">Số điện thoại</label>
                                        <div class="col-sm-9">
                                            <form:input type="tel" class="form-control" path="phone" id="phone" />
                                            <form:errors path="phone" cssClass="text-danger" />
                                        </div>
                                    </div>
                                    <div class="mb-3 row">
                                        <label for="address" class="col-sm-3 col-form-label">Địa chỉ</label>
                                        <div class="col-sm-9">
                                            <form:textarea class="form-control" path="address" id="address" rows="3" />
                                            <form:errors path="address" cssClass="text-danger" />
                                        </div>
                                    </div>
                                    <div class="text-end">
                                        <button type="submit" class="btn btn-primary rounded-pill px-4">Lưu thay đổi</button>
                                    </div>
                                </form:form>
                            </div>
                        </div>
                    </div>

                    <!-- Đổi mật khẩu Tab -->

                    <div class="tab-pane fade" id="v-pills-password" role="tabpanel" aria-labelledby="v-pills-password-tab">
                        <div class="card">
                            <div class="card-header">
                                <h4>Đổi mật khẩu</h4>
                            </div>
                            <div class="card-body">
                                <%-- Thông báo thành công/lỗi (nếu có từ controller) --%>
                                <c:if test="${not empty successMessage_password}">
                                    <div class="alert alert-success" role="alert">${successMessage_password}</div>
                                </c:if>
                                <c:if test="${not empty errorMessage_password}">
                                    <div class="alert alert-danger" role="alert">${errorMessage_password}</div>
                                </c:if>

                                <%-- Form đổi mật khẩu --%>
                                <%-- Giả sử modelAttribute là "changePasswordDTO" --%>
                                    <c:if test="${userProfileUpdateDTO.hasChangePass}">
                                    <form:form method="POST" action="${pageContext.request.contextPath}/user/profile/change-password" modelAttribute="changePasswordDTO">
                                    <div class="mb-3 row">
                                        <label for="currentPassword" class="col-sm-4 col-form-label">Mật khẩu hiện tại</label>
                                        <div class="col-sm-8">
                                            <form:password class="form-control" path="currentPassword" id="currentPassword" />
                                            <form:errors path="currentPassword" cssClass="text-danger" />
                                        </div>
                                    </div>
                                    <div class="mb-3 row">
                                        <label for="newPassword" class="col-sm-4 col-form-label">Mật khẩu mới</label>
                                        <div class="col-sm-8">
                                            <form:password class="form-control" path="newPassword" id="newPassword" />
                                            <form:errors path="newPassword" cssClass="text-danger" />
                                        </div>
                                    </div>
                                    <div class="mb-3 row">
                                        <label for="confirmNewPassword" class="col-sm-4 col-form-label">Xác nhận mật khẩu mới</label>
                                        <div class="col-sm-8">
                                            <form:password class="form-control" path="confirmNewPassword" id="confirmNewPassword" />
                                            <form:errors path="confirmNewPassword" cssClass="text-danger" />
                                        </div>
                                    </div>
                                    <div class="text-end">
                                        <button type="submit" class="btn btn-primary rounded-pill px-4">Đổi mật khẩu</button>
                                    </div>
                                </form:form>
                                    </c:if>
                            </div>
                            <c:if test="${not userProfileUpdateDTO.hasChangePass}">
                                <div >
                                    Tài khoản không thể đổi mật khẩu.
                                </div>
                            </c:if>
                        </div>
                    </div>


                    <!-- Đổi ảnh đại diện Tab -->
                    <div class="tab-pane fade" id="v-pills-avatar" role="tabpanel" aria-labelledby="v-pills-avatar-tab">
                        <div class="card">
                            <div class="card-header">
                                <h4>Thay đổi ảnh đại diện</h4>
                            </div>
                            <div class="card-body text-center">
                                <%-- Thông báo thành công/lỗi (nếu có từ controller) --%>
                                <c:if test="${not empty successMessage_avatar}">
                                    <div class="alert alert-success" role="alert">${successMessage_avatar}</div>
                                </c:if>
                                <c:if test="${not empty errorMessage_avatar}">
                                    <div class="alert alert-danger" role="alert">${errorMessage_avatar}</div>
                                </c:if>

                                <img src="${pageContext.request.contextPath}/images/profile/${not empty userProfileUpdateDTO.avatar ? userProfileUpdateDTO.avatar : 'default-avatar.png'}"
                                     alt="Ảnh đại diện hiện tại"
                                     id="currentAvatarPreview"
                                     class="rounded-circle img-fluid profile-avatar mb-3">

                                <%-- Form upload ảnh đại diện --%>
                                <form method="POST" action="${pageContext.request.contextPath}/user/profile/update-avatar" enctype="multipart/form-data">
                                    <div class="mb-3">
                                        <label for="avatarFile" class="form-label">Chọn ảnh mới (dưới 2MB)</label>
                                        <input class="form-control" type="file" name="avatarFile" id="avatarFile" accept="image/png, image/jpeg, image/gif" onchange="previewAvatar(event)">
                                        <%-- Hiển thị lỗi từ phía server nếu có --%>
                                        <c:if test="${not empty avatarUploadError}">
                                            <div class="text-danger mt-1">${avatarUploadError}</div>
                                        </c:if>
                                    </div>
                                    <div class="text-end">
                                        <button type="submit" class="btn btn-primary rounded-pill px-4">Cập nhật ảnh</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
<!-- User Profile Content End -->


<%-- Include Footer --%>
<jsp:include page="../layout/footer.jsp" />

<!-- Back to Top -->
<a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
        class="fa fa-arrow-up"></i></a>


<!-- JavaScript Libraries -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/client/lib/easing/easing.min.js"></script>
<script src="${pageContext.request.contextPath}/client/lib/waypoints/waypoints.min.js"></script>
<script src="${pageContext.request.contextPath}/client/lib/lightbox/js/lightbox.min.js"></script>
<script src="${pageContext.request.contextPath}/client/lib/owlcarousel/owl.carousel.min.js"></script>

<!-- Template Javascript -->
<script src="${pageContext.request.contextPath}/client/js/main.js"></script>
<script>
    // JavaScript để preview ảnh đại diện khi người dùng chọn file
    function previewAvatar(event) {
        var reader = new FileReader();
        reader.onload = function(){
            var output = document.getElementById('currentAvatarPreview');
            var sidebarAvatar = document.querySelector('.profile-sidebar .profile-avatar'); // Nếu bạn có avatar ở sidebar
            output.src = reader.result;
            if(sidebarAvatar) {
                sidebarAvatar.src = reader.result;
            }
        };
        if (event.target.files[0]) {
            reader.readAsDataURL(event.target.files[0]);
        } else {
            // Nếu người dùng hủy chọn file, có thể hiển thị lại ảnh cũ hoặc mặc định
            // Ví dụ: output.src = "${pageContext.request.contextPath}/images/avatar/${not empty userProfile.avatar ? userProfile.avatar : 'default-avatar.png'}";
        }
    }

    // Xử lý active tab khi có lỗi validation hoặc sau khi submit form
    $(document).ready(function() {
        // Kiểm tra xem có thông báo lỗi/thành công cho tab nào không để active tab đó
        if ($('#v-pills-info .alert').length > 0 || $('#v-pills-info .text-danger').length > 0) {
            $('#v-pills-info-tab').tab('show');
        } else if ($('#v-pills-password .alert').length > 0 || $('#v-pills-password .text-danger').length > 0) {
            $('#v-pills-password-tab').tab('show');
        } else if ($('#v-pills-avatar .alert').length > 0 || $('#v-pills-avatar .text-danger').length > 0) {
            $('#v-pills-avatar-tab').tab('show');
        }

        // Giữ tab active sau khi reload trang (ví dụ sau khi submit form)
        var hash = window.location.hash;
        if (hash) {
            $('a[href="' + hash + '"]').tab('show');
        }

        // Lưu hash vào URL khi click tab
        $('.nav-pills a').on('shown.bs.tab', function (e) {
            window.location.hash = e.target.hash;
            // Xóa thông báo lỗi/thành công của các tab khác khi chuyển tab
            $('.tab-pane.fade:not(.show) .alert').remove();
        });
    });
</script>
</body>
</html>