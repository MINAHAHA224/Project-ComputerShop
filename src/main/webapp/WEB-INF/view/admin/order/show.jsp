
<!-- JSP Path: src/main/webapp/WEB-INF/view/admin/order/show.jsp -->
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
    <title>Quản Lý Đơn Hàng - 3TLap Admin</title>
    <jsp:include page="../layout/common_admin_head.jsp"/>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet"/>
    <style>
        
        .table-actions .btn { margin-right: 0.3rem; padding: 0.3rem 0.6rem; font-size: 0.8rem; }
        .table-actions .btn i { margin-right: 0; }
        .table td, .table th { vertical-align: middle; }
        .badge { font-size: 0.78rem; padding: 0.4em 0.65em; font-weight: 500; }
    </style>
</head>

<body class="sb-nav-fixed admin-body-3tlap">
    <c:set var="breadcrumbCurrentPage" value="Quản Lý Đơn Hàng" scope="request"/>
    <jsp:include page="../layout/header.jsp"/>

    <div id="layoutSidenav">
        <jsp:include page="../layout/navbar.jsp"/>
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <h1 class="main-content-title mt-4">Danh Sách Đơn Hàng</h1>
                    
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <ol class="breadcrumb mb-0 bg-transparent p-0">
                            <li class="breadcrumb-item"><a href="<c:url value='/admin'/>">Dashboard</a></li>
                            <li class="breadcrumb-item active">Đơn Hàng</li>
                        </ol>
                   
                       <a href="<c:url value='/admin/order/create'/>" class="btn btn-primary btn-sm admin-btn-create">
                            <i class="fas fa-plus me-1"></i> Tạo Đơn Hàng Mới
                        </a>
                    </div>

                    <c:if test="${not empty messageSuccess}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            ${messageSuccess}<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>
                    <c:if test="${not empty messageError}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            ${messageError}<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <div class="card mb-4 admin-table-card">
                        <div class="card-header">
                            <i class="fas fa-file-invoice-dollar me-1"></i>
                            Danh sách chi tiết đơn hàng
                        </div>
                        <div class="card-body">
                            <table id="ordersTable" class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Người Đặt/Nhận</th>
                                        <th class="text-end">Tổng Tiền</th>
                                        <th class="text-center">Trạng Thái ĐH</th>
                                        <th class="text-center">TT Thanh Toán</th>
                                        <th>Ngày Đặt</th>
                                        <th class="text-center">Hành Động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="order" items="${orders}">
                                        <tr>
                                            <td>#${order.id}</td>
                                            <td><c:out value="${order.nameUser}"/></td> 
                                            <td class="text-end"><fmt:formatNumber type="number" value="${order.totalPrice}"/> đ</td>
                                            <td class="text-center">
                                                <span class="badge 
                                                    <c:choose>
                                                        <c:when test='${order.status == "PENDING"}'>bg-warning text-dark</c:when>
                                                        <c:when test='${order.status == "CONFIRMED"}'>bg-info text-dark</c:when>
                                                        <c:when test='${order.status == "SHIPPED"}'>bg-primary</c:when>
                                                        <c:when test='${order.status == "DELIVERED"}'>bg-success</c:when>
                                                        <c:when test='${order.status == "CANCELLED"}'>bg-danger</c:when>
                                                        <c:otherwise>bg-secondary</c:otherwise>
                                                    </c:choose>
                                                ">
                                                    <c:choose>
                                                        <c:when test="${order.status == 'PENDING'}">Chờ xác nhận</c:when>
                                                        <c:when test="${order.status == 'CONFIRMED'}">Đã xác nhận</c:when>
                                                        <c:when test="${order.status == 'SHIPPED'}">Đang giao</c:when>
                                                        <c:when test="${order.status == 'DELIVERED'}">Đã giao</c:when>
                                                        <c:when test="${order.status == 'CANCELLED'}">Đã hủy</c:when>
                                                        <c:otherwise><c:out value="${order.status}"/></c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </td>
                                            <td class="text-center">
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
                                            </td>
                                            <td><fmt:formatDate value="${order.time}" pattern="dd/MM/yyyy HH:mm"/></td>
                                            <td class="text-center table-actions">
                                                <a href="<c:url value='/admin/order/${order.id}'/>" class="btn btn-info btn-sm" title="Xem chi tiết">
                                                    <i class="fas fa-eye"></i>
                                                </a>
                                                <a href="<c:url value='/admin/order/update/${order.id}'/>" class="btn btn-warning btn-sm" title="Cập nhật">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <security:authorize access="hasRole('ADMIN')">
                                                    <button type="button" class="btn btn-danger btn-sm" title="Xóa"
                                                            data-bs-toggle="modal" data-bs-target="#deleteOrderModal"
                                                            data-order-id="${order.id}" data-order-name="Đơn hàng #${order.id}">
                                                        <i class="fas fa-trash-alt"></i>
                                                    </button>
                                                </security:authorize>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </main>
            <jsp:include page="../layout/footer.jsp"/>
        </div>
    </div>

    <!-- Delete Order Confirmation Modal -->
    <security:authorize access="hasRole('ADMIN')">
        <div class="modal fade" id="deleteOrderModal" tabindex="-1" aria-labelledby="deleteOrderModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content admin-modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="deleteOrderModalLabel">Xác Nhận Xóa Đơn Hàng</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        Bạn có chắc chắn muốn xóa <strong id="orderNameToDelete"></strong>?
                        <br/>Hành động này sẽ xóa vĩnh viễn đơn hàng.
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Hủy Bỏ</button>
                        <form id="deleteOrderForm" method="get" action=""> <%-- Action sẽ được JS cập nhật --%>
                             <%-- <security:csrfInput/> Nếu method là POST --%>
                            <button type="submit" class="btn btn-danger">Xác Nhận Xóa</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </security:authorize>

    <jsp:include page="../layout/common_admin_scripts.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const ordersTable = document.getElementById('ordersTable');
            if (ordersTable) {
                new simpleDatatables.DataTable(ordersTable, {
                    perPage: 10,
                    perPageSelect: [5, 10, 25, 50],
                    labels: {
                        placeholder: "Tìm kiếm trong đơn hàng...",
                        perPage: "{select} đơn hàng mỗi trang",
                        noRows: "Không tìm thấy đơn hàng nào",
                        info: "Hiển thị {start} đến {end} của {rows} đơn hàng",
                    }
                });
            }

            var deleteOrderModal = document.getElementById('deleteOrderModal');
            if (deleteOrderModal) {
                deleteOrderModal.addEventListener('show.bs.modal', function (event) {
                    var button = event.relatedTarget;
                    var orderId = button.getAttribute('data-order-id');
                    var orderName = button.getAttribute('data-order-name');
                    
                    deleteOrderModal.querySelector('#orderNameToDelete').textContent = orderName;
                    deleteOrderModal.querySelector('#deleteOrderForm').action = '<c:url value="/admin/order/delete"/>/' + orderId;
                });
            }
        });
    </script>
</body>
</html>