<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!-- JSP Path: admin/user/userExcelPreview.jsp -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xem Trước - Danh Sách Người Dùng</title>
    <link href="<c:url value='/css/styles.css'/>" rel="stylesheet" /> <%-- Hoặc path CSS admin của bạn --%>
    <style>
        body { font-family: Arial, sans-serif; }
        .preview-page-container { padding: 20px; }
        .preview-container { border: 1px solid #ccc; padding: 20px; background-color: #f9f9f9; margin-top: 20px; }
        .report-title { font-size: 20px; font-weight: bold; text-align: center; margin-bottom: 20px; }
        .report-info { margin-bottom: 15px; }
        .report-info span { font-weight: bold; }
        .preview-table { width: 100%; border-collapse: collapse; margin-top: 20px; font-size: 0.9em; }
        .preview-table th, .preview-table td { border: 1px solid #ddd; padding: 6px; text-align: left; vertical-align: middle; }
        .preview-table th { background-color: #e9e9e9; font-weight: bold; text-align: center; }
        .preview-table td.center { text-align: center; }
        .action-buttons { margin-top: 20px; text-align: right; }
        .btn { padding: 10px 15px; color: white; text-decoration: none; border-radius: 4px; border: none; cursor: pointer; margin-left: 10px; }
        .btn-download { background-color: #28a745; }
        .btn-back { background-color: #6c757d; }
        .btn-filter { background-color: #007bff; }
        .filter-section { margin-bottom: 20px; padding: 15px; background-color: #f0f0f0; border: 1px solid #ddd; border-radius: 5px; }
        .filter-section label { margin-right: 10px; font-weight: bold; }
        .filter-section select, .filter-section button { padding: 8px 12px; border-radius: 4px; border: 1px solid #ccc; margin-right: 10px; }
    </style>
</head>
<body>
<jsp:include page="../layout/header.jsp" />
<div id="layoutSidenav">
    <jsp:include page="../layout/navbar.jsp" />
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4 preview-page-container">
                <h1 class="mt-4">Xem Trước Báo Cáo Người Dùng</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="<c:url value='/admin'/>">Dashboard</a></li>
                    <li class="breadcrumb-item active">Xem Trước Báo Cáo Người Dùng</li>
                </ol>

                <div class="filter-section">
                    <form action="<c:url value='/admin/user/report/excel/preview'/>" method="get">
                        <label for="roleFilter">Lọc theo vai trò:</label>
                        <select name="roleId" id="roleFilter" class="form-select" style="display: inline-block; width: auto;">
                            <option value="">-- Tất cả vai trò --</option>
                            <c:forEach var="role" items="${allRoles}">
                                <option value="${role.id}" ${role.id == selectedRoleId ? 'selected' : ''}>
                                    <c:out value="${role.name}"/>
                                </option>
                            </c:forEach>
                        </select>
                        <button type="submit" class="btn btn-filter">Lọc</button>
                    </form>
                </div>

                <div class="preview-container">
                    <div class="report-title">
                        DANH SÁCH NGƯỜI DÙNG
                        <c:if test="${not empty selectedRoleName}">
                            (VAI TRÒ: <c:out value="${selectedRoleName}"/>)
                        </c:if>
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

                    <c:if test="${not empty listUsers}">
                        <table class="preview-table">
                            <thead>
                            <tr>
                                <th>STT</th>
                                <th>Mã ND</th>
                                <th>Họ và Tên</th>
                                <th>Email</th>
                                <th>Số Điện Thoại</th>
                                <th>Địa Chỉ</th>
                                <th>Vai Trò</th>
                                <th>P.Thức Đăng Nhập</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="user" items="${listUsers}" varStatus="status">
                                <tr>
                                    <td class="center">${status.count}</td>
                                    <td class="center">${user.id}</td>
                                    <td><c:out value="${user.fullName}"/></td>
                                    <td><c:out value="${user.email}"/></td>
                                    <td><c:out value="${user.phone}"/></td>
                                    <td><c:out value="${user.address}"/></td>
                                    <td><c:out value="${user.roleName}"/></td>
                                    <td><c:out value="${user.authMethods}"/></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>

                        <div class="action-buttons">
                            <a href="<c:url value='/admin/user'/>" class="btn btn-back">Quay Lại DS User</a> <%-- Hoặc /admin/dashboard --%>
                            <a href="<c:url value='/admin/user/report/excel/download'>
                                             <c:if test='${not empty selectedRoleId}'><c:param name='roleId' value='${selectedRoleId}'/></c:if>
                                         </c:url>" class="btn btn-download">Tải xuống Excel</a>
                        </div>
                    </c:if>
                    <c:if test="${empty listUsers && empty message && empty error_message}">
                        <p style="text-align: center;">Không có dữ liệu người dùng để hiển thị.</p>
                        <div class="action-buttons">
                            <a href="<c:url value='/admin/user'/>" class="btn btn-back">Quay Lại DS User</a>
                        </div>
                    </c:if>
                </div>
            </div>
        </main>
        <jsp:include page="../layout/footer.jsp" />
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="<c:url value='/js/scripts.js'/>"></script> <%-- Hoặc path JS admin của bạn --%>
</body>
</html>