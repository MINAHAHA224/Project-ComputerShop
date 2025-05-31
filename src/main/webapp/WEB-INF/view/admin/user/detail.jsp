<%--src/main/webapp/WEB-INF/view/admin/user/detail.jsp--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="utf-8"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
  <title>Chi Tiết Người Dùng - ${infoUser.fullName} - 3TLap Admin</title>
  <jsp:include page="../layout/common_admin_head.jsp"/>
  <style>
    .user-detail-avatar {
      width: 150px;
      height: 150px;
      object-fit: cover;
      border-radius: 50%;
      border: 3px solid var(--current-admin-border-color);
      background-color: var(--current-admin-card-bg);
      padding: 3px;
    }
    .detail-section .list-group-item {
      background-color: transparent;
      border-color: var(--current-admin-divider-color);
      color: var(--current-admin-text-primary);
    }
    .detail-section .list-group-item strong {
      color: var(--current-admin-text-secondary);
      min-width: 120px;
      display: inline-block;
    }
    .card-profile-header {
      text-align: center;
      padding-bottom: 1.5rem;
      border-bottom: 1px solid var(--current-admin-divider-color);
      margin-bottom: 1.5rem;
    }
    .card-profile-header h4 {
      font-family: var(--admin-font-primary);
      font-weight: 600;
      color: var(--admin-primary-accent);
      margin-top: 1rem;
      margin-bottom: 0.25rem;
    }
    .card-profile-header p.text-muted {
      font-size: 0.9rem;
      margin-bottom: 0;
    }
  </style>
</head>

<body class="sb-nav-fixed admin-body-3tlap">
  <c:set var="breadcrumbCurrentPage" value="Chi Tiết Người Dùng" scope="request"/>
  <jsp:include page="../layout/header.jsp"/>

  <div id="layoutSidenav">
    <jsp:include page="../layout/navbar.jsp"/>
    <div id="layoutSidenav_content">
      <main>
        <div class="container-fluid px-4">
          <h1 class="main-content-title mt-4">Chi Tiết Người Dùng</h1>
          
          <div class="d-flex justify-content-between align-items-center mb-3">
             <ol class="breadcrumb mb-0 bg-transparent p-0">
              <li class="breadcrumb-item"><a href="<c:url value='/admin'/>">Dashboard</a></li>
              <li class="breadcrumb-item"><a href="<c:url value='/admin/user'/>">Người Dùng</a></li>
              <li class="breadcrumb-item active">Chi Tiết: <c:out value="${infoUser.fullName}"/></li>
            </ol>
            <div>
              <a href="<c:url value='/admin/user/update/${infoUser.id}'/>" class="btn btn-warning btn-sm admin-btn-action">
                <i class="fas fa-edit me-1"></i> Sửa
              </a>
              <a href="<c:url value='/admin/user'/>" class="btn btn-outline-secondary btn-sm admin-btn-action ms-2">
                <i class="fas fa-arrow-left me-1"></i> Quay Lại Danh Sách
              </a>
            </div>
          </div>

          <div class="card admin-detail-card mb-4">
            <div class="card-body">
              <div class="card-profile-header">
                <img src="<c:url value='/images/profile/${not empty infoUser.avatar ? infoUser.avatar : "default-avatar.png"}'/>"
                   alt="Ảnh đại diện của ${infoUser.fullName}"
                   class="user-detail-avatar">
                <h4><c:out value="${infoUser.fullName}"/></h4>
                <p class="text-muted"><c:out value="${infoUser.email}"/></p>
                <span class="badge 
                  <c:choose>
                    <c:when test='${infoUser.roleName == "ADMIN"}'>bg-danger</c:when>
                    <c:when test='${infoUser.roleName == "USER"}'>bg-success</c:when>
                    <c:otherwise>bg-secondary</c:otherwise>
                  </c:choose>
                ">${infoUser.roleName}</span>
              </div>
              
              <div class="detail-section">
                <h5 class="mb-3 section-subtitle-admin">Thông Tin Liên Hệ</h5>
                <ul class="list-group list-group-flush">
                  <li class="list-group-item">
                    <strong>ID Người Dùng:</strong> ${infoUser.id}
                  </li>
                  <li class="list-group-item">
                    <strong>Số điện thoại:</strong> 
                    <c:out value="${not empty infoUser.phone ? infoUser.phone : 'Chưa cập nhật'}"/>
                  </li>
                  <li class="list-group-item">
                    <strong>Địa chỉ:</strong> 
                    <c:out value="${not empty infoUser.address ? infoUser.address : 'Chưa cập nhật'}"/>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </main>
      <jsp:include page="../layout/footer.jsp"/>
    </div>
  </div>

  <jsp:include page="../layout/common_admin_scripts.jsp"/>
</body>
</html>
