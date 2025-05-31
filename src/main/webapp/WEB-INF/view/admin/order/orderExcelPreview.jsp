<%--src/main/webapp/WEB-INF/view/admin/order/orderExcelPreview.jsp--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Xem Trước - Báo Cáo Đơn Hàng - 3TLap Admin</title>
    <jsp:include page="../layout/common_admin_head.jsp"/>
    <style>
        .filter-section-preview .form-control, .filter-section-preview .form-select {
            font-size: 0.85rem;
            padding: 0.5rem 0.75rem;
        }
        .filter-section-preview .btn-filter {
            font-size: 0.85rem;
            padding: 0.5rem 1rem;
        }
    </style>
</head>
<body class="sb-nav-fixed admin-body-3tlap">
    <c:set var="breadcrumbCurrentPage" value="Xem Trước Báo Cáo Đơn Hàng" scope="request"/>
    <jsp:include page="../layout/header.jsp"/>

    <div id="layoutSidenav">
        <jsp:include page="../layout/navbar.jsp"/>
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4 preview-page-container">
                    <div class="report-header-controls">
                        <h1 class="report-title-preview">Báo Cáo Danh Sách Đơn Hàng</h1>
                        <a href="<c:url value='/admin/order'/>" class="btn btn-sm btn-outline-secondary admin-btn-action">
                            <i class="fas fa-arrow-left me-1"></i> Quay Lại DS Đơn Hàng
                        </a>
                    </div>
                     <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="<c:url value='/admin'/>">Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="<c:url value='/admin/order'/>">Đơn Hàng</a></li>
                        <li class="breadcrumb-item active">Xem Trước Báo Cáo</li>
                    </ol>

                    <div class="filter-section-preview">
                        <form action="<c:url value='/admin/order/report/excel/preview'/>" method="get" class="row gx-3 gy-2 align-items-end">
                            <div class="col-md-3">
                                <label for="startDatePreview" class="form-label">Từ ngày:</label>
                                <input type="date" id="startDatePreview" name="startDate" value="${selectedStartDate}" class="form-control">
                            </div>
                            <div class="col-md-3">
                                <label for="endDatePreview" class="form-label">Đến ngày:</label>
                                <input type="date" id="endDatePreview" name="endDate" value="${selectedEndDate}" class="form-control">
                            </div>
                            <div class="col-md-3">
                                <label for="statusFilterPreview" class="form-label">Trạng thái ĐH:</label>
                                <select name="status" id="statusFilterPreview" class="form-select">
                                    <option value="">-- Tất cả --</option>
                                    <c:forEach var="st" items="${allOrderStatuses}">
                                        <option value="${st}" ${st == selectedStatus ? 'selected' : ''}>
                                            <c:choose>
                                                <c:when test="${st == 'PENDING'}">Chờ xác nhận</c:when>
                                                <c:when test="${st == 'CONFIRMED'}">Đã xác nhận</c:when>
                                                <c:when test="${st == 'SHIPPED'}">Đang giao</c:when>
                                                <c:when test="${st == 'DELIVERED'}">Đã giao</c:when>
                                                <c:when test="${st == 'CANCELLED'}">Đã hủy</c:when>
                                                <c:otherwise><c:out value="${st}"/></c:otherwise>
                                            </c:choose>
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-auto">
                                <button type="submit" class="btn btn-primary btn-filter"><i class="fas fa-filter me-1"></i> Lọc</button>
                            </div>
                        </form>
                    </div>

                    <div class="preview-table-container">
                        <div class="report-info-preview">
                            <p class="mb-1"><strong>Người lập báo cáo:</strong> 
                                <c:out value="${not empty currentUser.fullName ? currentUser.fullName : currentUser.email}"/>
                            </p>
                            <p class="mb-0"><strong>Ngày in:</strong> <c:out value="${printDate}"/></p>
                            <c:set var="filtersAppliedPreview" value=""/>
                            <c:if test="${not empty selectedStartDate}"><c:set var="filtersAppliedPreview" value="${filtersAppliedPreview} Từ ${selectedStartDate}"/></c:if>
                            <c:if test="${not empty selectedEndDate}"><c:set var="filtersAppliedPreview" value="${filtersAppliedPreview}${not empty filtersAppliedPreview ? ',' : ''} Đến ${selectedEndDate}"/></c:if>
                            <c:if test="${not empty selectedStatus}"><c:set var="filtersAppliedPreview" value="${filtersAppliedPreview}${not empty filtersAppliedPreview ? ',' : ''} TT: ${selectedStatus}"/></c:if>
                            <c:if test="${not empty filtersAppliedPreview}"><p class="mb-0 mt-1"><strong>Bộ lọc:</strong> <span class="badge bg-secondary">${filtersAppliedPreview}</span></p></c:if>
                        </div>

                        <c:if test="${not empty message}"> <div class="alert alert-info alert-profile my-3">${message}</div></c:if>
                        <c:if test="${not empty error_message}"> <div class="alert alert-danger alert-profile my-3">${error_message}</div></c:if>

                        <c:if test="${not empty listOrders}">
                            <div class="table-responsive">
                                <table class="table preview-table table-sm">
                                    <thead>
                                        <tr>
                                            <th>STT</th>
                                            <th>Mã ĐH</th>
                                            <th>Ngày Đặt</th>
                                            <th>Khách Hàng</th>
                                            <th>Người Nhận</th>
                                            <th class="text-end">Tổng Tiền</th>
                                            <th class="text-center">TT ĐH</th>
                                            <th class="text-center">TTTT</th>
                                            <th>Chi Tiết SP</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="order" items="${listOrders}" varStatus="status">
                                            <tr>
                                                <td class="center">${status.count}</td>
                                                <td class="center">#${order.id}</td>
                                                <td><fmt:formatDate value="${order.orderTime}" pattern="dd/MM/yy HH:mm"/></td>
                                                <td><c:out value="${order.customerFullName}"/> <br/><small class="text-muted"><c:out value="${order.customerEmail}"/></small></td>
                                                <td><c:out value="${order.receiverName}"/> <br/><small class="text-muted"><c:out value="${order.receiverPhone}"/></small></td>
                                                <td class="number"><fmt:formatNumber value="${order.totalPrice}" type="number" pattern="#,##0"/> đ</td>
                                                <td class="text-center">
                                                    <span class="badge <c:choose><c:when test='${order.orderStatus == "PENDING"}'>bg-warning text-dark</c:when><c:when test='${order.orderStatus == "CONFIRMED"}'>bg-info text-dark</c:when><c:when test='${order.orderStatus == "SHIPPED"}'>bg-primary</c:when><c:when test='${order.orderStatus == "DELIVERED"}'>bg-success</c:when><c:when test='${order.orderStatus == "CANCELLED"}'>bg-danger</c:when><c:otherwise>bg-secondary</c:otherwise></c:choose> order-status-badge">
                                                        <c:out value="${order.orderStatus}"/>
                                                    </span>
                                                </td>
                                                <td class="text-center">
                                                    <span class="badge <c:choose><c:when test='${order.paymentStatus == "UNPAID"}'>bg-warning text-dark</c:when><c:when test='${order.paymentStatus == "PAID"}'>bg-success</c:when><c:otherwise>bg-secondary</c:otherwise></c:choose> order-status-badge">
                                                        <c:out value="${order.paymentStatus}"/>
                                                    </span>
                                                </td>
                                                <td style="font-size: 0.8em; white-space: pre-wrap; max-width: 250px;">${order.productDetails}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <div class="action-buttons-preview">
                                <c:url var="downloadOrderUrl" value="/admin/order/report/excel/download">
                                    <c:if test="${not empty selectedStartDate}"><c:param name="startDate" value="${selectedStartDate}"/></c:if>
                                    <c:if test="${not empty selectedEndDate}"><c:param name="endDate" value="${selectedEndDate}"/></c:if>
                                    <c:if test="${not empty selectedStatus}"><c:param name="status" value="${selectedStatus}"/></c:if>
                                </c:url>
                                <a href="${downloadOrderUrl}" class="btn btn-success"><i class="fas fa-file-excel me-1"></i> Tải xuống Excel</a>
                            </div>
                        </c:if>
                        <c:if test="${empty listOrders && empty message && empty error_message}">
                            <div class="alert alert-warning alert-profile my-3">Không có dữ liệu đơn hàng để hiển thị với bộ lọc hiện tại.</div>
                        </c:if>
                    </div>
                </div>
            </main>
            <jsp:include page="../layout/footer.jsp"/>
        </div>
    </div>
    <jsp:include page="../layout/common_admin_scripts.jsp"/>
</body>
</html>
