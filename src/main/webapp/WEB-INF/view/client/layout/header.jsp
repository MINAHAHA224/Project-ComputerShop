<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<!-- Navbar Start -->
<div class="container-fluid fixed-top px-0">
    <div class="container px-0">
        <nav class="navbar navbar-light navbar-expand-sm">
            <a href="<c:url value='/home' />" class="navbar-brand">
                <h1 class="text-primary display-6" style="font-family: 'Poppins', sans-serif; font-weight: 700;">3TLap</h1>
            </a>
            <button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarCollapseTop">
                <span class="fa fa-bars text-primary"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarCollapseTop">
                <div class="navbar-nav mx-auto">
                    <a href="<c:url value='/home' />" class="nav-item nav-link">Trang Chủ</a>
                    <a href="<c:url value='/products' />" class="nav-item nav-link">Sản Phẩm</a>
                    <%-- <a href="<c:url value='/promotions' />" class="nav-item nav-link">Khuyến Mãi</a> --%>
                    <%-- <a href="<c:url value='/blog' />" class="nav-item nav-link">Blog</a> --%>
                    <a href="<c:url value='/contact-us' />" class="nav-item nav-link">Liên Hệ</a>
                    <a href="<c:url value='/about-us' />" class="nav-item nav-link">Về Chúng Tôi</a>
                </div>
                <div class="d-flex align-items-center">
                
                    <form action="<c:url value='/search-results'/>" method="get" class="d-flex me-3 search-form-placeholder">
                        <input class="form-control form-control-sm rounded-pill" type="search" placeholder="Tìm kiếm laptop..." aria-label="Search" name="keyword">
                        <button class="btn btn-outline-primary btn-sm rounded-pill ms-1" type="submit"><i class="fas fa-search"></i></button>
                    </form>

                    <!-- Cart Icon -->
                    <c:choose>
                        <c:when test="${not empty sessionScope.informationDTO.id}">
                            <a href="<c:url value='/cart' />" class="position-relative me-3 my-auto header-action-icon">
                                <i class="fa fa-shopping-bag fa-lg"></i>
                                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                    <c:out value="${not empty sessionScope.informationDTO.sum ? sessionScope.informationDTO.sum : 0}" />
                                    <span class="visually-hidden">items in cart</span>
                                </span>
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="<c:url value='/login' />" class="position-relative me-3 my-auto header-action-icon">
                                <i class="fa fa-shopping-bag fa-lg"></i>
                                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                    0
                                    <span class="visually-hidden">items in cart</span>
                                </span>
                            </a>
                        </c:otherwise>
                    </c:choose>

                    <!-- User Account Dropdown / Login Link -->
                               <div class="user-actions-container">
                        <c:choose>
                            <c:when test="${not empty sessionScope.informationDTO.id}">
                                <div class="dropdown my-auto">
                                    <a href="#" class="d-flex align-items-center text-decoration-none dropdown-toggle header-action-icon" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                        <c:choose>
                                            <c:when test="${not empty sessionScope.informationDTO.avatar}">
                                                <img src="<c:url value='/images/profile/${sessionScope.informationDTO.avatar}'/>" alt="Avatar" width="30" height="30" class="rounded-circle me-2">
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fas fa-user-circle fa-lg me-2"></i>
                                            </c:otherwise>
                                        </c:choose>
                                        <span class="d-none d-sm-inline"><c:out value="${sessionScope.informationDTO.fullName}" /></span>
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="userDropdown">
                                        <li><h6 class="dropdown-header">Chào, <c:out value="${sessionScope.informationDTO.fullName}" /></h6></li>
                                        <c:if test="${ sessionScope.informationDTO.role eq 'ADMIN'}">
                                            <li><a class="dropdown-item" href="<c:url value='/admin'/>"><i class="fas fa-server me-2"></i>Quản lý hệ thống</a></li>
                                        </c:if>

                                        <li><a class="dropdown-item" href="<c:url value='/account-management'/>"><i class="fas fa-cog me-2"></i>Quản lý tài khoản</a></li>
                                        <li><a class="dropdown-item" href="<c:url value='/order-history'/>"><i class="fas fa-history me-2"></i>Lịch sử mua hàng</a></li>

                                        <li><hr class="dropdown-divider"></li>
                                        <li>
                                            <form method="post" action="<c:url value='/logout'/>" class="d-inline">
                                                <security:csrfInput />
                                                <button type="submit" class="dropdown-item"><i class="fas fa-sign-out-alt me-2"></i>Đăng xuất</button>
                                            </form>
                                        </li>
                                    </ul>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="login-register-buttons d-flex"> 
                                    <a href="<c:url value='/login'/>" class="btn btn-outline-primary btn-sm rounded-pill me-2">Đăng nhập</a>
                                    <a href="<c:url value='/register'/>" class="btn btn-primary btn-sm rounded-pill">Đăng ký</a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div> 
                </div>
            </div>
        </nav>
    </div>
</div>
<!-- Navbar End -->