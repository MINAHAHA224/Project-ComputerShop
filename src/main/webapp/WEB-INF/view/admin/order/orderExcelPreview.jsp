<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xem Trước - Danh Sách Đơn Hàng</title>
    <link href="<c:url value='/css/styles.css'/>" rel="stylesheet" /> <%-- Path CSS admin --%>
    <style>
        body { font-family: Arial, sans-serif; }
        .preview-page-container { padding: 20px; }
        .preview-container { border: 1px solid #ccc; padding: 20px; background-color: #f9f9f9; margin-top: 20px; }
        .report-title { font-size: 20px; font-weight: bold; text-align: center; margin-bottom: 20px; }
        .report-info { margin-bottom: 15px; }
        .report-info span { font-weight: bold; }
        .preview-table { width: 100%; border-collapse: collapse; margin-top: 20px; font-size: 0.85em; /* Smaller font for more columns */ }
        .preview-table th, .preview-table td { border: 1px solid #ddd; padding: 5px; text-align: left; vertical-align: middle; }
        .preview-table th { background-color: #e9e9e9; font-weight: bold; text-align: center; }
        .preview-table td.center { text-align: center; }
        .preview-table td.number { text-align: right; }
        .action-buttons { margin-top: 20px; text-align: right; }
        .btn { padding: 10px 15px; color: white; text-decoration: none; border-radius: 4px; border: none; cursor: pointer; margin-left: 10px; }
        .btn-download { background-color: #28a745; }
        .btn-back { background-color: #6c757d; }
        .btn-filter { background-color: #007bff; }
        .filter-section { margin-bottom: 20px; padding: 15px; background-color: #f0f0f0; border: 1px solid #ddd; border-radius: 5px; display: flex; flex-wrap: wrap; gap: 15px; align-items: flex-end; }
        .filter-group { display: flex; flex-direction: column; }
        .filter-group label { margin-bottom: 5px; font-weight: bold; }
        .filter-group input[type="date"], .filter-group select { padding: 8px; border-radius: 4px; border: 1px solid #ccc; }
    </style>
</head>
<body>
<jsp:include page="../layout/header.jsp" />
<div id="layoutSidenav">
    <jsp:include page="../layout/navbar.jsp" />
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4 preview-page-container">
                <h1 class="mt-4">Xem Trước Báo Cáo Đơn Hàng</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="<c:url value='/admin/dashboard'/>">Dashboard</a></li>
                    <li class="breadcrumb-item active">Xem Trước Báo Cáo Đơn Hàng</li>
                </ol>

                <div class="filter-section">
                    <form action="<c:url value='/admin/order/report/excel/preview'/>" method="get" style="display: contents;">
                        <div class="filter-group">
                            <label for="startDate">Từ ngày:</label>
                            <input type="date" id="startDate" name="startDate" value="${selectedStartDate}" class="form-control">
                        </div>
                        <div class="filter-group">
                            <label for="endDate">Đến ngày:</label>
                            <input type="date" id="endDate" name="endDate" value="${selectedEndDate}" class="form-control">
                        </div>
                        <div class="filter-group">
                            <label for="statusFilter">Trạng thái ĐH:</label>
                            <select name="status" id="statusFilter" class="form-select">
                                <option value="">-- Tất cả --</option>
<%--                                <c:forEach var="st" items="${allOrderStatuses}">--%>
<%--                                    <option value="${st}" ${st == selectedStatus ? 'selected' : ''}>--%>
<%--                                        <c:out value="${st}"/>--%>
<%--                                    </option>--%>
<%--                                </c:forEach>--%>

                                <c:forEach var="st" items="${allOrderStatuses}">
                                    <option value="${st}" ${st == selectedStatus ? 'selected' : ''}>
                                        <c:choose>
                                            <c:when test="${st == 'PENDING'}">Chờ xác nhận</c:when>
                                            <c:when test="${st == 'CONFIRMED'}">Đã xác nhận đơn</c:when>
                                            <c:when test="${st == 'SHIPPED'}">Đã giao cho bên vận chuyển</c:when>
                                            <c:when test="${st == 'DELIVERED'}">Giao hàng thành công</c:when>
                                            <c:when test="${st == 'CANCELLED'}">Hủy đơn hàng</c:when>
                                            <c:otherwise>${st}</c:otherwise>
                                        </c:choose>
                                    </option>
                                </c:forEach>
                            </select>


                        </div>
                        <button type="submit" class="btn btn-filter align-self-end">Lọc</button>
                    </form>
                </div>

                <div class="preview-container">
                    <div class="report-title">
                        DANH SÁCH ĐƠN HÀNG
                        <c:set var="filtersApplied" value=""/>
                        <c:if test="${not empty selectedStartDate}"><c:set var="filtersApplied" value="${filtersApplied} Từ ${selectedStartDate}"/></c:if>
                        <c:if test="${not empty selectedEndDate}"><c:set var="filtersApplied" value="${filtersApplied}${not empty filtersApplied ? ',' : ''} Đến ${selectedEndDate}"/></c:if>
                        <c:if test="${not empty selectedStatus}"><c:set var="filtersApplied" value="${filtersApplied}${not empty filtersApplied ? ',' : ''} TT: ${selectedStatus}"/></c:if>
                        <c:if test="${not empty filtersApplied}"> (${filtersApplied})</c:if>
                    </div>

                    <div class="report-info">
                        Người lập báo cáo:
                        <span>
                                <c:choose>
                                    <c:when test="${not empty currentUser.fullName}"><c:out value="${currentUser.fullName}"/></c:when>
                                    <c:otherwise><c:out value="${currentUser.email}"/></c:otherwise>
                                </c:choose>
                            </span>
                    </div>
                    <div class="report-info">
                        Ngày in: <span><c:out value="${printDate}"/></span>
                    </div>

                    <c:if test="${not empty message}">
                        <p style="color:blue; text-align: center;">${message}</p>
                    </c:if>
                    <c:if test="${not empty error_message}">
                        <p style="color:red; text-align: center;">${error_message}</p>
                    </c:if>

                    <c:if test="${not empty listOrders}">
                        <table class="preview-table">
                            <thead>
                            <tr>
                                <th>STT</th>
                                <th>Mã ĐH</th>
                                <th>Ngày Đặt</th>
                                <th>Khách Hàng</th>
                                <th>Email KH</th>
                                <th>Người Nhận</th>
                                <th>SĐT Nhận</th>
                                <th>Địa Chỉ Giao</th>
                                <th>Tổng Tiền</th>
                                <th>TT ĐH</th>
                                <th>HTTT</th>
                                <th>TTTT</th>
                                <th>Chi Tiết SP</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="order" items="${listOrders}" varStatus="status">
                                <tr>
                                    <td class="center">${status.count}</td>
                                    <td class="center">${order.id}</td>
                                    <td><fmt:formatDate value="${order.orderTime}" pattern="dd/MM/yyyy HH:mm"/></td>
                                    <td><c:out value="${order.customerFullName}"/></td>
                                    <td><c:out value="${order.customerEmail}"/></td>
                                    <td><c:out value="${order.receiverName}"/></td>
                                    <td><c:out value="${order.receiverPhone}"/></td>
                                    <td><c:out value="${order.receiverAddress}"/></td>
                                    <td class="number"><fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="" minFractionDigits="0" maxFractionDigits="0"/></td>
                                    <td><c:out value="${order.orderStatus}"/></td>
                                    <td><c:out value="${order.paymentType}"/></td>
                                    <td><c:out value="${order.paymentStatus}"/></td>
                                    <td><c:out value="${order.productDetails}"/></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>

                        <div class="action-buttons">
                            <a href="<c:url value='/admin/order'/>" class="btn btn-back">Quay Lại DS Đơn Hàng</a>
                            <c:url var="downloadUrl" value="/admin/order/report/excel/download">
                                <c:if test="${not empty selectedStartDate}"><c:param name="startDate" value="${selectedStartDate}"/></c:if>
                                <c:if test="${not empty selectedEndDate}"><c:param name="endDate" value="${selectedEndDate}"/></c:if>
                                <c:if test="${not empty selectedStatus}"><c:param name="status" value="${selectedStatus}"/></c:if>
                            </c:url>
                            <a href="${downloadUrl}" class="btn btn-download">Tải xuống Excel</a>
                        </div>
                    </c:if>
                    <c:if test="${empty listOrders && empty message && empty error_message}">
                        <p style="text-align: center;">Không có dữ liệu đơn hàng để hiển thị.</p>
                        <div class="action-buttons">
                            <a href="<c:url value='/admin/order'/>" class="btn btn-back">Quay Lại DS Đơn Hàng</a>
                        </div>
                    </c:if>
                </div>
            </div>
        </main>
        <jsp:include page="../layout/footer.jsp" />
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="<c:url value='/js/scripts.js'/>"></script> <%-- Path JS admin --%>
</body>
</html>