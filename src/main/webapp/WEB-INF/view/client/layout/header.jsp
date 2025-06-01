<%--src/main/webapp/WEB-INF/view/client/layout/header.jsp--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    .language-switcher img {
        width: 24px;
        height: 16px;
        object-fit: cover;
        margin-left: 5px;
        margin-right: 5px;
    }
</style>
<!-- Navbar Start -->
<div class="container-fluid fixed-top px-0">
    <div class="container px-0">
        <nav class="navbar navbar-light navbar-expand-sm">
            <a href="<c:url value='/home' />" class="navbar-brand">
                <h1 class="text-primary display-6" style="font-family: 'Poppins', sans-serif; font-weight: 700;"><spring:message code="layout.header.brandName"/></h1>
            </a>
            <button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarCollapseTop">
                <span class="fa fa-bars text-primary"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarCollapseTop">
                <div class="navbar-nav mx-auto">
                    <a href="<c:url value='/home' />" class="nav-item nav-link"><spring:message code="layout.header.nav.home"/></a>
                    <a href="<c:url value='/products' />" class="nav-item nav-link"><spring:message code="layout.header.nav.products"/></a>
                    <%-- <a href="<c:url value='/promotions' />" class="nav-item nav-link"><spring:message code="layout.header.nav.promotions"/></a> --%>
                    <%-- <a href="<c:url value='/blog' />" class="nav-item nav-link"><spring:message code="layout.header.nav.blog"/></a> --%>
                    <a href="<c:url value='/contact-us' />" class="nav-item nav-link"><spring:message code="layout.header.nav.contact"/></a>
                    <a href="<c:url value='/about-us' />" class="nav-item nav-link"><spring:message code="layout.header.nav.aboutUs"/></a>
                </div>
                <div class="d-flex align-items-center">

                    <form action="<c:url value='/search-results'/>" method="get" class="d-flex me-3 search-form-placeholder">
                        <spring:message code="layout.header.search.placeholder" var="searchPlaceholder"/>
                        <spring:message code="layout.header.search.ariaLabel" var="searchAriaLabel"/>
                        <input class="form-control form-control-sm rounded-pill" type="search" placeholder="${searchPlaceholder}" aria-label="${searchAriaLabel}" name="keyword">
                        <button class="btn btn-outline-primary btn-sm rounded-pill ms-1" type="submit"><i class="fas fa-search"></i></button>
                    </form>
                    <div class="language-switcher">
                        <spring:message code="layout.header.lang.vietnamese.title" var="vietnameseTitle"/>
                        <spring:message code="layout.header.lang.vietnamese.alt" var="vietnameseAlt"/>
                        <a href="?lang=vi_VN" title="${vietnameseTitle}"><img src="<c:url value='/images/flag/flag-vn.png'/>" alt="${vietnameseAlt}" /></a>

                        <spring:message code="layout.header.lang.english.title" var="englishTitle"/>
                        <spring:message code="layout.header.lang.english.alt" var="englishAlt"/>
                        <a href="?lang=en_US" title="${englishTitle}"><img src="<c:url value='/images/flag/flag-us.png'/>" alt="${englishAlt}" /></a>
                    </div>
                    <!-- Cart Icon -->
                    <c:choose>
                        <c:when test="${not empty sessionScope.informationDTO.id}">
                            <a href="<c:url value='/cart' />" class="position-relative me-3 my-auto header-action-icon">
                                <i class="fa fa-shopping-bag fa-lg"></i>
                                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                    <c:out value="${not empty sessionScope.informationDTO.sum ? sessionScope.informationDTO.sum : 0}" />
                                    <span class="visually-hidden"><spring:message code="layout.header.cart.itemsInCart"/></span>
                                </span>
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="<c:url value='/login' />" class="position-relative me-3 my-auto header-action-icon">
                                <i class="fa fa-shopping-bag fa-lg"></i>
                                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                    0
                                    <span class="visually-hidden"><spring:message code="layout.header.cart.itemsInCart"/></span>
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
                                                <i class="fas fa-user"></i>
                                            </c:otherwise>
                                        </c:choose>
                                        <span class="d-none d-sm-inline user-fullname"><c:out value="${sessionScope.informationDTO.fullName}" /></span>
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="userDropdown">
                                        <li><h6 class="dropdown-header"><spring:message code="layout.header.user.greeting"/>, <c:out value="${sessionScope.informationDTO.fullName}" /></h6></li>
                                        <c:if test="${ sessionScope.informationDTO.role eq 'ADMIN'}">
                                            <li><a class="dropdown-item" href="<c:url value='/admin'/>"><i class="fas fa-server me-2"></i><spring:message code="layout.header.user.manageSystem"/></a></li>
                                        </c:if>

                                        <li><a class="dropdown-item" href="<c:url value='/account-management'/>"><i class="fas fa-cog me-2"></i><spring:message code="layout.header.user.accountManagement"/></a></li>
                                        <li><a class="dropdown-item" href="<c:url value='/order-history'/>"><i class="fas fa-history me-2"></i><spring:message code="layout.header.user.orderHistory"/></a></li>

                                        <li><hr class="dropdown-divider"></li>
                                        <li>
                                            <form method="post" action="<c:url value='/logout'/>" class="d-inline">
                                                <security:csrfInput />
                                                <button type="submit" class="dropdown-item"><i class="fas fa-sign-out-alt me-2"></i><spring:message code="layout.header.user.logout"/></button>
                                            </form>
                                        </li>
                                    </ul>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="login-register-buttons d-flex">
                                    <a href="<c:url value='/login'/>" class="btn btn-outline-primary btn-sm rounded-pill me-2"><spring:message code="layout.header.button.login"/></a>
                                    <a href="<c:url value='/register'/>" class="btn btn-primary btn-sm rounded-pill"><spring:message code="layout.header.button.register"/></a>
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