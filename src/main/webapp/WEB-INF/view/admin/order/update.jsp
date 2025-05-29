<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="Hỏi Dân IT - Dự án laptopshop" />
    <meta name="author" content="Hỏi Dân IT" />
    <title>Update Order - Hỏi Dân IT</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>

<body class="sb-nav-fixed">
<jsp:include page="../layout/header.jsp" />
<div id="layoutSidenav">
    <jsp:include page="../layout/navbar.jsp" />
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Update Order</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="/admin/order">Orders</a></li>
                    <li class="breadcrumb-item active">Update</li>
                </ol>
                <div class="mt-5">
                    <div class="row">
                        <div class="col-md-8 col-12 mx-auto"> <%-- Mở rộng cột để chứa nhiều trường hơn --%>
                            <div class="card">
                                <div class="card-header">
                                    <h3>Order Setting</h3>
                                </div>
                                <div class="card-body">
                                    <form:form method="post" action="/admin/order/update" modelAttribute="orders">
                                        <%-- Trường ID ẩn để gửi đi khi submit, nhưng vẫn hiển thị thông tin --%>
                                        <form:input type="hidden" path="id" />

                                        <%-- Các trường không được chỉnh sửa --%>
                                        <div class="row mb-3">
                                            <div class="col-md-4">
                                                <label class="form-label">Order ID:</label>
                                                <p><strong>${orders.id}</strong></p>
                                            </div>
                                            <div class="col-md-4">
                                                <label class="form-label">Total Price:</label>
                                                <p><strong><fmt:formatNumber type="number" value="${orders.totalPrice}" /> đ</strong></p>
                                            </div>
                                            <div class="col-md-4">
                                                <label class="form-label">Payment Type:</label>
                                                <p><strong>${orders.typePayment}</strong></p>
                                            </div>
                                        </div>
                                        <hr/>

                                        <%-- Các trường có thể chỉnh sửa --%>
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label" for="receiverName">Receiver Name:</label>
                                                <form:input type="text" class="form-control" path="receiverName" id="receiverName"/>
                                                <form:errors path="receiverName" cssClass="invalid-feedback" />
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label" for="receiverPhone">Receiver Phone:</label>
                                                <form:input type="text" class="form-control" path="receiverPhone" id="receiverPhone"/>
                                                <form:errors path="receiverPhone" cssClass="invalid-feedback" />
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label" for="receiverAddress">Receiver Address:</label>
                                            <form:textarea class="form-control" path="receiverAddress" id="receiverAddress" rows="3"/>
                                            <form:errors path="receiverAddress" cssClass="invalid-feedback" />
                                        </div>

                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label" for="status">Order Status:</label>
                                                <form:select class="form-select" path="status" id="status">
                                                    <form:option value="PENDING">Chờ xác nhận</form:option>
                                                    <form:option value="CONFIRMED">Đã xác nhận đơn</form:option>
                                                    <form:option value="SHIPPED">Đã giao cho bên vận chuyển</form:option>
                                                    <form:option value="DELIVERED">Giao hàng thành công</form:option>
                                                    <form:option value="CANCELLED">Hủy đơn hàng</form:option>
                                                </form:select>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label" for="statusPayment">Payment Status:</label>
                                                <form:select class="form-select" path="statusPayment" id="statusPayment">
                                                    <form:option value="UNPAID">Chưa thanh toán</form:option>
                                                    <form:option value="PAID">Đã thanh toán</form:option>
                                                    <form:option value="REFUNDED">Đã hoàn tiền</form:option>
                                                    <form:option value="FAILED">Thanh toán thất bại</form:option>
                                                </form:select>

                                            </div>
                                        </div>

                                        <div class="col-12 mt-4">
                                            <button type="submit" class="btn btn-warning">Update Order</button>
                                            <a href="/admin/order" class="btn btn-secondary ms-2">Cancel</a>
                                        </div>
                                    </form:form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <jsp:include page="../layout/footer.jsp" />
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/js/scripts.js"></script>
</body>
</html>