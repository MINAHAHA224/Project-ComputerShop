<!-- src/main/webapp/WEB-INF/view/client/product/detail.jsp -->
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>


<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">

<head>
    <meta charset="utf-8" />
    <title><spring:message code="page.productDetail.meta.title.prefix"/>${product.name}</title> <%-- Tên sản phẩm giữ nguyên --%>

    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <meta content="${product.shortDesc}" name="description" /> <%-- Mô tả ngắn giữ nguyên --%>
    <meta content="laptop, ${product.name}, ${product.factory}" name="keywords"/> <%-- Keywords giữ nguyên --%>

    <jsp:include page="../layout/common_head_links.jsp" />
    <%-- Styles giữ nguyên --%>
    <style>
        .product-gallery-main img {
            border: 1px solid var(--border-color);
            border-radius: 0.375rem;
            max-height: 450px;
            object-fit: contain;
        }
        .product-gallery-thumbnails img {
            border: 1px solid var(--border-color);
            border-radius: 0.25rem;
            height: 80px;
            width: 80px;
            object-fit: contain;
            cursor: pointer;
            opacity: 0.7;
            transition: opacity 0.2s ease;
        }
        .product-gallery-thumbnails img.active,
        .product-gallery-thumbnails img:hover {
            opacity: 1;
            border-color: var(--primary-color);
        }
        .product-details .product-title {
            font-size: 1.75rem;
            font-weight: 700;
            color: var(--text-color);
        }
        .product-details .product-brand {
            font-size: 0.9rem;
            color: var(--text-muted-color);
        }
        .product-details .product-price-main {
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary-color);
        }
        .product-details .product-old-price {
            font-size: 1.2rem;
            text-decoration: line-through;
            color: var(--text-muted-color);
        }
        .product-details .quantity-input-group .form-control {
            max-width: 60px;
            text-align: center;
            border-left: 0;
            border-right: 0;
        }
        .product-details .quantity-input-group .btn {
            border-color: var(--border-color);
        }
        .product-tabs .nav-link {
            color: var(--text-muted-color);
            font-weight: 500;
        }
        .product-tabs .nav-link.active {
            color: var(--primary-color);
            border-color: var(--border-color) var(--border-color) var(--white-color);
            border-bottom-width: 2px;
            border-bottom-color: var(
                    --primary-color
            ) !important;
        }
        .product-detail-content table {
            width: 100%;
        }
        .product-detail-content table td {
            padding: 0.5rem;
            border-bottom: 1px solid #eee;
        }
        .product-detail-content table tr:last-child td {
            border-bottom: none;
        }
        .product-detail-content table td:first-child {
            font-weight: 500;
            color: var(--text-muted-color);
            width: 30%;
        }
    </style>
</head>

<body>
<!-- Spinner Start -->
<div id="spinner"
     class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center">
    <div class="spinner-grow text-primary" role="status"></div>
</div>
<!-- Spinner End -->

<jsp:include page="../layout/header.jsp"/>


<!-- Single Page Header Start -->
<div class="container-fluid page-header py-5">
    <h1 class="text-center text-white display-6">${product.name}</h1> <%-- Tên sản phẩm giữ nguyên --%>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="<c:url value='/home'/>"><spring:message code="page.productDetail.breadcrumb.home"/></a></li>
        <li class="breadcrumb-item"><a href="<c:url value='/products'/>"><spring:message code="page.productDetail.breadcrumb.products"/></a></li>
        <li class="breadcrumb-item active text-white">${product.name}</li> <%-- Tên sản phẩm giữ nguyên --%>
    </ol>
</div>
<!-- Single Page Header End -->


<!-- Single Product Start -->
<div class="container-fluid py-5 mt-5 single-product-page">
    <div class="container py-5">
        <c:if test="${not empty messageSuccess}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${messageSuccess} <%-- Nếu messageSuccess là key, dùng <spring:message code="${messageSuccess}"/> --%>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        <c:if test="${not empty messageError}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${messageError} <%-- Nếu messageError là key, dùng <spring:message code="${messageError}"/> --%>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <div class="row g-4">
            <div class="col-lg-8">
                <div class="row g-4">
                    <div class="col-lg-5">
                        <div class="product-gallery-main mb-3">
                            <a href="<c:url value='/images/product/${product.image}'/>" data-lightbox="product-gallery" data-title="${product.name}">
                                <img src="<c:url value='/images/product/${product.image}'/>"
                                     class="img-fluid w-100" alt="${product.name}" id="mainProductImage"> <%-- Alt text giữ tên sản phẩm --%>
                            </a>
                        </div>
                        <%-- Thumbnail images: alt text sẽ là "Thumbnail X" hoặc tên sản phẩm --%>
                    </div>
                    <div class="col-lg-7 product-details">
                        <h2 class="product-title mb-2">${product.name}</h2> <%-- Tên sản phẩm giữ nguyên --%>
                        <p class="product-brand mb-2"><spring:message code="page.productDetail.brandLabel"/> <span class="text-primary fw-semibold">${product.factory}</span></p> <%-- Tên hãng giữ nguyên --%>

                        <%-- Đánh giá: nếu có, "đánh giá" có thể cần dịch --%>
                        <%-- <span class="ms-2 text-muted">(4.5) 25 <spring:message code="page.productDetail.review.countSuffix"/></span> --%>

                        <p class="product-price-main mb-1">
                            <fmt:formatNumber type="number" value="${product.price}"/> <spring:message code="page.productDetail.currencySymbol"/>
                        </p>
                        <%-- Giá cũ: nếu có --%>
                        <%-- <p class="product-old-price mb-3">
                            <fmt:formatNumber type="number" value="${product.oldPrice}"/> <spring:message code="page.productDetail.currencySymbol"/>
                        </p> --%>

                        <p class="mb-3 text-muted">${product.shortDesc}</p>
                        <p class="mb-3"><spring:message code="page.productDetail.statusLabel"/>
                            <c:choose>
                                <c:when test="${product.quantity > 0}"><span class="text-success fw-semibold"><spring:message code="page.productDetail.status.inStock"/> (${product.quantity} <spring:message code="page.productDetail.status.inStock.suffix"/>)</span></c:when>
                                <c:otherwise><span class="text-danger fw-semibold"><spring:message code="page.productDetail.status.outOfStock"/></span></c:otherwise>
                            </c:choose>
                        </p>

                        <c:if test="${product.quantity > 0}">
                            <form action="<c:url value='/add-product-from-view-detail'/>" method="post" id="addToCartFormDetail"">
                                <input type="hidden" name="id" value="${product.id}"/>
                                <security:csrfInput />
                                <div class="d-flex align-items-center mb-4">
                                    <label for="formQuantityInputDetail" class="me-3 fw-semibold"><spring:message code="page.productDetail.quantityLabel"/></label>
                                    <div class="input-group quantity" style="width: 130px;">
                                        <div class="input-group-btn">
                                            <button class="btn btn-sm btn-light rounded-start border btn-minus-detail" type="button">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                        <input type="text" name="quantity" id="formQuantityInputDetail" class="form-control form-control-sm text-center formQuantityInputDetail" data-quantity="${product.quantity}" value="1" readonly>
                                        <div class="input-group-btn">
                                            <button class="btn btn-sm btn-light rounded-end border btn-plus-detail" type="button">
                                                <i class="fa fa-plus"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>

                                <button type="submit" class="btn btn-primary rounded-pill px-4 py-2 mb-2 text-white">
                                    <i class="fa fa-shopping-bag me-2"></i> <spring:message code="page.productDetail.button.addToCart"/>
                                </button>
                            </form>
                        </c:if>
                        <c:if test="${product.quantity <= 0}">
                            <button type="button" class="btn btn-secondary rounded-pill px-4 py-2 mb-2" disabled>
                                <i class="fa fa-shopping-bag me-2"></i> <spring:message code="page.productDetail.button.outOfStock"/>
                            </button>
                        </c:if>
                    </div>

                    <div class="col-lg-12 mt-4 product-tabs">
                        <nav>
                            <div class="nav nav-tabs mb-3" id="nav-tab" role="tablist">
                                <button class="nav-link active" id="nav-description-tab" data-bs-toggle="tab"
                                        data-bs-target="#nav-description" type="button" role="tab"
                                        aria-controls="nav-description" aria-selected="true"><spring:message code="page.productDetail.tab.description"/></button>
                                <button class="nav-link" id="nav-specs-tab" data-bs-toggle="tab"
                                        data-bs-target="#nav-specs" type="button" role="tab"
                                        aria-controls="nav-specs" aria-selected="false"><spring:message code="page.productDetail.tab.specifications"/></button>
                            </div>
                        </nav>
                        <div class="tab-content product-detail-content" id="nav-tabContent">
                            <div class="tab-pane fade show active p-3 border rounded" id="nav-description" role="tabpanel"
                                 aria-labelledby="nav-description-tab">
                                <c:out value="${product.detailDesc}" escapeXml="false" /> <%-- Mô tả chi tiết giữ nguyên, thường là HTML --%>
                            </div>
                            <div class="tab-pane fade p-3 border rounded" id="nav-specs" role="tabpanel"
                                 aria-labelledby="nav-specs-tab">
                                <p><strong><spring:message code="page.productDetail.specs.basicTitle"/></strong></p>
                                <table>
                                    <tr><td><strong><spring:message code="page.productDetail.specs.cpuLabel"/></strong></td><td>Intel Core i5-11400H (6 nhân 12 luồng, tối đa 4.50GHz)</td></tr>
                                    <tr><td><strong><spring:message code="page.productDetail.specs.ramLabel"/></strong></td><td>8GB DDR4 3200MHz (2 khe, nâng cấp tối đa 32GB)</td></tr>
                                    <tr><td><strong><spring:message code="page.productDetail.specs.storageLabel"/></strong></td><td>512GB SSD NVMe PCIe Gen3</td></tr>
                                    <tr><td><strong><spring:message code="page.productDetail.specs.displayLabel"/></strong></td><td>15.6 inch, Full HD (1920x1080), Tần số quét 144Hz, IPS-level</td></tr>
                                    <tr><td><strong><spring:message code="page.productDetail.specs.graphicsLabel"/></strong></td><td>NVIDIA GeForce GTX 2050 4GB GDDR6 + Intel UHD Graphics</td></tr>
                                    <tr><td><strong><spring:message code="page.productDetail.specs.portsLabel"/></strong></td><td>1x USB 3.2 Gen 2 Type-C, 2x USB 3.2 Gen 1, 1x USB 2.0, HDMI 2.0b, LAN (RJ45), Audio jack</td></tr>
                                    <tr><td><strong><spring:message code="page.productDetail.specs.wirelessLabel"/></strong></td><td>Wi-Fi 6 (802.11ax), Bluetooth 5.1</td></tr>
                                    <tr><td><strong><spring:message code="page.productDetail.specs.webcamLabel"/></strong></td><td>HD 720p</td></tr>
                                    <tr><td><strong><spring:message code="page.productDetail.specs.batteryLabel"/></strong></td><td>48Wh, 3-cell Li-ion</td></tr>
                                    <tr><td><strong><spring:message code="page.productDetail.specs.weightLabel"/></strong></td><td>2.3 kg</td></tr>
                                    <tr><td><strong><spring:message code="page.productDetail.specs.osLabel"/></strong></td><td>Windows 11 Home 64-bit</td></tr>
                                    <tr><td><strong><spring:message code="page.productDetail.specs.colorLabel"/></strong></td><td>Graphite Black</td></tr>
                                    <tr><td><strong><spring:message code="page.productDetail.specs.releaseYearLabel"/></strong></td><td>2022</td></tr>
                                </table>
                                <p class="mt-3"><em><spring:message code="page.productDetail.specs.note"/></em></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4 col-xl-3">
                <div class="row g-4">
                    <div class="col-lg-12">
                        <div class="mb-4">
                            <h4><spring:message code="page.productDetail.sidebar.relatedProducts.title"/></h4>
                        </div>
                        <%-- Sản phẩm liên quan: tên, giá sẽ giữ nguyên, alt text dùng key --%>
                        <spring:message code="page.productDetail.sidebar.alt.relatedProduct" var="relatedProductAlt"/>
                        <div class="d-flex align-items-center justify-content-start mb-3 sidebar-product-item">
                            <div class="rounded me-4" style="width: 80px; height: 80px; flex-shrink: 0;">
                                <img src="<c:url value='/images/product/${product.image}'/>" class="img-fluid rounded" alt="${relatedProductAlt} 1" style="width:100%; height:100%; object-fit:contain;">
                            </div>
                            <div>
                                <h6 class="mb-1"><a href="#">Laptop Gaming Pro X1</a></h6>
                                <%-- Đánh giá --%>
                                <div class="d-flex">
                                    <h5 class="fw-bold me-2 product-price-main">24.990.000 <spring:message code="page.productDetail.currencySymbol"/></h5>
                                </div>
                            </div>
                        </div>
                        <div class="d-flex align-items-center justify-content-start mb-3 sidebar-product-item">
                            <div class="rounded me-4" style="width: 80px; height: 80px; flex-shrink: 0;">
                                <img src="<c:url value='/images/product/${product.image}'/>" class="img-fluid rounded" alt="${relatedProductAlt} 2" style="width:100%; height:100%; object-fit:contain;">
                            </div>
                            <div>
                                <h6 class="mb-1"><a href="#">Laptop Mỏng Nhẹ Zen Y</a></h6>
                                <%-- Đánh giá --%>
                                <div class="d-flex">
                                    <h5 class="fw-bold me-2 product-price-main">18.500.000 <spring:message code="page.productDetail.currencySymbol"/></h5>
                                </div>
                            </div>
                        </div>
                        <div class="d-flex justify-content-center mt-4">
                            <a href="<c:url value='/products?factory=${product.factory}'/>" class="btn btn-primary rounded-pill px-4 py-2"><spring:message code="page.productDetail.sidebar.button.viewMorePrefix"/> ${product.factory}</a>
                        </div>
                    </div>
                    <div class="col-lg-12">
                        <div class="position-relative">
                            <spring:message code="page.productDetail.sidebar.alt.advertisementBanner" var="adBannerAlt"/>
                            <img src="<c:url value='/client/img/banner-detail-sidebar.jpg'/>" class="img-fluid w-100 rounded" alt="${adBannerAlt}">
                        </div>
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
<jsp:include page="../layout/footer.jsp"/>
<jsp:include page="../layout/common_scripts.jsp"/>
<script src="${pageContext.request.contextPath}/client/js/productDetail/productDetail.js"></script>
</body>
</html>