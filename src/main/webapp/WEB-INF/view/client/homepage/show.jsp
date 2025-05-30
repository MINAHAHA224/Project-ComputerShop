<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- JSP Path: client/homepage/show.jsp -->
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8">
    <title>Trang chủ - Laptopshop | Nơi mua sắm Laptop Uy tín</title> <%-- Thêm mô tả hấp dẫn hơn --%>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="Laptop, Gaming Laptop, Mua laptop, Cửa hàng laptop" name="keywords">
    <meta content="Laptopshop - Chuyên cung cấp các dòng laptop chính hãng, gaming, văn phòng với giá tốt nhất và dịch vụ hậu mãi chu đáo." name="description">
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

    <%-- Header --%>
    <jsp:include page="../layout/header.jsp" />

    <%-- Hero/Banner Section --%>
    <jsp:include page="../layout/banner.jsp" />

    <%-- Features Section --%>
    <jsp:include page="../layout/feature.jsp" />

    <!-- Products Section Start-->
    <div class="container-fluid fruite py-5">
        <div class="container py-5">
            <div class="text-center mx-auto mb-5" style="max-width: 700px;">
                <h1 class="display-5">Sản Phẩm Nổi Bật</h1>
                <p>Khám phá những mẫu laptop mới nhất, mạnh mẽ nhất với giá ưu đãi tại Laptopshop.</p>
            </div>
            <div class="row g-4">
                <c:if test="${empty products}">
                    <div class="col-12 text-center">
                        <p class="lead">Hiện chưa có sản phẩm nào nổi bật.</p>
                    </div>
                </c:if>
                <c:forEach var="product" items="${products}">
                    <div class="col-md-6 col-lg-4 col-xl-3 mb-4">
                        <div class="card product-card h-100 shadow-sm border-0 rounded-lg overflow-hidden">
                            <div class="product-card-img-container position-relative">
                                <a href="<c:url value='/product/${product.id}'/>">
                                    <img src="<c:url value='/images/product/${product.image}'/>"
                                         class="card-img-top product-image" alt="${product.name}">
                                </a>
                                <div class="product-card-actions">
                                    <form action="<c:url value='/add-product-to-cart/${product.id}'/>" method="post" class="d-inline">
                                        <security:csrfInput />
                                        <input type="hidden" name="quantity" value="1">
                                        <button type="submit" class="btn btn-sm btn-primary rounded-circle" title="Thêm vào giỏ">
                                            <i class="fas fa-shopping-cart"></i>
                                        </button>
                                    </form>
                                    <a href="<c:url value='/product/${product.id}'/>" class="btn btn-sm btn-outline-secondary rounded-circle ms-2" title="Xem chi tiết">
                                        <i class="fas fa-eye"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="card-body d-flex flex-column">
                                <h5 class="card-title product-name mb-2">
                                    <a href="<c:url value='/product/${product.id}'/>" class="text-decoration-none">
                                        ${product.name}
                                    </a>
                                </h5>
                                <p class="card-text product-short-desc small text-muted mb-2">
                                    ${product.shortDesc}
                                </p>
                                <div class="mt-auto">
                                    <p class="card-text product-price fw-bold fs-5 mb-2">
                                        <fmt:formatNumber type="number" value="${product.price}" /> đ
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
           
            </div>
            <div class="row mt-5">
                <div class="col-12 text-center">
                    <a href="<c:url value='/products'/>" class="btn btn-primary rounded-pill py-3 px-5">Xem Tất Cả Sản Phẩm</a>
                </div>
            </div>
        </div>
    </div>
    <!-- Products Section End-->

    <%-- Có thể thêm các section khác ở đây: CTA, Testimonials, Blog posts,... --%>

    <%-- Footer --%>
    <jsp:include page="../layout/chatbot_widget.jsp" />
    <jsp:include page="../layout/footer.jsp" />

    <!-- Back to Top -->
    <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a>

    <!-- JavaScript Libraries -->
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