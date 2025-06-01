
<!-- JSP Path: src/main/webapp/WEB-INF/view/admin/product/update.jsp -->

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <title>Cập Nhật Sản Phẩm - ${productUpdateRqDTO.name} - 3TLap Admin</title>
    <jsp:include page="../layout/common_admin_head.jsp"/>
    <style>
        .avatar-preview-container { display: flex; justify-content: center; margin-bottom: 1rem; }
        .avatar-preview-update {
            width: 200px; height: 200px; object-fit: contain;
            border: 2px dashed var(--current-admin-border-color);
            background-color: var(--current-admin-card-bg);
            padding: 5px; border-radius: 0.375rem;
        }
         body.theme-dark .avatar-preview-update {
            background-color: var(--current-admin-bg);
        }
    </style>
</head>

<body class="sb-nav-fixed admin-body-3tlap">
    <c:set var="breadcrumbCurrentPage" value="Cập Nhật Sản Phẩm" scope="request"/>
    <jsp:include page="../layout/header.jsp"/>

    <div id="layoutSidenav">
        <jsp:include page="../layout/navbar.jsp"/>
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <h1 class="main-content-title mt-4">Cập Nhật Sản Phẩm</h1>
                    <div class="d-flex justify-content-between align-items-center mb-3">
                         <ol class="breadcrumb mb-0 bg-transparent p-0">
                            <li class="breadcrumb-item"><a href="<c:url value='/admin'/>">Dashboard</a></li>
                            <li class="breadcrumb-item"><a href="<c:url value='/admin/product'/>">Sản Phẩm</a></li>
                            <li class="breadcrumb-item active">Cập Nhật: <c:out value="${productUpdateRqDTO.name}"/></li>
                        </ol>
                        <a href="<c:url value='/admin/product'/>" class="btn btn-outline-secondary btn-sm admin-btn-action">
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
                            <h4>Chỉnh Sửa Thông Tin Sản Phẩm (ID: ${productUpdateRqDTO.id})</h4>
                        </div>
                        <div class="card-body">
                            <form:form method="post" action="/admin/product/update" modelAttribute="productUpdateRqDTO" enctype="multipart/form-data">
                                <security:csrfInput />
                                <form:hidden path="id"/>
                                <form:hidden path="image"/> 

                                <div class="row">
                                    <div class="col-lg-8">
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label for="updateName" class="form-label">Tên sản phẩm <span class="text-danger">*</span></label>
                                                <form:input path="name" cssClass="form-control" id="updateName"/>
                                                <form:errors path="name" cssClass="form-error"/>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label for="updatePrice" class="form-label">Giá (VNĐ) <span class="text-danger">*</span></label>
                                                <form:input type="number" step="1000" min="0" path="price" cssClass="form-control" id="updatePrice"/>
                                                <form:errors path="price" cssClass="form-error"/>
                                            </div>
                                        </div>
                                        <div class="mb-3">
                                            <label for="updateShortDesc" class="form-label">Mô tả ngắn <span class="text-danger">*</span></label>
                                            <form:textarea path="shortDesc" cssClass="form-control" id="updateShortDesc" rows="3"/>
                                            <form:errors path="shortDesc" cssClass="form-error"/>
                                        </div>
                                        <div class="mb-3">
                                            <label for="updateDetailDesc" class="form-label">Mô tả chi tiết <span class="text-danger">*</span></label>
                                            <form:textarea path="detailDesc" cssClass="form-control" id="updateDetailDesc" rows="6"/>
                                            <form:errors path="detailDesc" cssClass="form-error"/>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-4 mb-3">
                                                <label for="updateQuantity" class="form-label">Số lượng tồn <span class="text-danger">*</span></label>
                                                <form:input type="number" min="0" path="quantity" cssClass="form-control" id="updateQuantity"/>
                                                <form:errors path="quantity" cssClass="form-error"/>
                                            </div>
                                             <div class="col-md-4 mb-3">
                                                <label for="updateSold" class="form-label">Đã bán <span class="text-danger">*</span></label>
                                                <form:input type="number" min="0" path="sold" cssClass="form-control" id="updateSold"/>
                                                <form:errors path="sold" cssClass="form-error"/>
                                            </div>
                                            <div class="col-md-4 mb-3">
                                                <label for="updateFactory" class="form-label">Hãng sản xuất <span class="text-danger">*</span></label>
                                                <form:select path="factory" cssClass="form-select" id="updateFactory">
                                                    <form:option value="APPLE">Apple (MacBook)</form:option>
                                                    <form:option value="ASUS">Asus</form:option>
                                                    <form:option value="LENOVO">Lenovo</form:option>
                                                    <form:option value="DELL">Dell</form:option>
                                                     <form:option value="HP">HP</form:option>
                                                    <form:option value="ACER">Acer</form:option>
                                                    <form:option value="MSI">MSI</form:option>
                                                    <form:option value="LG">LG</form:option>
                                                    <form:option value="MICROSOFT">Microsoft (Surface)</form:option>
                                                    <form:option value="KHAC">Khác</form:option>
                                                </form:select>
                                                <form:errors path="factory" cssClass="form-error"/>
                                            </div>
                                            <div class="col-md-12 mb-3"> <%-- Cho target full width nếu cần --%>
                                                <label for="updateTarget" class="form-label">Đối tượng sử dụng <span class="text-danger">*</span></label>
                                                <form:select path="target" cssClass="form-select" id="updateTarget">
                                                    <form:option value="GAMING">Gaming</form:option>
                                                    <form:option value="SINHVIEN-VANPHONG">Sinh viên - Văn phòng</form:option>
                                                    <form:option value="THIET-KE-DO-HOA">Thiết kế đồ họa</form:option>
                                                    <form:option value="MONG-NHE">Mỏng nhẹ - Di chuyển</form:option>
                                                    <form:option value="DOANH-NHAN">Doanh nhân - Cao cấp</form:option>
                                                </form:select>
                                                <form:errors path="target" cssClass="form-error"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-4">
                                        <div class="mb-3 text-center">
                                            <label class="form-label d-block">Ảnh sản phẩm hiện tại</label>
                                            <div class="avatar-preview-container">
                                                <img src="<c:url value='/images/product/${productUpdateRqDTO.image}'/>"
                                                     alt="Ảnh sản phẩm"
                                                     id="productImagePreviewUpdate" class="avatar-preview-update">
                                            </div>
                                            <label for="productImageFileUpdate" class="custom-file-upload-admin btn btn-sm btn-outline-secondary mt-2">
                                                <i class="fas fa-upload"></i> Thay đổi ảnh
                                            </label>
                                            <input class="form-control d-none" type="file" name="avatarFile" id="productImageFileUpdate" accept="image/png, image/jpeg, image/gif, image/webp" onchange="previewAvatarAdmin(event, 'productImagePreviewUpdate')">
                                            <p class="text-muted small mt-1">Để trống nếu không muốn thay đổi ảnh. (Tối đa 5MB)</p>
                                            <c:if test="${not empty fileError}">
                                                <div class="form-error d-block">${fileError}</div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>

                                <hr class="my-4">
                                <div class="text-end">
                                     <a href="<c:url value='/admin/product'/>" class="btn btn-outline-secondary me-2 rounded-pill px-4">Hủy Bỏ</a>
                                    <button type="submit" class="btn btn-primary rounded-pill px-4">Lưu Thay Đổi</button>
                                </div>
                            </form:form>
                        </div>
                    </div>
                </div>
            </main>
            <jsp:include page="../layout/footer.jsp"/>
        </div>
    </div>

    <jsp:include page="../layout/common_admin_scripts.jsp"/>
    <script>
        function previewAvatarAdmin(event, previewElementId) {
            const fileInput = event.target;
            const output = document.getElementById(previewElementId);
            
            if (fileInput.files && fileInput.files[0]) {
                const file = fileInput.files[0];
                if (file.size > 5 * 1024 * 1024) {
                    alert("Kích thước ảnh không được vượt quá 5MB. Vui lòng chọn ảnh nhỏ hơn.");
                    fileInput.value = "";
                    return;
                }
                const reader = new FileReader();
                reader.onload = function(e){
                    if (output) output.src = e.target.result;
                };
                reader.readAsDataURL(file);
            }
        }
    </script>
</body>
</html>