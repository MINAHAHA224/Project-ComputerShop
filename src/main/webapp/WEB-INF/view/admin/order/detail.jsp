
<!-- JSP Path: admin/order/detail.jsp -->
 <%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <title>Chi Tiết Đơn Hàng #${order.id} - 3TLap Admin</title>
    <jsp:include page="../layout/common_admin_head.jsp"/>
    <style>
        .order-detail-card .card-header h4 { margin-bottom: 0; }
        .order-info-section, .customer-info-section, .products-section {
            margin-bottom: 2rem;
        }
        .section-title-admin-detail {
            font-family: var(--admin-font-primary);
            font-weight: 500;
            font-size: 1.1rem;
            color: var(--current-admin-text-primary);
            padding-bottom: 0.5rem;
            border-bottom: 1px solid var(--current-admin-divider-color);
            margin-bottom: 1rem;
        }
        .info-pair { display: flex; margin-bottom: 0.6rem; font-size: 0.95rem; }
        .info-pair strong { 
            color: var(--current-admin-text-secondary); 
            min-width: 180px;
            font-weight: 500;
        }
        .info-pair span { color: var(--current-admin-text-primary); }
        
        .product-detail-table img {
            width: 50px; height: 50px; object-fit: contain; 
            border-radius: 0.25rem; border: 1px solid var(--current-admin-border-color);
            background-color: var(--white-color);
        }
        body.theme-dark .product-detail-table img {
             background-color: var(--current-admin-card-bg);
        }
        .product-detail-table th, .product-detail-table td { vertical-align: middle; }
        .table-actions .btn { margin-right: 0.3rem; padding: 0.3rem 0.6rem; font-size: 0.8rem; }
    </style>
</head>

<body class="sb-nav-fixed admin-body-3tlap">
    <%-- Giả sử controller truyền vào một đối tượng 'order' (OrderRpDTO hoặc OrderEntity) 
         và 'orderDetails' --%>
    <c:set var="breadcrumbCurrentPage" value="Chi Tiết Đơn Hàng #${order.id}" scope="request"/>
    <jsp:include page="../layout/header.jsp"/>

    <div id="layoutSidenav">
        <jsp:include page="../layout/navbar.jsp"/>
        <div id="layoutSidenav_content">
            <main>
              <%-- Trang này cần đối tượng order (chứa thông tin chung của đơn hàng, bao gồm cả thông tin user và receiver) và orderDetails. --%>

                <div class="container-fluid px-4">
                    <h1 class="main-content-title mt-4">Chi Tiết Đơn Hàng #${order.id}</h1>
                    
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <ol class="breadcrumb mb-0 bg-transparent p-0">
                            <li class="breadcrumb-item"><a href="<c:url value='/admin'/>">Dashboard</a></li>
                            <li class="breadcrumb-item"><a href="<c:url value='/admin/order'/>">Đơn Hàng</a></li>
                            <li class="breadcrumb-item active">Chi Tiết Đơn Hàng</li>
                        </ol>
                         <div>
                            <a href="<c:url value='/admin/order/update/${order.id}'/>" class="btn btn-warning btn-sm admin-btn-action">
                                <i class="fas fa-edit me-1"></i> Sửa Đơn Hàng
                            </a>
                            <a href="<c:url value='/admin/order'/>" class="btn btn-outline-secondary btn-sm admin-btn-action ms-2">
                                <i class="fas fa-arrow-left me-1"></i> Quay Lại Danh Sách
                            </a>
                        </div>
                    </div>

                    <div class="card admin-detail-card order-detail-card">
                        <div class="card-header">
                            <h4>Thông Tin Chung Đơn Hàng</h4>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-lg-6 order-info-section">
                                    <h5 class="section-title-admin-detail">Chi Tiết Đơn Hàng</h5>
                                    <div class="info-pair"><strong>Mã đơn hàng:</strong> <span>#${order.id}</span></div>
                                    <div class="info-pair"><strong>Ngày đặt:</strong> <span><fmt:formatDate value="${order.time}" pattern="dd/MM/yyyy HH:mm:ss"/></span></div>
                                    <div class="info-pair"><strong>Tổng tiền:</strong> <span class="fw-bold text-danger"><fmt:formatNumber type="number" value="${order.totalPrice}"/> đ</span></div>
                                    <div class="info-pair"><strong>Trạng thái đơn hàng:</strong> 
                                        <span>
                                             <span class="badge 
                                                <c:choose>
                                                    <c:when test='${order.status == "PENDING"}'>bg-warning text-dark</c:when>
                                                    <c:when test='${order.status == "CONFIRMED"}'>bg-info text-dark</c:when>
                                                    <c:when test='${order.status == "SHIPPED"}'>bg-primary</c:when>
                                                    <c:when test='${order.status == "DELIVERED"}'>bg-success</c:when>
                                                    <c:when test='${order.status == "CANCELLED"}'>bg-danger</c:when>
                                                    <c:otherwise>bg-secondary</c:otherwise>
                                                </c:choose> 
                                            order-status-badge">
                                                <c:choose>
                                                    <c:when test="${order.status == 'PENDING'}">Chờ xác nhận</c:when>
                                                    <c:when test="${order.status == 'CONFIRMED'}">Đã xác nhận</c:when>
                                                    <c:when test="${order.status == 'SHIPPED'}">Đang giao</c:when>
                                                    <c:when test="${order.status == 'DELIVERED'}">Đã giao</c:when>
                                                    <c:when test="${order.status == 'CANCELLED'}">Đã hủy</c:when>
                                                    <c:otherwise><c:out value="${order.status}"/></c:otherwise>
                                                </c:choose>
                                            </span>
                                        </span>
                                    </div>
                                    <div class="info-pair"><strong>Phương thức thanh toán:</strong> <span>${order.typePayment}</span></div>
                                    <div class="info-pair"><strong>Trạng thái thanh toán:</strong> 
                                        <span>
                                            <span class="badge 
                                                <c:choose>
                                                    <c:when test='${order.statusPayment == "UNPAID"}'>bg-warning text-dark</c:when>
                                                    <c:when test='${order.statusPayment == "PAID"}'>bg-success</c:when>
                                                    <c:when test='${order.statusPayment == "REFUNDED"}'>bg-info text-dark</c:when>
                                                    <c:when test='${order.statusPayment == "FAILED"}'>bg-danger</c:when>
                                                    <c:otherwise>bg-secondary</c:otherwise>
                                                </c:choose>
                                            ">
                                                 <c:choose>
                                                    <c:when test="${order.statusPayment == 'UNPAID'}">Chưa TT</c:when>
                                                    <c:when test="${order.statusPayment == 'PAID'}">Đã TT</c:when>
                                                    <c:when test="${order.statusPayment == 'REFUNDED'}">Đã Hoàn Tiền</c:when>
                                                    <c:when test="${order.statusPayment == 'FAILED'}">Thất Bại</c:when>
                                                    <c:otherwise><c:out value="${order.statusPayment}"/></c:otherwise>
                                                </c:choose>
                                            </span>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-lg-6 customer-info-section">
                                    <h5 class="section-title-admin-detail">Thông Tin Người Nhận & Đặt Hàng</h5>
                                    <div class="info-pair"><strong>Tên người nhận:</strong> <span><c:out value="${order.receiverName}"/></span></div>
                                    <div class="info-pair"><strong>Điện thoại người nhận:</strong> <span><c:out value="${order.receiverPhone}"/></span></div>
                                    <div class="info-pair"><strong>Địa chỉ người nhận:</strong> <span><c:out value="${order.receiverAddress}"/></span></div>
                                    <hr style="border-color: var(--current-admin-divider-color);">
                                    <div class="info-pair"><strong>Người đặt hàng:</strong> <span><c:out value="${order.user.fullName}"/></span></div>
                                    <div class="info-pair"><strong>Email người đặt:</strong> <span><c:out value="${order.user.email}"/></span></div>
                                </div>
                            </div>

                            <div class="products-section mt-3">
                                <h5 class="section-title-admin-detail">Các Sản Phẩm Trong Đơn</h5>
                                <div class="table-responsive">
                                    <table class="table table-bordered table-hover product-detail-table">
                                        <thead>
                                            <tr>
                                                <th style="width: 10%;">Ảnh</th>
                                                <th>Tên Sản Phẩm</th>
                                                <th class="text-end">Đơn Giá</th>
                                                <th class="text-center">Số Lượng</th>
                                                <th class="text-end">Thành Tiền</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="detail" items="${orderDetails}">
                                                <tr>
                                                    <td>
                                                        <img src="<c:url value='/images/product/${detail.productImage}'/>" alt="${detail.productName}">
                                                    </td>
                                                    <td><c:out value="${detail.productName}"/></td>
                                                    <td class="text-end"><fmt:formatNumber type="number" value="${detail.price}"/> đ</td>
                                                    <td class="text-center">${detail.productQuantity}</td>
                                                    <td class="text-end"><fmt:formatNumber type="number" value="${detail.price * detail.productQuantity}"/> đ</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                        <tfoot>
                                            <tr>
                                                <td colspan="4" class="text-end fw-bold">Tổng Cộng (chưa gồm phí ship nếu có):</td>
                                                <td class="text-end fw-bold"><fmt:formatNumber type="number" value="${order.totalPrice}"/> đ</td>
                                            </tr>
                                        </tfoot>
                                    </table>
                                </div>
                            </div>
                            <div class="actions-bar text-end mt-4">
                                <a href="<c:url value='/admin/order/update/${order.id}'/>" class="btn btn-warning admin-btn-action">
                                    <i class="fas fa-edit me-1"></i> Sửa Đơn Hàng
                                </a>
                                <security:authorize access="hasRole('ADMIN')">
                                <button type="button" class="btn btn-danger admin-btn-action ms-2" 
                                        data-bs-toggle="modal" data-bs-target="#deleteOrderDetailModal"
                                        data-order-id="${order.id}" data-order-name="Đơn hàng #${order.id}">
                                    <i class="fas fa-trash-alt me-1"></i> Xóa Đơn Hàng
                                </button>
                                </security:authorize>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
            <jsp:include page="../layout/footer.jsp"/>
        </div>
    </div>

     <!-- Modal xóa đơn hàng -->
    <security:authorize access="hasRole('ADMIN')">
        <div class="modal fade" id="deleteOrderDetailModal" tabindex="-1" aria-labelledby="deleteOrderDetailModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content admin-modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="deleteOrderDetailModalLabel">Xác Nhận Xóa Đơn Hàng</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        Bạn có chắc chắn muốn xóa <strong id="orderNameToDeleteDetail"></strong>?
                        Hành động này sẽ xóa vĩnh viễn đơn hàng.
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Hủy Bỏ</button>
                        <form id="deleteOrderFormDetail" method="get" action="">
                            <button type="submit" class="btn btn-danger">Xác Nhận Xóa</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </security:authorize>

    <jsp:include page="../layout/common_admin_scripts.jsp"/>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var deleteOrderModalDetail = document.getElementById('deleteOrderDetailModal');
            if (deleteOrderModalDetail) {
                deleteOrderModalDetail.addEventListener('show.bs.modal', function (event) {
                    var button = event.relatedTarget;
                    var orderId = button.getAttribute('data-order-id');
                    var orderName = button.getAttribute('data-order-name');
                    
                    deleteOrderModalDetail.querySelector('#orderNameToDeleteDetail').textContent = orderName;
                    deleteOrderModalDetail.querySelector('#deleteOrderFormDetail').action = '<c:url value="/admin/order/delete"/>/' + orderId;
                });
            }
        });
    </script>
</body>
</html>
