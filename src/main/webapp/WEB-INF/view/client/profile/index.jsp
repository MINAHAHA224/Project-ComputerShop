<%--src/main/webapp/WEB-INF/view/client/profile/index.jsp--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
<head>
    <meta charset="utf-8">
    <title><spring:message code="page.account.meta.title"/></title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <jsp:include page="../layout/common_head_links.jsp"/>
    <link href="<c:url value='/client/css/auth-pages.css'/>" rel="stylesheet"/>
    <%-- Styles giữ nguyên --%>
    <style>
        .profile-page-header {
            background: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url('<c:url value="/client/img/profile-banner.jpg"/>');
            background-position: center center;
            background-repeat: no-repeat;
            background-size: cover;
        }

        .profile-sidebar .card {
            border-radius: 0.5rem;
            box-shadow: 0 0.25rem 0.75rem rgba(0,0,0,.06);
            border: none;
        }
        .profile-sidebar .profile-avatar {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border: 3px solid var(--primary-color);
            margin-top: -60px;
            background-color: var(--white-color);
        }
        .profile-sidebar .card-title {
            font-family: var(--font-primary);
            font-weight: 600;
            color: var(--text-color);
            margin-top: 0.5rem;
        }
        .profile-sidebar .card-text.text-muted {
            font-size: 0.9rem;
        }
        .profile-sidebar .nav-pills .nav-link {
            color: var(--text-muted-color);
            font-weight: 500;
            border-radius: 0.375rem;
            padding: 0.75rem 1rem;
            transition: background-color 0.2s ease, color 0.2s ease;
            margin-bottom: 0.25rem;
        }
        .profile-sidebar .nav-pills .nav-link i {
            width: 20px;
            margin-right: 0.75rem;
            text-align: center;
        }
        .profile-sidebar .nav-pills .nav-link:hover {
            background-color: rgba(var(--primary-rgb), 0.08);
            color: var(--primary-color);
        }
        .profile-sidebar .nav-pills .nav-link.active,
        .profile-sidebar .nav-pills .show > .nav-link {
            color: var(--white-color);
            background-color: var(--primary-color);
        }
        .profile-sidebar .nav-pills .nav-link.active i {
            color: var(--white-color);
        }

        .profile-content .card {
            border-radius: 0.5rem;
            box-shadow: 0 0.25rem 0.75rem rgba(0,0,0,.06);
            border: none;
        }
        .profile-content .card-header {
            background-color: var(--light-bg-color);
            border-bottom: 1px solid var(--border-color);
            padding: 1rem 1.5rem;
        }
        .profile-content .card-header h4 {
            font-family: var(--font-primary);
            font-weight: 600;
            color: var(--primary-color);
            font-size: 1.25rem;
            margin-bottom: 0;
        }
        .profile-content .card-body {
            padding: 2rem 2.5rem;
        }
        .profile-content .form-label {
            font-weight: 500;
            color: var(--text-muted-color);
            margin-bottom: 0.3rem;
            font-size: 0.9rem;
        }
        .profile-content .form-control, .profile-content .form-select {
            border-radius: 0.375rem;
            border-color: var(--border-color);
            padding: 0.75rem 1rem;
            font-size: 0.95rem;
        }
        .profile-content .form-control:focus, .profile-content .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(var(--primary-rgb), 0.2);
        }
        .profile-content .form-control:disabled,
        .profile-content .form-control[readonly] {
            background-color: #e9ecef;
            opacity: 0.7;
        }
        .profile-content .btn-primary {
            font-weight: 500;
        }
        .avatar-upload-preview img {
            width: 150px;
            height: 150px;
            object-fit: cover;
            border: 3px solid #ddd;
        }
        .custom-file-upload {
            border: 1px solid var(--primary-color);
            display: inline-block;
            padding: 6px 12px;
            cursor: pointer;
            background-color: var(--primary-color);
            color: white;
            border-radius: 0.375rem;
            transition: background-color 0.2s ease;
        }
        .custom-file-upload:hover {
            background-color: darken(var(--primary-color), 10%);
        }
        #avatarFile {
            display: none;
        }
        .form-error {
            color: var(--danger-color);
            font-size: 0.875em;
            margin-top: 0.25rem;
            display: block;
        }
        .alert-profile {
            font-size: 0.9rem;
        }
    </style>
</head>

<body class="auth-page-bg">
<div id="spinner" class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center">
    <div class="spinner-grow text-primary" role="status"></div>
</div>

<jsp:include page="../layout/header.jsp"/>

<div class="container-fluid page-header profile-page-header py-5">
    <h1 class="text-center text-white display-5"><spring:message code="page.account.header.title"/></h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="<c:url value='/'/>"><spring:message code="page.account.breadcrumb.home"/></a></li>
        <li class="breadcrumb-item active text-white"><spring:message code="page.account.breadcrumb.accountManagement"/></li>
    </ol>
</div>

<div class="container-fluid py-5">
    <div class="container py-5">
        <div class="row g-4">
            <div class="col-lg-3 profile-sidebar">
                <div class="card sticky-top" style="top: 100px;">
                    <div class="card-body text-center position-relative pt-0">
                        <spring:message code="page.account.sidebar.alt.avatar" var="avatarAlt"/>
                        <img src="<c:url value='/images/profile/${not empty userProfileUpdateDTO.avatar ? userProfileUpdateDTO.avatar : "default-avatar.png"}'/>"
                             alt="${avatarAlt}"
                             class="rounded-circle img-fluid profile-avatar mb-2">
                        <h5 class="card-title mt-2 mb-1">${userProfileUpdateDTO.fullName}</h5> <%-- Tên người dùng giữ nguyên --%>
                        <p class="card-text text-muted small">${userProfileUpdateDTO.email}</p> <%-- Email giữ nguyên --%>
                    </div>
                    <div class="nav flex-column nav-pills p-3" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                        <a class="nav-link active" id="v-pills-info-tab" data-bs-toggle="pill" href="#v-pills-info" role="tab" aria-controls="v-pills-info" aria-selected="true">
                            <i class="fas fa-user-edit"></i><spring:message code="page.account.sidebar.tab.personalInfo"/>
                        </a>
                        <c:if test="${userProfileUpdateDTO.hasChangePass}">
                            <a class="nav-link" id="v-pills-password-tab" data-bs-toggle="pill" href="#v-pills-password" role="tab" aria-controls="v-pills-password" aria-selected="false">
                                <i class="fas fa-key"></i><spring:message code="page.account.sidebar.tab.changePassword"/>
                            </a>
                        </c:if>
                        <a class="nav-link" id="v-pills-avatar-tab" data-bs-toggle="pill" href="#v-pills-avatar" role="tab" aria-controls="v-pills-avatar" aria-selected="false">
                            <i class="fas fa-image"></i><spring:message code="page.account.sidebar.tab.changeAvatar"/>
                        </a>
                        <a class="nav-link" href="<c:url value='/order-history'/>">
                            <i class="fas fa-receipt"></i><spring:message code="page.account.sidebar.link.orderHistory"/>
                        </a>
                        <form:form method="post" action="/logout" cssClass="mt-2">
                            <security:csrfInput />
                            <button type="submit" class="nav-link text-danger w-100 text-start" style="background:none; border:none;">
                                <i class="fas fa-sign-out-alt"></i><spring:message code="page.account.sidebar.button.logout"/>
                            </button>
                        </form:form>
                    </div>
                </div>
            </div>

            <div class="col-lg-9 profile-content">
                <div class="tab-content" id="v-pills-tabContent">
                    <div class="tab-pane fade show active" id="v-pills-info" role="tabpanel" aria-labelledby="v-pills-info-tab">
                        <div class="card">
                            <div class="card-header">
                                <h4><spring:message code="page.account.info.title"/></h4>
                            </div>
                            <div class="card-body">
                                <%-- Các message success/error từ flash attributes giữ nguyên --%>
                                <c:if test="${not empty messageSuccess_info || (param.tab == 'info' && not empty requestScope['SPRING_REDIRECT_FLASH_ATTRIBUTES'].messageSuccess)}">
                                    <div class="alert alert-success alert-profile" role="alert">
                                            ${messageSuccess_info}
                                            ${requestScope['SPRING_REDIRECT_FLASH_ATTRIBUTES'].messageSuccess}
                                    </div>
                                </c:if>
                                <c:if test="${not empty messageError_info || (param.tab == 'info' && not empty requestScope['SPRING_REDIRECT_FLASH_ATTRIBUTES'].messageError)}">
                                    <div class="alert alert-danger alert-profile" role="alert">
                                            ${messageError_info}
                                            ${requestScope['SPRING_REDIRECT_FLASH_ATTRIBUTES'].messageError}
                                    </div>
                                </c:if>

                                <form:form method="POST" action="${pageContext.request.contextPath}/user/profile/update-info" modelAttribute="userProfileUpdateDTO">
                                    <div class="mb-3 row">
                                        <label for="emailInfo" class="col-sm-3 col-form-label"><spring:message code="page.account.info.label.email"/></label>
                                        <div class="col-sm-9">
                                            <spring:message code="page.account.info.placeholder.email" var="emailPlaceholder"/>
                                            <form:input type="email" cssClass="form-control" path="email" id="emailInfo" readonly="true" placeholder="${emailPlaceholder}" />
                                        </div>
                                    </div>
                                    <div class="mb-3 row">
                                        <label for="fullNameInfo" class="col-sm-3 col-form-label"><spring:message code="page.account.info.label.fullName"/> <span class="text-danger"><spring:message code="page.account.info.requiredMark"/></span></label>
                                        <div class="col-sm-9">
                                            <spring:message code="page.account.info.placeholder.fullName" var="fullNamePlaceholder"/>
                                            <form:input type="text" cssClass="form-control" path="fullName" id="fullNameInfo" placeholder="${fullNamePlaceholder}" />
                                            <form:errors path="fullName" cssClass="form-error" />
                                        </div>
                                    </div>
                                    <div class="mb-3 row">
                                        <label for="phoneInfo" class="col-sm-3 col-form-label"><spring:message code="page.account.info.label.phone"/> <span class="text-danger"><spring:message code="page.account.info.requiredMark"/></span></label>
                                        <div class="col-sm-9">
                                            <spring:message code="page.account.info.placeholder.phone" var="phonePlaceholder"/>
                                            <form:input type="tel" cssClass="form-control" path="phone" id="phoneInfo" placeholder="${phonePlaceholder}" />
                                            <form:errors path="phone" cssClass="form-error" />
                                        </div>
                                    </div>
                                    <div class="mb-3 row">
                                        <label for="addressInfo" class="col-sm-3 col-form-label"><spring:message code="page.account.info.label.address"/></label>
                                        <div class="col-sm-9">
                                            <div class="address-autocomplete-wrapper position-relative">
                                                <spring:message code="page.account.info.placeholder.address" var="addressPlaceholder"/>
                                                <form:input type="text" cssClass="form-control goong-address-input" path="address" id="addressInfo" placeholder="${addressPlaceholder}" autocomplete="off"/>
                                                <div class="dropdown-menu goong-address-suggestions w-100" aria-labelledby="addressInfo"></div>
                                            </div>
                                            <form:errors path="address" cssClass="form-error" />
                                        </div>
                                    </div>
                                    <div class="text-end mt-4">
                                        <button type="submit" class="btn btn-primary rounded-pill px-4 py-2"><spring:message code="page.account.info.button.saveChanges"/></button>
                                    </div>
                                </form:form>
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane fade" id="v-pills-password" role="tabpanel" aria-labelledby="v-pills-password-tab">
                        <div class="card">
                            <div class="card-header">
                                <h4><spring:message code="page.account.password.title"/></h4>
                            </div>
                            <div class="card-body">
                                <%-- Các message success/error từ flash attributes giữ nguyên --%>
                                <c:if test="${not empty messageSuccess_password || (param.tab == 'password' && not empty requestScope['SPRING_REDIRECT_FLASH_ATTRIBUTES'].messageSuccess)}">
                                    <div class="alert alert-success alert-profile" role="alert">
                                            ${messageSuccess_password}
                                            ${requestScope['SPRING_REDIRECT_FLASH_ATTRIBUTES'].messageSuccess}
                                    </div>
                                </c:if>
                                <c:if test="${not empty messageError_password || (param.tab == 'password' && not empty requestScope['SPRING_REDIRECT_FLASH_ATTRIBUTES'].messageError)}">
                                    <div class="alert alert-danger alert-profile" role="alert">
                                            ${messageError_password}
                                            ${requestScope['SPRING_REDIRECT_FLASH_ATTRIBUTES'].messageError}
                                    </div>
                                </c:if>

                                <c:if test="${userProfileUpdateDTO.hasChangePass}">
                                    <form:form method="POST" action="${pageContext.request.contextPath}/user/profile/change-password" modelAttribute="changePasswordDTO">
                                        <div class="mb-3 row">
                                            <label for="currentPassword" class="col-sm-4 col-form-label"><spring:message code="page.account.password.label.currentPassword"/> <span class="text-danger"><spring:message code="page.account.info.requiredMark"/></span></label>
                                            <div class="col-sm-8">
                                                <form:password cssClass="form-control" path="currentPassword" id="currentPassword" />
                                                <form:errors path="currentPassword" cssClass="form-error" />
                                            </div>
                                        </div>
                                        <div class="mb-3 row">
                                            <label for="newPassword" class="col-sm-4 col-form-label"><spring:message code="page.account.password.label.newPassword"/> <span class="text-danger"><spring:message code="page.account.info.requiredMark"/></span></label>
                                            <div class="col-sm-8">
                                                <form:password cssClass="form-control" path="newPassword" id="newPassword" />
                                                <form:errors path="newPassword" cssClass="form-error" />
                                            </div>
                                        </div>
                                        <div class="mb-3 row">
                                            <label for="confirmNewPassword" class="col-sm-4 col-form-label"><spring:message code="page.account.password.label.confirmNewPassword"/> <span class="text-danger"><spring:message code="page.account.info.requiredMark"/></span></label>
                                            <div class="col-sm-8">
                                                <form:password cssClass="form-control" path="confirmNewPassword" id="confirmNewPassword" />
                                                <form:errors path="confirmNewPassword" cssClass="form-error" />
                                            </div>
                                        </div>
                                        <form:errors path="*" cssClass="form-error alert alert-danger p-2 small" element="div"/>
                                        <div class="text-end mt-4">
                                            <button type="submit" class="btn btn-primary rounded-pill px-4 py-2"><spring:message code="page.account.password.button.changePassword"/></button>
                                        </div>
                                    </form:form>
                                </c:if>
                                <c:if test="${not userProfileUpdateDTO.hasChangePass}">
                                    <div class="alert alert-info">
                                        <spring:message code="page.account.password.info.googleLogin"/>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane fade" id="v-pills-avatar" role="tabpanel" aria-labelledby="v-pills-avatar-tab">
                        <div class="card">
                            <div class="card-header">
                                <h4><spring:message code="page.account.avatar.title"/></h4>
                            </div>
                            <div class="card-body text-center">
                                <%-- Các message success/error từ flash attributes giữ nguyên --%>
                                <c:if test="${not empty messageSuccess_avatar || (param.tab == 'avatar' && not empty requestScope['SPRING_REDIRECT_FLASH_ATTRIBUTES'].messageSuccess)}">
                                    <div class="alert alert-success alert-profile" role="alert">
                                            ${messageSuccess_avatar}
                                            ${requestScope['SPRING_REDIRECT_FLASH_ATTRIBUTES'].messageSuccess}
                                    </div>
                                </c:if>
                                <c:if test="${not empty messageError_avatar || (param.tab == 'avatar' && not empty requestScope['SPRING_REDIRECT_FLASH_ATTRIBUTES'].messageError)}">
                                    <div class="alert alert-danger alert-profile" role="alert">
                                            ${messageError_avatar}
                                            ${requestScope['SPRING_REDIRECT_FLASH_ATTRIBUTES'].messageError}
                                    </div>
                                </c:if>

                                <div class="avatar-upload-preview mb-3">
                                    <spring:message code="page.account.avatar.alt.currentAvatar" var="currentAvatarAlt"/>
                                    <img src="<c:url value='/images/profile/${not empty userProfileUpdateDTO.avatar ? userProfileUpdateDTO.avatar : "default-avatar.png"}'/>"
                                         alt="${currentAvatarAlt}"
                                         id="currentAvatarPreviewPage"
                                         class="rounded-circle img-fluid profile-avatar mb-3">
                                </div>

                                <form:form method="POST" action="${pageContext.request.contextPath}/user/profile/update-avatar" enctype="multipart/form-data">
                                    <security:csrfInput />
                                    <div class="mb-3">
                                        <label for="avatarFile" class="custom-file-upload">
                                            <i class="fas fa-cloud-upload-alt me-2"></i> <spring:message code="page.account.avatar.button.selectNewImage"/>
                                        </label>
                                        <input type="file" name="avatarFile" id="avatarFile" accept="image/png, image/jpeg, image/gif" onchange="previewAvatarOnPage(event)">
                                        <p class="text-muted small mt-2"><spring:message code="page.account.avatar.helpText"/></p>
                                        <c:if test="${not empty avatarUploadError}">
                                            <div class="form-error mt-1">${avatarUploadError}</div> <%-- Giữ nguyên nếu avatarUploadError là chuỗi đã dịch --%>
                                        </c:if>
                                    </div>
                                    <div class="mt-4">
                                        <button type="submit" class="btn btn-primary rounded-pill px-4 py-2"><spring:message code="page.account.avatar.button.updateImage"/></button>
                                    </div>
                                </form:form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="toast-container position-fixed top-0 end-0 p-3" style="z-index: 1100">
</div>

<c:if test="${not empty param.messageSuccess || not empty messageSuccess}">
    <div id="toast-message-success" class="d-none" data-message="${param.messageSuccess}${messageSuccess}"></div>
</c:if>
<c:if test="${not empty param.messageError || not empty messageError}">
    <div id="toast-message-error" class="d-none" data-message="${param.messageError}${messageError}"></div>
</c:if>
<c:if test="${not empty requestScope['SPRING_REDIRECT_FLASH_ATTRIBUTES'].messageSuccess}">
    <div id="flash-toast-message-success" class="d-none" data-message="${requestScope['SPRING_REDIRECT_FLASH_ATTRIBUTES'].messageSuccess}"></div>
</c:if>
<c:if test="${not empty requestScope['SPRING_REDIRECT_FLASH_ATTRIBUTES'].messageError}">
    <div id="flash-toast-message-error" class="d-none" data-message="${requestScope['SPRING_REDIRECT_FLASH_ATTRIBUTES'].messageError}"></div>
</c:if>

<jsp:include page="../layout/chatbot_widget.jsp" />

<jsp:include page="../layout/footer.jsp"/>
<jsp:include page="../layout/common_scripts.jsp"/>
<script src="<c:url value='/client/js/goong-autocomplete.js'/>"></script>
<script>
    // Dịch chuỗi alert trong JavaScript
    var sizeExceededAlert = "<spring:message code='page.account.avatar.alert.sizeExceeded' javaScriptEscape='true'/>";

    function previewAvatarOnPage(event) {
        var reader = new FileReader();
        reader.onload = function(){
            var output = document.getElementById('currentAvatarPreviewPage');
            var sidebarAvatar = document.querySelector('.profile-sidebar .profile-avatar');
            if (output) output.src = reader.result;
            if (sidebarAvatar) sidebarAvatar.src = reader.result;
        };
        if (event.target.files && event.target.files[0]) {
            if(event.target.files[0].size > 2 * 1024 * 1024) {
                alert(sizeExceededAlert); // Sử dụng biến đã dịch
                event.target.value = "";
                return;
            }
            reader.readAsDataURL(event.target.files[0]);
        }
    }

    // JavaScript còn lại giữ nguyên

    $(document).ready(function() {
        var urlParams = new URLSearchParams(window.location.search);
        var activeTab = urlParams.get('tab');
        var hash = window.location.hash;

        if (activeTab) {
            $('#v-pills-' + activeTab + '-tab').tab('show');
        } else if (hash) {
            $('a[href="' + hash + '"]').tab('show');
        }

        $('#v-pills-tab a').on('shown.bs.tab', function (e) {
            if (history.pushState) {
                history.pushState(null, null, e.target.hash);
            } else {
                window.location.hash = e.target.hash;
            }
            $('.tab-pane.fade:not(.show) .alert').remove();
        });

        const successFlash = "${requestScope['SPRING_REDIRECT_FLASH_ATTRIBUTES'].messageSuccess}";
        const errorFlash = "${requestScope['SPRING_REDIRECT_FLASH_ATTRIBUTES'].messageError}";
        const currentTab = window.location.hash || '#v-pills-info';

        if (successFlash && $(currentTab + ' .alert-success').length === 0) {
            $(currentTab + ' .card-body').prepend('<div class="alert alert-success alert-profile" role="alert">' + successFlash + '</div>');
        }
        if (errorFlash && $(currentTab + ' .alert-danger').length === 0) {
            $(currentTab + ' .card-body').prepend('<div class="alert alert-danger alert-profile" role="alert">' + errorFlash + '</div>');
        }
    });
</script>
</body>
</html>