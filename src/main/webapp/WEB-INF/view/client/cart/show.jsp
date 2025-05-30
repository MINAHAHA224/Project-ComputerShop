
<!-- JSP Path: client/cart/show.jsp -->
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <title>Giỏ Hàng Của Bạn - 3TLap</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="Giỏ hàng, laptop, mua sắm trực tuyến, 3TLap" name="keywords">
    <meta content="Kiểm tra và quản lý các sản phẩm trong giỏ hàng của bạn tại 3TLap." name="description">

    <jsp:include page="../layout/common_head_links.jsp"/>
    <style>
        .cart-page-header {
            background: linear-gradient(rgba(0,0,0,0.55), rgba(0,0,0,0.55)), url('<c:url value="/client/img/cart-banner.jpg"/>');
            background-position: center center;
            background-repeat: no-repeat;
            background-size: cover;
        }
        .table-cart th, .table-cart td {
            vertical-align: middle;
        }
        .table-cart .product-thumbnail img {
            width: 80px;
            height: 80px;
            object-fit: contain;
            border-radius: 0.25rem;
            border: 1px solid var(--border-color);
        }
        .table-cart .product-name a {
            color: var(--text-color);
            font-weight: 500;
            text-decoration: none;
        }
        .table-cart .product-name a:hover {
            color: var(--primary-color);
        }
        .table-cart .quantity-input-group .form-control {
            max-width: 55px;
            text-align: center;
            border-left: 0;
            border-right: 0;
            box-shadow: none !important;
            background-color: var(--white-color);
        }
        .table-cart .quantity-input-group .btn {
            border-color: var(--border-color);
            background-color: var(--light-bg-color);
            min-width: 38px;
        }
        .table-cart .btn-remove-product {
            color: var(--danger-color);
            background: none;
            border: none;
            padding: 0.5rem;
        }
        .table-cart .btn-remove-product:hover {
            color: darken(var(--danger-color), 10%);
        }
        .cart-summary {
            background-color: var(--light-bg-color);
            padding: 1.5rem;
            border-radius: 0.5rem;
        }
        .cart-summary h4 {
            font-family: var(--font-primary);
            font-weight: 600;
            color: var(--primary-color);
            margin-bottom: 1.5rem;
            border-bottom: 1px solid var(--border-color);
            padding-bottom: 0.75rem;
        }
        .cart-summary .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.75rem;
            font-size: 0.95rem;
        }
        .cart-summary .summary-item span:first-child {
            color: var(--text-muted-color);
        }
        .cart-summary .summary-item span:last-child {
            font-weight: 500;
            color: var(--text-color);
        }
        .cart-summary .summary-total {
            border-top: 1px solid var(--border-color);
            padding-top: 1rem;
            margin-top: 1rem;
        }
        .cart-summary .summary-total span:last-child {
            font-size: 1.2rem;
            font-weight: 700;
            color: var(--primary-color);
        }
        .cart-actions .btn {
            font-size: 0.95rem;
            font-weight: 500;
            padding: 0.75rem 1.5rem;
        }
    </style>
</head>

<body>
    <div id="spinner"
         class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center">
        <div class="spinner-grow text-primary" role="status"></div>
    </div>

    <jsp:include page="../layout/header.jsp"/>

    <div class="container-fluid page-header cart-page-header py-5">
        <h1 class="text-center text-white display-6">Giỏ Hàng Của Bạn</h1>
        <ol class="breadcrumb justify-content-center mb-0">
            <li class="breadcrumb-item"><a href="<c:url value='/home'/>">Trang Chủ</a></li>
            <li class="breadcrumb-item active text-white">Giỏ Hàng</li>
        </ol>
    </div>

    <div class="container-fluid py-5">
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

            <c:choose>
                <c:when test="${empty cartDetails}">
                    <div class="text-center py-5">
                        <i class="fas fa-shopping-cart fa-5x text-muted mb-3"></i>
                        <h3 class="mb-3">Giỏ hàng của bạn đang trống!</h3>
                        <p class="text-muted mb-4">Hãy khám phá các sản phẩm tuyệt vời của chúng tôi.</p>
                        <a href="<c:url value='/products'/>" class="btn btn-primary rounded-pill py-3 px-5">Tiếp Tục Mua Sắm</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <form:form action="/confirm-checkout" method="post" modelAttribute="cartDetailsListDTO">
                        <div class="table-responsive">
                            <table class="table table-hover table-cart">
                                <thead>
                                    <tr>
                                        <th scope="col" style="width: 15%;">Sản phẩm</th>
                                        <th scope="col" style="width: 30%;">Tên</th>
                                        <th scope="col" style="width: 15%;">Giá</th>
                                        <th scope="col" class="text-center" style="width: 15%;">Số lượng</th>
                                        <th scope="col" class="text-end" style="width: 15%;">Thành tiền</th>
                                        <th scope="col" class="text-center" style="width: 10%;">Xóa</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="cartDetail" items="${cartDetails}" varStatus="status">
                                        <form:hidden path="cartDetailOne[${status.index}].id" value="${cartDetail.id}" />

                                        <tr>
                                            <td class="product-thumbnail">
                                                <a href="<c:url value='/product/${cartDetail.productId}'/>">
                                                <img src="<c:url value='/images/product/${cartDetail.productImage}'/>"
                                                     alt="${cartDetail.productName}">
                                                </a>
                                            </td>
                                            <td class="product-name">
                                                <a href="<c:url value='/product/${cartDetail.productId}'/>">
                                                    ${cartDetail.productName}
                                                </a>
                                            </td>
                                            <td>
                                                <p class="mb-0"><fmt:formatNumber type="number" value="${cartDetail.price}"/> đ</p>
                                            </td>
                                            <td>
                                                <div class="input-group quantity-input-group justify-content-center">
                                                    <div class="input-group-btn">
                                                        <button class="btn btn-sm btn-light rounded-start border btn-minus-cart" type="button">
                                                            <i class="fa fa-minus"></i>
                                                        </button>
                                                    </div>
                                                   
                                                    <input type="text"
                                                           class="form-control form-control-sm text-center quantity-display"
                                                           value="${cartDetail.quantity}"
                                                           data-cart-detail-id="${cartDetail.id}"
                                                           data-cart-detail-price="${cartDetail.price}"
                                                           data-cart-detail-index="${status.index}"

                                                             data-cart-detail-stock="${cartDetail.stockQuantity}"

                                                           readonly>
                                                    <form:hidden path="cartDetailOne[${status.index}].quantity" value="${cartDetail.quantity}" cssClass="actual-quantity-input"/>

                                                    <div class="input-group-btn">
                                                        <button class="btn btn-sm btn-light rounded-end border btn-plus-cart" type="button">
                                                            <i class="fa fa-plus"></i>
                                                        </button>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="text-end">
                                                <p class="mb-0 item-total-price" data-item-total-id="${cartDetail.id}">
                                                    <fmt:formatNumber type="number" value="${cartDetail.price * cartDetail.quantity}"/> đ
                                                </p>
                                            </td>
                                            <td class="text-center">
                                                <form:form action="/delete-cart-product/${cartDetail.productId}" method="post" cssClass="d-inline">
                                                     <security:csrfInput />
                                                    <button type="submit" class="btn btn-remove-product" title="Xóa sản phẩm">
                                                        <i class="fas fa-trash-alt fa-lg"></i>
                                                    </button>
                                                </form:form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <div class="row mt-5">
                            <div class="col-md-6 col-lg-7 mb-4 mb-md-0">
                                <a href="<c:url value='/products'/>" class="btn btn-outline-primary rounded-pill py-3 px-5">
                                    <i class="fas fa-arrow-left me-2"></i> Tiếp tục mua sắm
                                </a>
                            </div>
                            <div class="col-md-6 col-lg-5">
                                <div class="cart-summary">
                                    <h4>Tóm Tắt Đơn Hàng</h4>
                                    <div class="summary-item">
                                        <span>Tạm tính:</span>
                                        <span id="cart-subtotal"><fmt:formatNumber type="number" value="${totalPrice}"/> đ</span>
                                    </div>
                                    <div class="summary-item">
                                        <span>Phí vận chuyển:</span>
                                        <span id="cart-shipping">Miễn phí</span>
                                    </div>
                                    <div class="summary-item summary-total">
                                        <span>Tổng cộng:</span>
                                        <span id="cart-grand-total" data-grand-total="${totalPrice}"><fmt:formatNumber type="number" value="${totalPrice}"/> đ</span>
                                    </div>
                                    <div class="d-grid mt-4 cart-actions">
                                        <button type="submit" class="btn btn-primary rounded-pill py-3">
                                            Tiến Hành Thanh Toán <i class="fas fa-arrow-right ms-2"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form:form>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <jsp:include page="../layout/footer.jsp"/>
    <jsp:include page="../layout/common_scripts.jsp"/>
    <script>
    $(document).ready(function () {
        function updateCartItem(inputElement, newQuantity) {
            const $input = $(inputElement);
            const price = parseFloat($input.data('cart-detail-price'));
            const itemId = $input.data('cart-detail-id');
            const itemIndex = $input.data('cart-detail-index');

            if (isNaN(price) || newQuantity < 1) {
                return;
            }

            $input.val(newQuantity);
            $(`input[name="cartDetailOne[${itemIndex}].quantity"]`).val(newQuantity);

            const itemTotalPrice = price * newQuantity;
            $(`.item-total-price[data-item-total-id="${itemId}"]`).text(formatCurrencyVI(itemTotalPrice) + ' đ');

            updateCartTotals();
        }

        function updateCartTotals() {
            let subtotal = 0;
            $('.table-cart tbody tr').each(function () {
                const $row = $(this);
                const quantityInput = $row.find('.quantity-display');
                if (quantityInput.length) {
                    const price = parseFloat(quantityInput.data('cart-detail-price'));
                    const quantity = parseInt(quantityInput.val());
                    if (!isNaN(price) && !isNaN(quantity)) {
                        subtotal += price * quantity;
                    }
                }
            });

            $('#cart-subtotal').text(formatCurrencyVI(subtotal) + ' đ');
            const shippingCost = 0;
            $('#cart-shipping').text(shippingCost > 0 ? formatCurrencyVI(shippingCost) + ' đ' : 'Miễn phí');

            const grandTotal = subtotal + shippingCost;
            $('#cart-grand-total').text(formatCurrencyVI(grandTotal) + ' đ');
            $('#cart-grand-total').attr('data-grand-total', grandTotal);
        }

        function formatCurrencyVI(number) {
            return new Intl.NumberFormat('vi-VN').format(number);
        }

        $('.table-cart').on('click', '.btn-minus-cart', function () {
            const $input = $(this).closest('.quantity-input-group').find('.quantity-display');
            let currentValue = parseInt($input.val());
            if (currentValue > 1) {
                updateCartItem($input, currentValue - 1);
            }
        });

        $('.table-cart').on('click', '.btn-plus-cart', function () {
            const $input = $(this).closest('.quantity-input-group').find('.quantity-display');
            let currentValue = parseInt($input.val());
            // Nếu cần kiểm tra số lượng tồn kho, có thể bỏ comment dòng dưới
            const stockQuantity = parseInt($input.data('cart-detail-stock'));
            if (currentValue < stockQuantity) {
                updateCartItem($input, currentValue + 1);
            }
           
        });

        updateCartTotals();
    });
    </script>
</body>
</html>
