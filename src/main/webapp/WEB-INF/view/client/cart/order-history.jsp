<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title> Lịch sử mua hàng - Laptopshop</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
            href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
            rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
          rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="${pageContext.request.contextPath}/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


    <!-- Customized Bootstrap Stylesheet -->
    <link href="${pageContext.request.contextPath}/client/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="${pageContext.request.contextPath}/client/css/style.css" rel="stylesheet">
    <style>
        /* Thêm style để các dòng thông tin order dễ phân biệt hơn */
        .order-summary-row td {
            font-weight: bold;
            background-color: #f8f9fa; /* Màu nền nhẹ cho dòng tóm tắt order */
        }
        .order-summary-row td:first-child {
            border-top-left-radius: 5px;
        }
        .order-summary-row td:last-child {
            border-top-right-radius: 5px;
        }
        .order-detail-row:last-child td:first-child {
            border-bottom-left-radius: 5px;
        }
        .order-detail-row:last-child td:nth-last-child(2) { /* Nth last child before the empty TD */
            border-bottom-right-radius: 5px;
        }

    </style>
</head>

<body>

<!-- Spinner Start -->
<div id="spinner"
     class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
    <div class="spinner-grow text-primary" role="status"></div>
</div>
<!-- Spinner End -->

<jsp:include page="../layout/header.jsp" />

<!-- Cart Page Start -->
<div class="container-fluid py-5">
    <div class="container py-5">
        <div class="mb-3">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Lịch sử mua hàng</li>
                </ol>
            </nav>
        </div>

        <div class="table-responsive">
            <table class="table">
                <thead>
                <tr>
                    <th scope="col">Sản phẩm</th>
                    <th scope="col">Tên</th>
                    <th scope="col">Giá cả</th>
                    <th scope="col">Số lượng</th>
                    <th scope="col">Thành tiền</th>
                    <th scope="col">Trạng thái</th>
                </tr>
                </thead>
                <tbody>
                <c:if test="${empty orders}">
                    <tr>
                        <td colspan="6" class="text-center">
                            Không có đơn hàng nào được tạo.
                        </td>
                    </tr>
                </c:if>
                <c:forEach var="order" items="${orders}">
                    <%-- Dòng hiển thị thông tin chung của Order --%>
                    <tr class="order-summary-row">
                        <td colspan="2">Mã đơn: <strong>#${order.id}</strong></td>
                        <td colspan="1">
                            Tổng tiền: <fmt:formatNumber type="number" value="${order.totalPrice}" /> đ
                        </td>
                        <td colspan="2"></td> <%-- Giữ cho cột số lượng và thành tiền trống ở dòng này --%>
                        <td colspan="1">
                            <c:choose>
                                <c:when test="${order.status == 'PENDING'}">Chờ xác nhận</c:when>
                                <c:when test="${order.status == 'CONFIRMED'}">Đã xác nhận đơn</c:when>
                                <c:when test="${order.status == 'SHIPPED'}">Đã giao cho bên vận chuyển</c:when>
                                <c:when test="${order.status == 'DELIVERED'}">Giao hàng thành công</c:when>
                                <c:when test="${order.status == 'CANCELLED'}">Hủy đơn hàng</c:when>
                                <c:otherwise>Không rõ trạng thái</c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <%-- Dòng hiển thị chi tiết các sản phẩm trong Order --%>
                    <c:forEach var="orderDetail" items="${order.orderDetails}" varStatus="loop">
                        <tr class="order-detail-row ${loop.last ? 'border-bottom' : ''}">
                            <th scope="row">
                                <div class="d-flex align-items-center">
                                    <img src="${pageContext.request.contextPath}/images/product/${orderDetail.productImage}"
                                         class="img-fluid me-5 rounded-circle"
                                         style="width: 80px; height: 80px;" alt="${orderDetail.productName}">
                                </div>
                            </th>
                            <td>
                                <p class="mb-0 mt-4">
                                    <a href="${pageContext.request.contextPath}/product/${orderDetail.productId}" target="_blank">
                                            ${orderDetail.productName}
                                    </a>
                                </p>
                            </td>
                            <td>
                                <p class="mb-0 mt-4">
                                    <fmt:formatNumber type="number" value="${orderDetail.price}" /> đ
                                </p>
                            </td>
                            <td>
                                    <%-- Sửa lại thành hiển thị text, không phải input --%>
                                <p class="mb-0 mt-4 text-center">
                                        ${orderDetail.productQuantity}
                                </p>
                            </td>
                            <td>
                                <p class="mb-0 mt-4">
                                    <fmt:formatNumber type="number"
                                                      value="${orderDetail.price * orderDetail.productQuantity}" /> đ
                                </p>
                            </td>
                            <td></td> <%-- Cột trạng thái để trống cho dòng chi tiết sản phẩm --%>
                        </tr>
                    </c:forEach>
                    <%-- Thêm một dòng trống để ngăn cách các order nếu muốn --%>
                    <c:if test="${!empty orders}">
                        <tr><td colspan="6" style="border:0; height: 20px;"></td></tr>
                    </c:if>
                </c:forEach>

                </tbody>
            </table>
        </div>

    </div>
</div>
<!-- Cart Page End -->


<jsp:include page="../layout/footer.jsp" />


<!-- Back to Top -->
<a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
        class="fa fa-arrow-up"></i></a>


<!-- JavaScript Libraries -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/client/lib/easing/easing.min.js"></script>
<script src="${pageContext.request.contextPath}/client/lib/waypoints/waypoints.min.js"></script>
<script src="${pageContext.request.contextPath}/client/lib/lightbox/js/lightbox.min.js"></script>
<script src="${pageContext.request.contextPath}/client/lib/owlcarousel/owl.carousel.min.js"></script>

<!-- Template Javascript -->
<script src="${pageContext.request.contextPath}/client/js/main.js"></script>
</body>

</html>