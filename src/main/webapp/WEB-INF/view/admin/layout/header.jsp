
<!-- JSP Path: admin/layout/header.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<nav class="sb-topnav navbar navbar-expand navbar-dark admin-top-nav" id="adminTopNav">
    <a class="navbar-brand ps-3" href="<c:url value='/admin'/>">
        <span class="admin-brand-text">3TLap Admin</span>
    </a>
    <button class="btn btn-link btn-sm order-1 order-lg-0 me-3" id="sidebarToggleAdmin" href="#!"><i class="fas fa-bars"></i></button>
    <div class="d-none d-md-inline-block ms-2 me-auto admin-breadcrumb">
        <ol class="breadcrumb breadcrumb-dark mb-0 py-2">
            <li class="breadcrumb-item"><a href="<c:url value='/admin'/>">Dashboard</a></li>
            <li class="breadcrumb-item active" aria-current="page" id="currentBreadcrumbPage">
                <c:choose>
                    <c:when test="${not empty breadcrumbCurrentPage}">${breadcrumbCurrentPage}</c:when>
                    <c:otherwise>Tổng Quan</c:otherwise>
                </c:choose>
            </li>
        </ol>
    </div>
    <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4 align-items-center">
        <li class="nav-item d-flex align-items-center me-3">
             <span class="navbar-text text-white-75 small">
                Chào, <c:out value="${sessionScope.informationDTO.fullName != null ? sessionScope.informationDTO.fullName : pageContext.request.userPrincipal.name}" />
            </span>
        </li>
        <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle admin-user-avatar" id="navbarDropdownUserAdmin" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                <c:choose>
                    <c:when test="${not empty sessionScope.informationDTO.avatar}">
                         <img src="<c:url value='/images/profile/${sessionScope.informationDTO.avatar}'/>" alt="Avatar">
                    </c:when>
                    <c:otherwise>
                        <i class="fas fa-user-circle"></i>
                    </c:otherwise>
                </c:choose>
            </a>
            <ul class="dropdown-menu dropdown-menu-dark dropdown-menu-end" aria-labelledby="navbarDropdownUserAdmin">
                <li><a class="dropdown-item" href="<c:url value='/account-management'/>"><i class="fas fa-user-cog fa-fw me-2"></i>Tài khoản</a></li>
                <li><hr class="dropdown-divider" /></li>
                <li>
                    <form method="post" action="<c:url value='/logout'/>" class="d-inline w-100">
                        <security:csrfInput />
                        <button type="submit" class="dropdown-item"><i class="fas fa-sign-out-alt fa-fw me-2"></i>Đăng xuất</button>
                    </form>
                </li>
            </ul>
        </li>
    </ul>
</nav>
