<%--src/main/webapp/WEB-INF/view/client/homepage/show.jsp--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<!-- JSP Path: client/homepage/show.jsp -->
<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">

<head>
    <meta charset="utf-8">
    <title><spring:message code="page.home.meta.title"/></title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="<spring:message code="page.home.meta.keywords"/>" name="keywords">
    <meta content="<spring:message code="page.home.meta.description"/>" name="description">
    <jsp:include page="../layout/common_head_links.jsp"/>
</head>

<body data-user-avatar-url="<c:url value='/client/img/${not empty sessionScope.informationDTO.avatar ? sessionScope.informationDTO.avatar : "avatar.jpg"}'/>"
      data-user-fullname="<c:out value='${sessionScope.informationDTO.fullName}'/>">

<!-- Spinner Start -->
<div id="spinner"
     class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center">
    <div class="spinner-grow text-primary" role="status"></div>
</div>
<!-- Spinner End -->

<jsp:include page="../layout/header.jsp" />
<jsp:include page="../layout/banner.jsp" />
<jsp:include page="../layout/feature.jsp" />

<!-- Products Section Start-->
<div class="container-fluid fruite py-5">
    <div class="container py-5">
        <div class="text-center mx-auto mb-5" style="max-width: 700px;">
            <h1 class="display-5"><spring:message code="page.home.featuredProducts.title"/></h1>
            <p><spring:message code="page.home.featuredProducts.description"/></p>
        </div>
        <div class="row g-4">
            <c:if test="${empty products}">
                <div class="col-12 text-center">
                    <p class="lead"><spring:message code="page.home.featuredProducts.noProducts"/></p>
                </div>
            </c:if>
            <c:forEach var="product" items="${products}">
                <div class="col-md-6 col-lg-4 col-xl-3 mb-4">
                    <div class="card product-card h-100 shadow-sm border-0 rounded-lg overflow-hidden">
                        <div class="product-card-img-container position-relative">
                            <a href="<c:url value='/product/${product.id}'/>">
                                <img src="<c:url value='/images/product/${product.image}'/>"
                                     class="card-img-top product-image" alt="${product.name}"> <%-- Alt text giữ tên sản phẩm --%>
                            </a>
                            <div class="product-card-actions">
                                <form action="<c:url value='/add-product-to-cart/${product.id}'/>" method="post" class="d-inline">
                                    <security:csrfInput />
                                    <input type="hidden" name="quantity" value="1">
                                    <spring:message code="page.home.featuredProducts.button.addToCart.title" var="addToCartTitle"/>
                                    <button type="submit" class="btn btn-sm btn-primary rounded-circle" title="${addToCartTitle}">
                                        <i class="fas fa-shopping-cart"></i>
                                    </button>
                                </form>
                                <spring:message code="page.home.featuredProducts.button.viewDetails.title" var="viewDetailsTitle"/>
                                <a href="<c:url value='/product/${product.id}'/>" class="btn btn-sm btn-outline-secondary rounded-circle ms-2" title="${viewDetailsTitle}">
                                    <i class="fas fa-eye"></i>
                                </a>
                            </div>
                        </div>
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title product-name mb-2">
                                <a href="<c:url value='/product/${product.id}'/>" class="text-decoration-none">
                                        ${product.name} <%-- Tên sản phẩm giữ nguyên --%>
                                </a>
                            </h5>
                            <p class="card-text product-short-desc small text-muted mb-2">
                                    ${product.shortDesc} <%-- Mô tả ngắn giữ nguyên --%>
                            </p>
                            <div class="mt-auto">
                                <p class="card-text product-price fw-bold fs-5 mb-2">
                                    <fmt:formatNumber type="number" value="${product.price}" /> <spring:message code="page.home.featuredProducts.currencySymbol"/>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        <div class="row mt-5">
            <div class="col-12 text-center">
                <a href="<c:url value='/products'/>" class="btn btn-primary rounded-pill py-3 px-5"><spring:message code="page.home.featuredProducts.button.viewAll"/></a>
            </div>
        </div>
    </div>
</div>
<!-- Products Section End-->

<jsp:include page="../layout/chatbot_widget.jsp" />
<jsp:include page="../layout/footer.jsp" />

<!-- Back to Top -->
<a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a> <%-- Title có thể được thêm nếu muốn: title="<spring:message code="page.home.button.backToTop"/>" --%>

<!-- JavaScript Libraries -->
<%-- Giữ nguyên hoặc chuyển vào common_scripts.jsp nếu chưa có --%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="<c:url value='/client/lib/easing/easing.min.js'/>"></script>
<script src="<c:url value='/client/lib/waypoints/waypoints.min.js'/>"></script>
<script src="<c:url value='/client/lib/lightbox/js/lightbox.min.js'/>"></script>
<script src="<c:url value='/client/lib/owlcarousel/owl.carousel.min.js'/>"></script>

<!-- Template Javascript -->
<script src="<c:url value='/client/js/main.js'/>"></script>
</body>

</html>