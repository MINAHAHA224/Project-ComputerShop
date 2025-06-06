<%--src/main/webapp/WEB-INF/view/client/cart/order-history.jsp--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <title><spring:message code="page.orderHistory.meta.title"/></title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="<spring:message code="page.orderHistory.meta.keywords"/>" name="keywords">
    <meta content="<spring:message code="page.orderHistory.meta.description"/>" name="description">

    <jsp:include page="../layout/common_head_links.jsp"/>
    <style>
        .order-history-page-header {
            background: linear-gradient(rgba(0,0,0,0.58), rgba(0,0,0,0.58)), url('<c:url value="/client/img/order-history-banner.jpg"/>');
            background-position: center center;
            background-repeat: no-repeat;
            background-size: cover;
        }
        .order-card {
            background-color: var(--white-color);
            border: 1px solid var(--border-color);
            border-radius: 0.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 0.125rem 0.35rem rgba(0,0,0,.065);
        }
        .order-card-header {
            padding: 1rem 1.25rem;
            background-color: var(--light-bg-color);
            border-bottom: 1px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-top-left-radius: calc(0.5rem - 1px);
            border-top-right-radius: calc(0.5rem - 1px);
        }
        .order-card-header .order-id {
            font-family: var(--font-primary);
            font-weight: 600;
            color: var(--primary-color);
            font-size: 1.1rem;
        }
        .order-card-header .order-date {
            font-size: 0.85rem;
            color: var(--text-muted-color);
        }
        .order-card-body {
            padding: 1.25rem;
        }
        .order-summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
            font-size: 0.95rem;
        }
        .order-summary-item strong {
            color: var(--text-color);
        }
        .order-status-badge {
            font-size: 0.8rem;
            font-weight: 500;
            padding: 0.3em 0.7em;
        }
        .order-details-table {
            margin-top: 1rem;
            font-size: 0.9rem;
        }
        .order-details-table th {
            background-color: #f8f9fa;
            font-weight: 500;
            color: var(--text-muted-color);
            font-size: 0.85rem;
        }
        .order-details-table img {
            width: 50px;
            height: 50px;
            object-fit: contain;
            border-radius: 0.25rem;
        }
        .order-details-table .product-name-history a {
            color: var(--text-color);
            text-decoration: none;
            font-weight: 500;
        }
        .order-details-table .product-name-history a:hover {
            color: var(--primary-color);
        }
        .btn-toggle-details {
            font-size: 0.85rem;
        }
        .no-orders-message {
            min-height: 40vh;
        }
    </style>
</head>

<body>
<div id="spinner"
     class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center">
    <div class="spinner-grow text-primary" role="status"></div>
</div>

<jsp:include page="../layout/header.jsp"/>

<div class="container-fluid page-header order-history-page-header py-5">
    <h1 class="text-center text-white display-6"><spring:message code="page.orderHistory.header.title"/></h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="<c:url value='/'/>"><spring:message code="page.orderHistory.breadcrumb.home"/></a></li>
        <li class="breadcrumb-item active text-white"><spring:message code="page.orderHistory.breadcrumb.orderHistory"/></li>
    </ol>
</div>

<div class="container-fluid py-5">
    <div class="container py-5">
        <c:if test="${empty orders}">
            <div class="text-center py-5 no-orders-message">
                <i class="fas fa-box-open fa-5x text-muted mb-3"></i>
                <h3 class="mb-3"><spring:message code="page.orderHistory.empty.title"/></h3>
                <p class="text-muted mb-4"><spring:message code="page.orderHistory.empty.message"/></p>
                <a href="<c:url value='/products'/>" class="btn btn-primary rounded-pill py-3 px-5"><spring:message code="page.orderHistory.empty.button.startShopping"/></a>
            </div>
        </c:if>

        <c:if test="${not empty orders}">
            <div class="row">
                <div class="col-12">
                    <c:forEach var="order" items="${orders}" varStatus="orderLoop">
                        <div class="order-card wow fadeInUp" data-wow-delay="${orderLoop.index * 0.1}s">
                            <div class="order-card-header">
                                <div>
                                    <span class="order-id"><spring:message code="page.orderHistory.card.orderPrefix"/>${order.id}</span>
                                    <span class="order-date ms-2">- <spring:message code="page.orderHistory.card.orderDatePrefix"/> <fmt:formatDate value="${order.time}" pattern="dd/MM/yyyy HH:mm"/></span>
                                </div>
                                <div>
                                        <span class="badge rounded-pill
                                            <c:choose>
                                                <c:when test='${order.status == "PENDING"}'>bg-warning text-dark</c:when>
                                                <c:when test='${order.status == "CONFIRMED"}'>bg-info text-dark</c:when>
                                                <c:when test='${order.status == "SHIPPED"}'>bg-primary</c:when>
                                                <c:when test='${order.status == "DELIVERED"}'>bg-success</c:when>
                                                <c:when test='${order.status == "CANCELLED"}'>bg-danger</c:when>
                                                <c:otherwise>bg-secondary</c:otherwise>
                                            </c:choose>
                                            order-status-badge">
                                            <spring:message code="page.orderHistory.status.${order.status}" text="${order.status}"/>
                                        </span>
                                </div>
                            </div>
                            <div class="order-card-body">
                                <div class="row">
                                    <div class="col-md-8">
                                            <%-- Phần này bạn có thể thêm thông tin người nhận nếu muốn --%>
                                    </div>
                                    <div class="col-md-4 text-md-end">
                                        <div class="order-summary-item">
                                            <span><spring:message code="page.orderHistory.card.totalPriceLabel"/></span>
                                            <strong><fmt:formatNumber type="number" value="${order.totalPrice}"/> đ</strong>
                                        </div>
                                    </div>
                                </div>

                                <button class="btn btn-outline-primary btn-sm btn-toggle-details mt-2" type="button" data-bs-toggle="collapse"
                                        data-bs-target="#orderDetails-${order.id}" aria-expanded="false" aria-controls="orderDetails-${order.id}">
                                    <spring:message code="page.orderHistory.card.button.viewDetails"/> <i class="fas fa-chevron-down ms-1"></i>
                                </button>

                                <div class="collapse mt-3" id="orderDetails-${order.id}">
                                    <h6 class="mb-2"><spring:message code="page.orderHistory.card.productDetailsTitle"/></h6>
                                    <div class="table-responsive">
                                        <table class="table table-sm order-details-table">
                                            <thead>
                                            <tr>
                                                <th style="width: 10%;"><spring:message code="page.orderHistory.table.header.image"/></th>
                                                <th style="width: 40%;"><spring:message code="page.orderHistory.table.header.productName"/></th>
                                                <th class="text-center" style="width: 15%;"><spring:message code="page.orderHistory.table.header.quantity"/></th>
                                                <th class="text-end" style="width: 15%;"><spring:message code="page.orderHistory.table.header.unitPrice"/></th>
                                                <th class="text-end" style="width: 20%;"><spring:message code="page.orderHistory.table.header.subtotal"/></th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach var="detail" items="${order.orderDetails}">
                                                <tr>
                                                    <td>
                                                        <img src="<c:url value='/images/product/${detail.productImage}'/>" alt="${detail.productName}"> <%-- Alt text giữ tên sản phẩm --%>
                                                    </td>
                                                    <td class="product-name-history">
                                                        <a href="<c:url value='/product/${detail.productId}'/>">${detail.productName}</a> <%-- Tên sản phẩm giữ nguyên --%>
                                                    </td>
                                                    <td class="text-center">${detail.productQuantity}</td>
                                                    <td class="text-end"><fmt:formatNumber type="number" value="${detail.price}"/> đ</td>
                                                    <td class="text-end"><fmt:formatNumber type="number" value="${detail.price * detail.productQuantity}"/> đ</td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:if>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>
<jsp:include page="../layout/common_scripts.jsp"/>
<script>
    // JavaScript giữ nguyên, không có text cần dịch trực tiếp
    $(document).ready(function () {
        // ...
    });
</script>
</body>
</html>
