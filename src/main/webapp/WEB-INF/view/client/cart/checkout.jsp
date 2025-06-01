<%--src/main/webapp/WEB-INF/view/client/cart/checkout.jsp--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <title><spring:message code="page.checkout.meta.title"/></title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="<spring:message code="page.checkout.meta.keywords"/>" name="keywords">
    <meta content="<spring:message code="page.checkout.meta.description"/>" name="description">
    <jsp:include page="../layout/common_head_links.jsp"/>
    <style>
        .checkout-page-header {
            background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), url('<c:url value="/client/img/checkout-banner.jpg"/>');
            background-position: center center;
            background-repeat: no-repeat;
            background-size: cover;
        }
        .checkout-section {
            padding: 2rem;
            background-color: #fff;
            border-radius: 0.5rem;
            box-shadow: 0 0.25rem 1rem rgba(0,0,0,.075);
            margin-bottom: 2rem;
        }
        .checkout-section h4, .checkout-section h5 {
            font-family: var(--font-primary);
            font-weight: 600;
            color: var(--primary-color);
            margin-bottom: 1.5rem;
            padding-bottom: 0.75rem;
            border-bottom: 2px solid var(--primary-color);
        }
        .checkout-section .form-label {
            font-weight: 500;
            color: var(--text-muted-color);
            margin-bottom: 0.3rem;
        }
        .checkout-section .form-control,
        .checkout-section .form-select {
            border-radius: 0.375rem;
            border-color: var(--border-color);
            padding: 0.75rem 1rem;
        }
        .checkout-section .form-control:focus,
        .checkout-section .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(var(--primary-rgb), 0.25);
        }
         .checkout-section .form-check-input:checked {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        .checkout-section .form-check-label {
            font-weight: 500;
        }
        .order-summary-checkout {
            background-color: var(--light-bg-color);
            padding: 1.5rem;
            border-radius: 0.5rem;
            border: 1px solid var(--border-color);
        }
        .order-summary-checkout h5 {
            border-bottom: 1px solid var(--border-color);
            color: var(--text-color);
        }
        .order-summary-checkout .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.75rem;
            font-size: 0.9rem;
        }
         .order-summary-checkout .summary-item .product-name-summary {
            max-width: 200px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .order-summary-checkout .summary-total {
            border-top: 1px solid var(--border-color);
            padding-top: 1rem;
            margin-top: 1rem;
        }
        .order-summary-checkout .summary-total span:last-child {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--primary-color);
        }
        .btn-place-order {
            font-size: 1.1rem;
            font-weight: 600;
            padding: 0.85rem 2rem;
        }
        .form-error {
            color: #dc3545;
            font-size: 0.875em;
            margin-top: 0.25rem;
            display: block;
        }
    </style>
</head>

<body>
<div id="spinner"
     class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center">
    <div class="spinner-grow text-primary" role="status"></div>

</div>

<jsp:include page="../layout/header.jsp"/>

<div class="container-fluid page-header checkout-page-header py-5">
    <h1 class="text-center text-white display-6"><spring:message code="page.checkout.header.title"/></h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="<c:url value='/'/>"><spring:message code="page.checkout.breadcrumb.home"/></a></li>
        <li class="breadcrumb-item"><a href="<c:url value='/cart'/>"><spring:message code="page.checkout.breadcrumb.cart"/></a></li>
        <li class="breadcrumb-item active text-white"><spring:message code="page.checkout.breadcrumb.checkout"/></li>
    </ol>
</div>

<div class="container-fluid py-5">
    <div class="container py-5">
        <c:if test="${not empty messageError}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${messageError} <%-- Nếu messageError là key, dùng <spring:message code="${messageError}"/> --%>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <form:form action="/place-order" method="post" modelAttribute="infoOrderRqDTO">
            <security:csrfInput />
            <div class="row g-5">
                <div class="col-md-12 col-lg-6 col-xl-7">
                    <div class="checkout-section">
                        <h4><spring:message code="page.checkout.shippingInfo.title"/></h4>
                        <div class="row">
                            <div class="col-12 mb-3">
                                <label for="receiverName" class="form-label"><spring:message code="page.checkout.shippingInfo.label.receiverName"/> <span class="text-danger"><spring:message code="page.checkout.shippingInfo.requiredMark"/></span></label>
                                <form:input path="receiverName" cssClass="form-control" id="receiverName"/>
                                <form:errors path="receiverName" cssClass="form-error"/>
                            </div>
                            <div class="col-12 mb-3">
                                <label for="receiverAddressCheckout" class="form-label"><spring:message code="page.checkout.shippingInfo.label.receiverAddress"/> <span class="text-danger"><spring:message code="page.checkout.shippingInfo.requiredMark"/></span></label>
                                <div class="address-autocomplete-wrapper position-relative">
                                    <spring:message code="page.checkout.shippingInfo.placeholder.receiverAddress" var="addressPlaceholder"/>
                                    <form:input type="text"
                                                path="receiverAddress"
                                                cssClass="form-control goong-address-input"
                                                id="receiverAddressCheckout"
                                                placeholder="${addressPlaceholder}"
                                                autocomplete="off"/>
                                    <div class="dropdown-menu goong-address-suggestions w-100" aria-labelledby="receiverAddressCheckout">
                                    </div>
                                </div>
                                <form:errors path="receiverAddress" cssClass="form-error d-block"/>
                            </div>
                            <div class="col-12 mb-3">
                                <label for="receiverPhone" class="form-label"><spring:message code="page.checkout.shippingInfo.label.receiverPhone"/> <span class="text-danger"><spring:message code="page.checkout.shippingInfo.requiredMark"/></span></label>
                                <form:input path="receiverPhone" cssClass="form-control" id="receiverPhone" type="tel"/>
                                <form:errors path="receiverPhone" cssClass="form-error"/>
                            </div>
                            <form:hidden path="totalPriceToSaveOrder"/>
                        </div>
                    </div>

                    <div class="checkout-section mt-4">
                        <h4><spring:message code="page.checkout.paymentMethod.title"/></h4>
                        <form:errors path="paymentMethod" cssClass="form-error mb-3"/>
                        <div class="form-check mb-3">
                            <form:radiobutton path="paymentMethod" id="paymentCod" value="COD" cssClass="form-check-input"/>
                            <label class="form-check-label" for="paymentCod">
                                <i class="fas fa-money-bill-wave me-2 text-success"></i><spring:message code="page.checkout.paymentMethod.cod"/>
                            </label>
                        </div>
                        <div class="form-check mb-3">
                            <form:radiobutton path="paymentMethod" id="paymentMomo" value="MOMO" cssClass="form-check-input"/>
                            <spring:message code="page.checkout.paymentMethod.alt.momo" var="momoAlt"/>
                            <label class="form-check-label" for="paymentMomo">
                                <img src="<c:url value='/client/img/momo-icon.png'/>" alt="${momoAlt}" height="20" class="me-2"><spring:message code="page.checkout.paymentMethod.momo"/>
                            </label>
                        </div>
                        <div class="form-check">
                            <form:radiobutton path="paymentMethod" id="paymentVnpay" value="VNPAY" cssClass="form-check-input"/>
                            <spring:message code="page.checkout.paymentMethod.alt.vnpay" var="vnpayAlt"/>
                            <label class="form-check-label" for="paymentVnpay">
                                <img src="<c:url value='/client/img/vnpay-icon.png'/>" alt="${vnpayAlt}" height="20" class="me-2"><spring:message code="page.checkout.paymentMethod.vnpay"/>
                            </label>
                        </div>
                    </div>
                </div>

                <div class="col-md-12 col-lg-6 col-xl-5">
                    <div class="order-summary-checkout">
                        <h4><spring:message code="page.checkout.orderSummary.title"/></h4>
                        <c:forEach var="item" items="${cartDetails}">
                            <div class="summary-item">
                                <span class="product-name-summary" title="${item.productName}">${item.quantity} x ${item.productName}</span>
                                <span><fmt:formatNumber type="number" value="${item.price * item.quantity}"/> <spring:message code="page.checkout.orderSummary.currencySymbol"/></span>
                            </div>
                        </c:forEach>
                        <hr class="my-3">
                        <div class="summary-item">
                            <span><spring:message code="page.checkout.orderSummary.subtotal"/></span>
                            <span><fmt:formatNumber type="number" value="${totalPrice}"/> <spring:message code="page.checkout.orderSummary.currencySymbol"/></span>
                        </div>
                        <div class="summary-item">
                            <span><spring:message code="page.checkout.orderSummary.shippingFee"/></span>
                            <span><spring:message code="page.checkout.orderSummary.shippingFee.free"/></span>
                        </div>
                        <div class="summary-item summary-total">
                            <span><spring:message code="page.checkout.orderSummary.total"/></span>
                            <span><fmt:formatNumber type="number" value="${totalPrice}"/> <spring:message code="page.checkout.orderSummary.currencySymbol"/></span>
                        </div>
                        <div class="d-grid mt-4">
                            <button type="submit" class="btn btn-primary btn-lg rounded-pill btn-place-order">
                                <i class="fas fa-check-circle me-2"></i><spring:message code="page.checkout.orderSummary.button.placeOrder"/>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </form:form>
    </div>
</div>
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
<script src="<c:url value='/client/js/goong-autocomplete.js'/>"></script>
</body>
</html>
