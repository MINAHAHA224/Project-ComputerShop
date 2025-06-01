
       <!-- JSP Path: src/main/webapp/WEB-INF/view/admin/user/create.jsp -->

 <%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <title>Tạo Người Dùng Mới - 3TLap Admin</title>
    <jsp:include page="../layout/common_admin_head.jsp"/>

    <style>
        .avatar-preview-container {
            display: flex;
            justify-content: center; 
            margin-bottom: 1rem;
        }
        .avatar-preview-create {
            width: 150px;
            height: 150px;
            object-fit: cover;
            border-radius: 50%;
            border: 3px solid var(--current-admin-border-color);
            background-color: var(--current-admin-card-bg); 
        }
    </style>
</head>

<body class="sb-nav-fixed admin-body-3tlap">
    <c:set var="breadcrumbCurrentPage" value="Tạo Mới Người Dùng" scope="request"/>
    <jsp:include page="../layout/header.jsp"/>

    <div id="layoutSidenav">
        <jsp:include page="../layout/navbar.jsp"/>
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <h1 class="main-content-title mt-4">Tạo Người Dùng Mới</h1>
                    
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <ol class="breadcrumb mb-0 bg-transparent p-0">
                            <li class="breadcrumb-item"><a href="<c:url value='/admin'/>">Dashboard</a></li>
                            <li class="breadcrumb-item"><a href="<c:url value='/admin/user'/>">Người Dùng</a></li>
                            <li class="breadcrumb-item active">Tạo Mới</li>
                        </ol>
                        <a href="<c:url value='/admin/user'/>" class="btn btn-outline-secondary btn-sm admin-btn-action">
                            <i class="fas fa-arrow-left me-1"></i> Quay Lại Danh Sách
                        </a>
                    </div>

                    <c:if test="${not empty messageSuccess}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            ${messageSuccess}<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>
                    <c:if test="${not empty messageError}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            ${messageError}<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <div class="card admin-form-card">
                        <div class="card-header">
                            <h4>Thông Tin Người Dùng</h4>
                        </div>
                        <div class="card-body">
                            <form:form method="post" action="/admin/user/create" modelAttribute="userCreateRqDTO" enctype="multipart/form-data">
                                <security:csrfInput />
                                <div class="row">
                                    <div class="col-md-8">
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label for="fullName" class="form-label">Họ và tên <span class="text-danger">*</span></label>
                                                <form:input path="fullName" cssClass="form-control" id="fullName"/>
                                                <form:errors path="fullName" cssClass="form-error"/>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label for="email" class="form-label">Email <span class="text-danger">*</span></label>
                                                <form:input type="email" path="email" cssClass="form-control" id="email"/>
                                                <form:errors path="email" cssClass="form-error"/>
                                            </div>
                                             <div class="col-md-6 mb-3">
                                                <label for="password" class="form-label">Mật khẩu <span class="text-danger">*</span></label>
                                                <form:password path="password" cssClass="form-control" id="password"/>
                                                <form:errors path="password" cssClass="form-error"/>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label for="phone" class="form-label">Số điện thoại <span class="text-danger">*</span></label>
                                                <form:input type="tel" path="phone" cssClass="form-control" id="phone"/>
                                                <form:errors path="phone" cssClass="form-error"/>
                                            </div>
                                            <div class="col-12 mb-3">
                                                <label for="address" class="form-label">Địa chỉ <span class="text-danger">*</span></label>
                                                <div class="address-autocomplete-wrapper position-relative">
                                                    <form:input path="address" cssClass="form-control goong-address-input" id="userCreateAddress" placeholder="Nhập địa chỉ..." autocomplete="off"/>
                                                    <div class="dropdown-menu goong-address-suggestions w-100" aria-labelledby="userCreateAddress"></div>
                                                </div>
                                                <form:errors path="address" cssClass="form-error"/>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label for="roleName" class="form-label">Vai trò <span class="text-danger">*</span></label>
                                                <form:select path="roleName" cssClass="form-select" id="roleName">
                                                    <form:option value="USER">USER</form:option>
                                                    <form:option value="ADMIN">ADMIN</form:option>
                                                </form:select>
                                                <form:errors path="roleName" cssClass="form-error"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="mb-3 text-center">
                                            <label class="form-label d-block">Ảnh đại diện</label>
                                            <div class="avatar-preview-container">
                                                <img src="<c:url value='/images/avatar/default-avatar.jpg'/>" 
                                                     alt="Xem trước ảnh đại diện"
                                                     id="avatarPreviewCreate" class="avatar-preview-create">
                                            </div>
                                            <label for="avatarFile" class="custom-file-upload-admin btn btn-sm btn-outline-secondary">
                                                <i class="fas fa-upload"></i> Tải ảnh lên
                                            </label>
                                            <input class="form-control d-none" type="file" name="avatarFile" id="avatarFile" accept="image/png, image/jpeg, image/gif" onchange="previewAvatarAdmin(event, 'avatarPreviewCreate')">
                                            <p class="text-muted small mt-1">PNG, JPG, GIF (Tối đa 2MB)</p>
                                        </div>
                                    </div>
                                </div>

                                <hr class="my-4">
                                <div class="text-end">
                                    <a href="<c:url value='/admin/user'/>" class="btn btn-outline-secondary me-2 rounded-pill px-4">Hủy Bỏ</a>
                                    <button type="submit" class="btn btn-primary rounded-pill px-4">Tạo Người Dùng</button>
                                </div>
                            </form:form>
                        </div>
                    </div>
                </div>
            </main>
            <jsp:include page="../../client/layout/chatbot_widget.jsp" />
            <jsp:include page="../layout/footer.jsp"/>
        </div>
    </div>

    <jsp:include page="../layout/common_admin_scripts.jsp"/>
    <script src="<c:url value='/client/js/goong-autocomplete.js'/>"></script> <%-- Dùng chung file JS autocomplete --%>
    <script>
        function previewAvatarAdmin(event, previewElementId) {
            const reader = new FileReader();
            reader.onload = function(){
                const output = document.getElementById(previewElementId);
                if (output) output.src = reader.result;
            };
            if (event.target.files && event.target.files[0]) {
                if(event.target.files[0].size > 2 * 1024 * 1024) { 
                    alert("Kích thước ảnh không được vượt quá 2MB.");
                    event.target.value = ""; 
                    return;
                }
                reader.readAsDataURL(event.target.files[0]);
            }
        }
    </script>
</body>
</html>