<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xem Trước - Danh Sách Sản Phẩm</title>
    <%-- Link CSS của bạn, có thể dùng lại CSS của trang list hoặc admin --%>
    <link href="<c:url value='/css/styles.css'/>" rel="stylesheet" /> <%-- Điều chỉnh path --%>
    <style>
        body { font-family: Arial, sans-serif; }
        .preview-page-container { padding: 20px; }
        .preview-container {
            border: 1px solid #ccc;
            padding: 20px;
            background-color: #f9f9f9;
            margin-top: 20px;
        }
        .report-title { font-size: 20px; font-weight: bold; text-align: center; margin-bottom: 20px; }
        .report-info { margin-bottom: 15px; }
        .report-info span { font-weight: bold; }
        .preview-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            font-size: 0.9em;
        }
        .preview-table th, .preview-table td {
            border: 1px solid #ddd;
            padding: 6px;
            text-align: left;
            vertical-align: middle;
        }
        .preview-table th {
            background-color: #e9e9e9;
            font-weight: bold;
            text-align: center;
        }
        .preview-table td.number { text-align: right; }
        .preview-table td.center { text-align: center; }

        .action-buttons { margin-top: 20px; text-align: right; }
        .btn {
            padding: 10px 15px;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            margin-left: 10px;
        }
        .btn-download { background-color: #28a745; }
        .btn-back { background-color: #6c757d; }
        .btn-filter { background-color: #007bff; }

        .filter-section {
            margin-bottom: 20px;
            padding: 15px;
            background-color: #f0f0f0;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .filter-section label { margin-right: 10px; font-weight: bold; }
        .filter-section select, .filter-section button {
            padding: 8px 12px; border-radius: 4px; border: 1px solid #ccc; margin-right: 10px;
        }
    </style>
</head>
<body>
<jsp:include page="../layout/header.jsp" /> <%-- Header của admin --%>
<div id="layoutSidenav">
    <jsp:include page="../layout/navbar.jsp" /> <%-- Navbar của admin --%>
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4 preview-page-container">
                <h1 class="mt-4">Xem Trước Báo Cáo Sản Phẩm</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="<c:url value='/admin'/>">Dashboard</a></li>
                    <li class="breadcrumb-item active">Xem Trước</li>
                </ol>

                <div class="filter-section">
                    <form action="<c:url value='/admin/product/report/excel/preview'/>" method="get">
                        <label for="factoryFilter">Lọc theo hãng:</label>
                        <select name="factory" id="factoryFilter">
                            <option value="">-- Tất cả các hãng --</option>
                            <c:forEach var="fac" items="${factories}">
                                <option value="${fac}" ${fac == selectedFactory ? 'selected' : ''}>
                                    <c:out value="${fac}"/>
                                </option>
                            </c:forEach>
                        </select>
                        <button type="submit" class="btn btn-filter">Lọc</button>
                    </form>
                </div>

                <div class="preview-container">
                    <div class="report-title">
                        DANH SÁCH SẢN PHẨM
                        <c:if test="${not empty selectedFactory}">
                            (HÃNG: <c:out value="${selectedFactory}"/>)
                        </c:if>
                    </div>

                    <div class="report-info">
                        Người lập báo cáo: <span><c:out value="${currentUser.fullName}"/></span> <%-- Giả sử LoginDto có getUsername() --%>
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

                    <c:if test="${not empty listProducts}">
                        <table class="preview-table">
                            <thead>
                            <tr>
                                <th>STT</th>
                                <th>Mã SP</th>
                                <th>Tên Sản Phẩm</th>
                                <th>Đơn Giá</th>
                                <th>Mô Tả Ngắn</th>
                                <th>Tồn Kho</th>
                                <th>Đã Bán</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="product" items="${listProducts}" varStatus="status">
                                <tr>
                                    <td class="center">${status.count}</td>
                                    <td class="center">${product.id}</td>
                                    <td><c:out value="${product.name}"/></td>
                                    <td class="number">
                                        <fmt:formatNumber value="${product.price}" type="number" pattern="#,##0"/> VNĐ
                                    </td>
                                    <td><c:out value="${product.shortDesc}"/></td>
                                    <td class="number">${product.quantity}</td>
                                    <td class="number">${product.sold}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>

                        <div class="action-buttons">
                            <a href="<c:url value='/admin'/>" class="btn btn-back">Quay Lại Danh Sách</a> <%-- Hoặc /admin/dashboard --%>
                            <a href="<c:url value='/admin/product/report/excel/download'>
                                             <c:if test='${not empty selectedFactory}'><c:param name='factory' value='${selectedFactory}'/></c:if>
                                         </c:url>" class="btn btn-download">Tải xuống Excel</a>
                        </div>
                    </c:if>
                    <c:if test="${empty listProducts && empty message && empty error_message}">
                        <p style="text-align: center;">Không có dữ liệu sản phẩm để hiển thị.</p>
                        <div class="action-buttons">
                            <a href="<c:url value='/admin/product'/>" class="btn btn-back">Quay Lại Danh Sách</a>
                        </div>
                    </c:if>
                </div>
            </div>
        </main>
        <jsp:include page="../layout/footer.jsp" /> <%-- Footer của admin --%>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="<c:url value='/js/scripts.js'/>"></script> <%-- Điều chỉnh path --%>
</body>
</html>