
<!-- JSP Path: admin/layout/header.jsp -->
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark-admin">
  <a class="navbar-brand ps-3" href="<c:url value='/admin'/>">3TLap Admin</a>
  <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
  <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
  </form>
  <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
    <li class="nav-item me-3 d-flex align-items-center">
       <span class="navbar-text text-white-50">
        Chào, <c:out value="${sessionScope.informationDTO.fullName != null ? sessionScope.informationDTO.fullName : pageContext.request.userPrincipal.name}" />
      </span>
    </li>
    <li class="nav-item dropdown">
      <a class="nav-link dropdown-toggle" id="navbarDropdownUser" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
        <c:choose>
          <c:when test="${not empty sessionScope.informationDTO.avatar}">
             <img src="<c:url value='/images/avatar/${sessionScope.informationDTO.avatar}'/>" alt="Avatar" width="30" height="30" class="rounded-circle border border-light">
          </c:when>
          <c:otherwise>
            <i class="fas fa-user fa-fw"></i>
          </c:otherwise>
        </c:choose>
      </a>
      <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownUser">
        <li><a class="dropdown-item" href="<c:url value='/account-management'/>"><i class="fas fa-user-cog me-2"></i>Tài khoản của tôi</a></li>
        <li><a class="dropdown-item" href="#!"><i class="fas fa-sliders-h me-2"></i>Cài đặt (nếu có)</a></li>
        <li><hr class="dropdown-divider" /></li>
        <li>
          <form method="post" action="<c:url value='/logout'/>" class="d-inline w-100">
            <security:csrfInput />
            <button type="submit" class="dropdown-item"><i class="fas fa-sign-out-alt me-2"></i>Đăng xuất</button>
          </form>
        </li>
      </ul>
    </li>
  </ul>
</nav>
