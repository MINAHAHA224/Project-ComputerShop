
<!-- JSP Path: src/main/webapp/WEB-INF/view/client/product/show.jsp -->
<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8">
                    <title><spring:message code="page.products.meta.title"/></title>
                    <meta content="width=device-width, initial-scale=1.0" name="viewport">
                    <meta content="" name="keywords"> <%-- Giữ nguyên hoặc thêm key nếu cần --%>
                    <meta content="" name="description"> <%-- Giữ nguyên hoặc thêm key nếu cần --%>

                    <jsp:include page="../layout/common_head_links.jsp" />
                </head>

                <body>

                <!-- Spinner Start -->
                <div id="spinner"
                     class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
                    <div class="spinner-grow text-primary" role="status"></div>
                </div>
                <!-- Spinner End -->

                <jsp:include page="../layout/header.jsp" />
<script type="text/javascript">
    window.productSearchData = JSON.parse('${dataSearchJson}'); 
    // Nếu dùng session: window.productSearchData = JSON.parse('${sessionScope.dataSearchJson}');
</script>


                <!-- Single Product Start -->
                <div class="container-fluid py-5 mt-5">
                    <div class="container py-5">
                        <div class="row g-4 mb-5">
                            <div>
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="<c:url value='/'/>"><spring:message code="page.products.breadcrumb.home"/></a></li>
                                        <li class="breadcrumb-item active" aria-current="page"><spring:message code="page.products.breadcrumb.productList"/></li>
                                    </ol>
                                </nav>
                            </div>

                            <div class="row g-4 fruite">
                                <div class="col-12 col-md-4">
                                    <div class="row g-4">
                                        <div class="col-12" id="factoryFilter">
                                            <div class="mb-2"><b><spring:message code="page.products.filter.factory.title"/></b></div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" id="factory-1" value="APPLE">
                                                <label class="form-check-label" for="factory-1"><spring:message code="page.products.filter.factory.apple"/></label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" id="factory-2" value="ASUS">
                                                <label class="form-check-label" for="factory-2"><spring:message code="page.products.filter.factory.asus"/></label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" id="factory-3" value="LENOVO">
                                                <label class="form-check-label" for="factory-3"><spring:message code="page.products.filter.factory.lenovo"/></label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" id="factory-4" value="DELL">
                                                <label class="form-check-label" for="factory-4"><spring:message code="page.products.filter.factory.dell"/></label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" id="factory-5" value="LG">
                                                <label class="form-check-label" for="factory-5"><spring:message code="page.products.filter.factory.lg"/></label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" id="factory-6" value="ACER">
                                                <label class="form-check-label" for="factory-6"><spring:message code="page.products.filter.factory.acer"/></label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" id="factory-7" value="HP">
                                                <label class="form-check-label" for="factory-7"><spring:message code="page.products.filter.factory.hp"/></label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" id="factory-8" value="SAMSUNG">
                                                <label class="form-check-label" for="factory-8"><spring:message code="page.products.filter.factory.samsung"/></label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" id="factory-9" value="MSI">
                                                <label class="form-check-label" for="factory-9"><spring:message code="page.products.filter.factory.msi"/></label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" id="factory-10" value="MICROSOFT">
                                                <label class="form-check-label" for="factory-10"><spring:message code="page.products.filter.factory.microsoft"/></label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" id="factory-11" value="GIGABYTE">
                                                <label class="form-check-label" for="factory-11"><spring:message code="page.products.filter.factory.gigabyte"/></label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" id="factory-12" value="RAZER">
                                                <label class="form-check-label" for="factory-12"><spring:message code="page.products.filter.factory.razer"/></label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" id="factory-13" value="HUAWEI">
                                                <label class="form-check-label" for="factory-13"><spring:message code="page.products.filter.factory.huawei"/></label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" id="factory-14" value="XIAOMI">
                                                <label class="form-check-label" for="factory-14"><spring:message code="page.products.filter.factory.xiaomi"/></label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" id="factory-15" value="GOOGLE">
                                                <label class="form-check-label" for="factory-15"><spring:message code="page.products.filter.factory.google"/></label>
                                            </div>
                                        </div>
                                        <div class="col-12" id="targetFilter">
                                            <div class="mb-2"><b><spring:message code="page.products.filter.target.title"/></b></div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" id="target-1" value="GAMING">
                                                <label class="form-check-label" for="target-1"><spring:message code="page.products.filter.target.gaming"/></label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" id="target-2" value="SINHVIEN-VANPHONG">
                                                <label class="form-check-label" for="target-2"><spring:message code="page.products.filter.target.studentOffice"/></label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" id="target-3" value="THIET-KE-DO-HOA">
                                                <label class="form-check-label" for="target-3"><spring:message code="page.products.filter.target.graphicDesign"/></label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" id="target-4" value="MONG-NHE">
                                                <label class="form-check-label" for="target-4"><spring:message code="page.products.filter.target.thinLight"/></label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" id="target-5" value="DOANH-NHAN">
                                                <label class="form-check-label" for="target-5"><spring:message code="page.products.filter.target.business"/></label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" id="target-6" value="LAP-TRINH">
                                                <label class="form-check-label" for="target-6"><spring:message code="page.products.filter.target.programming"/></label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" id="target-7" value="SANG-TAO-NOI-DUNG">
                                                <label class="form-check-label" for="target-7"><spring:message code="page.products.filter.target.contentCreation"/></label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" id="target-8" value="MAY-TRAM-WORKSTATION">
                                                <label class="form-check-label" for="target-8"><spring:message code="page.products.filter.target.workstation"/></label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" id="target-9" value="CAO-CAP-SANG-TRONG">
                                                <label class="form-check-label" for="target-9"><spring:message code="page.products.filter.target.premiumLuxury"/></label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" id="target-10" value="2-TRONG-1-XOAY-GAP">
                                                <label class="form-check-label" for="target-10"><spring:message code="page.products.filter.target.convertible"/></label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" id="target-11" value="HOC-TAP-CO-BAN">
                                                <label class="form-check-label" for="target-11"><spring:message code="page.products.filter.target.basicStudy"/></label>
                                            </div>
                                        </div>
                                        <div class="col-12" id="priceFilter">
                                            <div class="mb-2"><b><spring:message code="page.products.filter.price.title"/></b></div>
                                            <spring:message code="page.products.filter.price.unit" var="priceUnit"/>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" id="price-2" value="duoi-10-trieu">
                                                <label class="form-check-label" for="price-2"><spring:message code="page.products.filter.price.under10m"/></label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" id="price-3" value="10-15-trieu">
                                                <label class="form-check-label" for="price-3"><spring:message code="page.products.filter.price.10to15m"/> </label> <%-- Giữ nguyên 'triệu' hoặc dùng ${priceUnit} nếu muốn --%>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" id="price-4" value="15-20-trieu">
                                                <label class="form-check-label" for="price-4"><spring:message code="page.products.filter.price.15to20m"/> </label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="checkbox" id="price-5" value="tren-20-trieu">
                                                <label class="form-check-label" for="price-5"><spring:message code="page.products.filter.price.over20m"/> </label>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="mb-2"><b><spring:message code="page.products.filter.sort.title"/></b></div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" id="sort-1" value="gia-tang-dan" name="radio-sort">
                                                <label class="form-check-label" for="sort-1"><spring:message code="page.products.filter.sort.priceAsc"/></label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" id="sort-2" value="gia-giam-dan" name="radio-sort">
                                                <label class="form-check-label" for="sort-2"><spring:message code="page.products.filter.sort.priceDesc"/></label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" id="sort-3" checked value="gia-nothing" name="radio-sort">
                                                <label class="form-check-label" for="sort-3"><spring:message code="page.products.filter.sort.noSort"/></label>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <button
                                                    class="btn border-secondary rounded-pill px-4 py-3 text-primary text-uppercase mb-4"
                                                    id="btnFilter">
                                                <spring:message code="page.products.filter.button.applyFilter"/>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12 col-md-8 text-center">
                                    <div class="row g-4">
                                        <c:if test="${totalPages ==  0}">
                                            <div><spring:message code="page.products.noProductsFound"/></div>
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
                                                                <spring:message code="page.products.card.button.addToCart.title" var="addToCartTitle"/>
                                                                <button type="submit" class="btn btn-sm btn-primary rounded-circle" title="${addToCartTitle}">
                                                                    <i class="fas fa-shopping-cart"></i>
                                                                </button>
                                                            </form>
                                                            <spring:message code="page.products.card.button.viewDetails.title" var="viewDetailsTitle"/>
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
                                                                <fmt:formatNumber type="number" value="${product.price}" /> <spring:message code="page.products.card.currencySymbol"/>
                                                            </p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>

                                        <c:if test="${totalPages > 0}">
                                            <div class="pagination d-flex justify-content-center mt-5">
                                                <li class="page-item">
                                                    <spring:message code="page.products.pagination.previous.ariaLabel" var="prevAriaLabel"/>
                                                    <a class="${1 eq currentPage ? 'disabled page-link' : 'page-link'}"
                                                       href="/products?page=${currentPage - 1}${queryString}"
                                                       aria-label="${prevAriaLabel}">
                                                        <span aria-hidden="true">«</span>
                                                    </a>
                                                </li>
                                                <c:forEach begin="0" end="${totalPages - 1}" varStatus="loop">
                                                    <li class="page-item">
                                                        <a class="${(loop.index + 1) eq currentPage ? 'active page-link' : 'page-link'}"
                                                           href="/products?page=${loop.index + 1}${queryString}">
                                                                ${loop.index + 1}
                                                        </a>
                                                    </li>
                                                </c:forEach>
                                                <li class="page-item">
                                                    <spring:message code="page.products.pagination.next.ariaLabel" var="nextAriaLabel"/>
                                                    <a class="${totalPages eq currentPage ? 'disabled page-link' : 'page-link'}"
                                                       href="/products?page=${currentPage + 1}${queryString}"
                                                       aria-label="${nextAriaLabel}">
                                                        <span aria-hidden="true">»</span>
                                                    </a>
                                                </li>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                    <!-- Single Product End -->
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
                    <jsp:include page="../layout/footer.jsp" />


                    <!-- Back to Top -->
                    <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
                            class="fa fa-arrow-up"></i></a>


                    <jsp:include page="../layout/common_scripts.jsp" />
                </body>

                </html>