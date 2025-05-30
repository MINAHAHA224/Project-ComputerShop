<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@taglib
uri="http://www.springframework.org/tags/form" prefix="form" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!-- JSP Path: client/product/detail.jsp -->
<!DOCTYPE html>
<html lang="vi">

  <head>
    <meta charset="utf-8" />
    <title>3TLap - ${product.name}</title>

    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <meta content="${product.shortDesc}" name="description" />
    <meta
      content="laptop, ${product.name}, ${product.factory}"
      name="keywords"
    />

    <jsp:include page="../layout/common_head_links.jsp" />
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

    <%-- Include Header --%>
    <jsp:include page="../layout/header.jsp"/>

    <!-- Single Page Header Start -->
    <div class="container-fluid page-header py-5">
        <h1 class="text-center text-white display-6">${product.name}</h1>
        <ol class="breadcrumb justify-content-center mb-0">
            <li class="breadcrumb-item"><a href="<c:url value='/home'/>">Trang Chủ</a></li>
            <li class="breadcrumb-item"><a href="<c:url value='/products'/>">Sản Phẩm</a></li>
            <li class="breadcrumb-item active text-white">${product.name}</li>
        </ol>
    </div>
    <!-- Single Page Header End -->

    <!-- Single Product Start -->
    <div class="container-fluid py-5 mt-5 single-product-page">
        <div class="container py-5">
            <c:if test="${not empty messageSuccess}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${messageSuccess}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
             <c:if test="${not empty messageError}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${messageError}
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
                                         class="img-fluid w-100" alt="${product.name}" id="mainProductImage">
                                </a>
                            </div>
                            <%-- Nếu trong database có nhiều ảnh thì hãy sử dụng --%>
                            <!-- <%--
                            <div class="product-gallery-thumbnails d-flex justify-content-start">
                                <img src="<c:url value='/images/product/${product.image}'/>" class="active" onclick="changeMainImage(this.src)" alt="Thumbnail 1">
                                <c:if test="${not empty product.image2}"> <img src="<c:url value='/images/product/${product.image2}'/>" onclick="changeMainImage(this.src)" alt="Thumbnail 2"></c:if>
                                <c:if test="${not empty product.image3}"> <img src="<c:url value='/images/product/${product.image3}'/>" onclick="changeMainImage(this.src)" alt="Thumbnail 3"></c:if>
                            </div>
                            --%> -->
                        </div>
                        <div class="col-lg-7 product-details">
                            <h2 class="product-title mb-2">${product.name}</h2>
                            <p class="product-brand mb-2">Thương hiệu: <span class="text-primary fw-semibold">${product.factory}</span></p>
                            
                            <%-- Nếu có chức năng đánh giá thì hãy sử dụng --%>
                            <!-- <%-- <div class="d-flex mb-2">
                                <i class="fa fa-star text-warning"></i>
                                <i class="fa fa-star text-warning"></i>
                                <i class="fa fa-star text-warning"></i>
                                <i class="fa fa-star text-warning"></i>
                                <i class="fa fa-star-half-alt text-warning"></i>
                                <span class="ms-2 text-muted">(4.5) 25 đánh giá</span>
                            </div> --%> -->

                            <p class="product-price-main mb-1">
                                <fmt:formatNumber type="number" value="${product.price}"/> đ
                            </p>
                            <%-- Nếu có chức năng giảm giá thì hãy sử dụng --%>
                            <!-- <%-- <c:if test="${product.onSale && product.oldPrice > 0}">
                                <p class="product-old-price mb-3">
                                    <fmt:formatNumber type="number" value="${product.oldPrice}"/> đ
                                </p>
                            </c:if> --%> -->

                            <p class="mb-3 text-muted">${product.shortDesc}</p>
                            
                            <p class="mb-3">Tình trạng: 
                                <c:choose>
                                    <c:when test="${product.quantity > 0}"><span class="text-success fw-semibold">Còn hàng (${product.quantity} sản phẩm)</span></c:when>
                                    <c:otherwise><span class="text-danger fw-semibold">Hết hàng</span></c:otherwise>
                                </c:choose>
                            </p>

                            <c:if test="${product.quantity > 0}">
                                <form action="<c:url value='/add-product-from-view-detail'/>" method="post" id="addToCartFormDetail">
                                    <input type="hidden" name="id" value="${product.id}"/>
                                    <security:csrfInput />
                                    <div class="d-flex align-items-center mb-4">
                                        <label for="formQuantityInputDetail" class="me-3 fw-semibold">Số lượng:</label>
                                        <div class="input-group quantity" style="width: 130px;">
                                            <div class="input-group-btn">
                                                <button class="btn btn-sm btn-light rounded-start border btn-minus-detail" type="button">
                                                    <i class="fa fa-minus"></i>
                                                </button>
                                            </div>
                                            <input type="text" name="quantity" id="formQuantityInputDetail" class="form-control form-control-sm text-center" value="1" readonly>
                                            <div class="input-group-btn">
                                                <button class="btn btn-sm btn-light rounded-end border btn-plus-detail" type="button">
                                                    <i class="fa fa-plus"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>

                                    <button type="submit" class="btn btn-primary rounded-pill px-4 py-2 mb-2 text-white">
                                        <i class="fa fa-shopping-bag me-2"></i> Thêm vào giỏ hàng
                                    </button>
                                </form>
                            </c:if>
                            <c:if test="${product.quantity <= 0}">
                                 <button type="button" class="btn btn-secondary rounded-pill px-4 py-2 mb-2" disabled>
                                    <i class="fa fa-shopping-bag me-2"></i> Hết hàng
                                </button>
                            </c:if>
                        </div>

                        <div class="col-lg-12 mt-4 product-tabs">
                            <nav>
                                <div class="nav nav-tabs mb-3" id="nav-tab" role="tablist">
                                    <button class="nav-link active" id="nav-description-tab" data-bs-toggle="tab"
                                            data-bs-target="#nav-description" type="button" role="tab"
                                            aria-controls="nav-description" aria-selected="true">Mô tả chi tiết</button>
                                    <button class="nav-link" id="nav-specs-tab" data-bs-toggle="tab"
                                            data-bs-target="#nav-specs" type="button" role="tab"
                                            aria-controls="nav-specs" aria-selected="false">Thông số kỹ thuật</button>
                                </div>
                            </nav>
                            <div class="tab-content product-detail-content" id="nav-tabContent">
                                <div class="tab-pane fade show active p-3 border rounded" id="nav-description" role="tabpanel"
                                     aria-labelledby="nav-description-tab">
                                
                                    <c:out value="${product.detailDesc}" escapeXml="false" />
                                </div>
                                <div class="tab-pane fade p-3 border rounded" id="nav-specs" role="tabpanel"
                                     aria-labelledby="nav-specs-tab">
                                    <%-- Cần có cấu trúc dữ liệu riêng cho thông số kỹ thuật --%>
                                    <p><strong>Thông số cơ bản:</strong></p>
<table>
    <tr><td><strong>CPU:</strong></td><td>Intel Core i5-11400H (6 nhân 12 luồng, tối đa 4.50GHz)</td></tr>
    <tr><td><strong>RAM:</strong></td><td>8GB DDR4 3200MHz (2 khe, nâng cấp tối đa 32GB)</td></tr>
    <tr><td><strong>Ổ cứng:</strong></td><td>512GB SSD NVMe PCIe Gen3</td></tr>
    <tr><td><strong>Màn hình:</strong></td><td>15.6 inch, Full HD (1920x1080), Tần số quét 144Hz, IPS-level</td></tr>
    <tr><td><strong>Card đồ họa:</strong></td><td>NVIDIA GeForce GTX 2050 4GB GDDR6 + Intel UHD Graphics</td></tr>
    <tr><td><strong>Cổng kết nối:</strong></td><td>1x USB 3.2 Gen 2 Type-C, 2x USB 3.2 Gen 1, 1x USB 2.0, HDMI 2.0b, LAN (RJ45), Audio jack</td></tr>
    <tr><td><strong>Kết nối không dây:</strong></td><td>Wi-Fi 6 (802.11ax), Bluetooth 5.1</td></tr>
    <tr><td><strong>Webcam:</strong></td><td>HD 720p</td></tr>
    <tr><td><strong>Pin:</strong></td><td>48Wh, 3-cell Li-ion</td></tr>
    <tr><td><strong>Trọng lượng:</strong></td><td>2.3 kg</td></tr>
    <tr><td><strong>Hệ điều hành:</strong></td><td>Windows 11 Home 64-bit</td></tr>
    <tr><td><strong>Màu sắc:</strong></td><td>Graphite Black</td></tr>
    <tr><td><strong>Năm ra mắt:</strong></td><td>2022</td></tr>
</table>

                                    <p class="mt-3"><em>Lưu ý: Thông số kỹ thuật chi tiết có thể thay đổi tùy theo cấu hình cụ thể của sản phẩm. Vui lòng liên hệ để biết thêm chi tiết.</em></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Sidebar (Sản phẩm liên quan, ...) -->
                <div class="col-lg-4 col-xl-3">
                    <div class="row g-4">
                        <div class="col-lg-12">
                            <div class="mb-4">
                                <h4>Sản Phẩm Liên Quan</h4>
                            </div>
                            <%-- Logic hiển thị sản phẩm liên quan từ controller --%>
                
                            <div class="d-flex align-items-center justify-content-start mb-3 sidebar-product-item">
                                <div class="rounded me-4" style="width: 80px; height: 80px; flex-shrink: 0;">
                                    <img src="<c:url value='/images/product/${product.image}'/>" class="img-fluid rounded" alt="Related Product 1" style="width:100%; height:100%; object-fit:contain;">
                                </div>
                                <div>
                                    <h6 class="mb-1"><a href="#">Laptop Gaming Pro X1</a></h6>
                                    <div class="d-flex mb-1">
                                        <i class="fa fa-star text-warning"></i>
                                        <i class="fa fa-star text-warning"></i>
                                        <i class="fa fa-star text-warning"></i>
                                        <i class="fa fa-star text-warning"></i>
                                        <i class="fa fa-star"></i>
                                    </div>
                                    <div class="d-flex">
                                        <h5 class="fw-bold me-2 product-price-main">24.990.000 đ</h5>
                                        <%-- <h5 class="text-danger text-decoration-line-through product-old-price">26.500.000 đ</h5> --%>
                                    </div>
                                </div>
                            </div>
                    
                             <div class="d-flex align-items-center justify-content-start mb-3 sidebar-product-item">
                                <div class="rounded me-4" style="width: 80px; height: 80px; flex-shrink: 0;">
                                    <img src="<c:url value='/images/product/${product.image}'/>" class="img-fluid rounded" alt="Related Product 2" style="width:100%; height:100%; object-fit:contain;">
                                </div>
                                <div>
                                    <h6 class="mb-1"><a href="#">Laptop Mỏng Nhẹ Zen Y</a></h6>
                                    <div class="d-flex mb-1">
                                         <i class="fa fa-star text-warning"></i>
                                         <i class="fa fa-star text-warning"></i>
                                         <i class="fa fa-star text-warning"></i>
                                         <i class="fa fa-star text-warning"></i>
                                         <i class="fa fa-star-half-alt text-warning"></i>
                                    </div>
                                    <div class="d-flex">
                                        <h5 class="fw-bold me-2 product-price-main">18.500.000 đ</h5>
                                    </div>
                                </div>
                            </div>

                            <div class="d-flex justify-content-center mt-4">
                                <a href="<c:url value='/products?factory=${product.factory}'/>" class="btn btn-primary rounded-pill px-4 py-2">Xem Thêm ${product.factory}</a>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="position-relative">
                                <img src="<c:url value='/client/img/banner-detail-sidebar.jpg'/>" class="img-fluid w-100 rounded" alt="Banner quảng cáo">
                    
                            </div>
                        </div>
                    </div>
                </div>
            </div>
       
        </div>
    </div>
    <!-- Single Product End -->

    <jsp:include page="../layout/footer.jsp"/>
    <jsp:include page="../layout/common_scripts.jsp"/>
    <script src="${pageContext.request.contextPath}/client/js/productDetail/productDetail.js"></script>
</body>
</html>
