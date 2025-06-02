
<!-- JSP Path: src/main/webapp/WEB-INF/view/admin/product/productExcelPreview.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Xem Trước - Báo Cáo Sản Phẩm - 3TLap Admin</title>
    <jsp:include page="../layout/common_admin_head.jsp"/>
    <style>
        .preview-page-container { padding: 1.5rem; }
        .report-header-controls { display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem; padding-bottom: 1rem; border-bottom: 1px solid var(--current-admin-divider-color); }
        .report-title-preview { font-family: var(--admin-font-primary); font-size: 1.5rem; font-weight: 600; color: var(--current-admin-text-primary); margin-bottom: 0; }
        .report-info-preview { margin-bottom: 1rem; font-size: 0.85rem; color: var(--current-admin-text-secondary); }
        .report-info-preview strong { color: var(--current-admin-text-primary); font-weight: 500;}
        
        .filter-section-preview { margin-bottom: 1.5rem; padding: 1rem 1.5rem; background-color: var(--current-admin-card-bg); border: 1px solid var(--current-admin-border-color); border-radius: 0.375rem; box-shadow: 0 0.1rem 0.3rem var(--current-admin-shadow-color-soft); }
        .filter-section-preview .form-label { font-weight: 500; font-size: 0.9rem; margin-bottom: 0.3rem; }
        .filter-section-preview .form-select { font-size: 0.9rem; padding: 0.4rem 0.8rem; background-color: var(--current-admin-bg); color: var(--current-admin-text-primary); border-color: var(--current-admin-border-color); }
        .filter-section-preview .btn-filter { font-size: 0.9rem; padding: 0.4rem 1rem; }

        .preview-table-container { background-color: var(--current-admin-card-bg); padding: 1.5rem; border-radius: 0.375rem; box-shadow: 0 0.1rem 0.3rem var(--current-admin-shadow-color-soft); border: 1px solid var(--current-admin-border-color); }
        .preview-table { width: 100%; border-collapse: collapse; font-size: 0.85em; }
        .preview-table th, .preview-table td { border: 1px solid var(--current-admin-divider-color); padding: 0.6rem; text-align: left; vertical-align: middle; color: var(--current-admin-text-secondary); }
        .preview-table th { background-color: rgba(0,0,0,0.05); font-weight: 500; color: var(--current-admin-text-primary); text-align: center; }
        body.theme-dark .preview-table th { background-color: rgba(255,255,255,0.04); }
        .preview-table td.center { text-align: center; }
        .preview-table td.number { text-align: right; }

        .action-buttons-preview { margin-top: 1.5rem; text-align: right; }
        .action-buttons-preview .btn { font-size: 0.9rem; padding: 0.5rem 1.2rem; margin-left: 0.5rem;}
        .action-buttons-preview .btn-success { background-color: var(--admin-success-accent) !important; border-color: var(--admin-success-accent) !important; }
    </style>
</head>
<body class="sb-nav-fixed admin-body-3tlap">
    <c:set var="breadcrumbCurrentPage" value="Xem Trước Báo Cáo Sản Phẩm" scope="request"/>
    <jsp:include page="../layout/header.jsp"/>

    <div id="layoutSidenav">
        <jsp:include page="../layout/navbar.jsp"/>
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4 preview-page-container">
                    <div class="report-header-controls">
                        <h1 class="report-title-preview">Báo Cáo Danh Sách Sản Phẩm</h1>
                        <a href="<c:url value='/admin/product'/>" class="btn btn-sm btn-outline-secondary admin-btn-action">
                            <i class="fas fa-arrow-left me-1"></i> Quay Lại DS Sản Phẩm
                        </a>
                    </div>
                     <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="<c:url value='/admin'/>">Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="<c:url value='/admin/product'/>">Sản Phẩm</a></li>
                        <li class="breadcrumb-item active">Xem Trước Báo Cáo</li>
                    </ol>

                    <div class="filter-section-preview">
                        <form action="<c:url value='/admin/product/report/excel/preview'/>" method="get" class="row gx-3 gy-2 align-items-end">
                            <div class="col-md-4">
                                <label for="factoryFilterPreview" class="form-label">Lọc theo hãng:</label>
                                <select name="factory" id="factoryFilterPreview" class="form-select">
                                    <option value="">-- Tất cả các hãng --</option>
                                    <c:forEach var="fac" items="${factories}">
                                        <option value="${fac}" ${fac == selectedFactory ? 'selected' : ''}>
                                            <c:out value="${fac}"/>
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
                                <c:choose>
                                    <c:when test="${not empty currentUser.fullName}"><c:out value="${currentUser.fullName}"/></c:when>
                                    <c:otherwise><c:out value="${currentUser.email}"/></c:otherwise>
                                </c:choose>
                            </p>
                            <p class="mb-0"><strong>Ngày in:</strong> <c:out value="${printDate}"/></p>
                            <c:if test="${not empty selectedFactory}">
                                <p class="mb-0 mt-1"><strong>Lọc theo hãng:</strong> <span class="badge bg-info text-dark">${selectedFactory}</span></p>
                            </c:if>
                        </div>

                        <c:if test="${not empty message}">
                            <div class="alert alert-info alert-profile my-3">${message}</div>
                        </c:if>
                        <c:if test="${not empty error_message}">
                            <div class="alert alert-danger alert-profile my-3">${error_message}</div>
                        </c:if>

                        <c:if test="${not empty listProducts}">
                            <div class="table-responsive">
                                <table class="table preview-table">
                                    <thead>
                                        <tr>
                                            <th>STT</th>
                                            <th>Mã SP</th>
                                            <th>Tên Sản Phẩm</th>
                                            <th class="text-end">Đơn Giá</th>
                                            <th>Mô Tả Ngắn</th>
                                            <th class="text-end">Tồn Kho</th>
                                            <th class="text-end">Đã Bán</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="product" items="${listProducts}" varStatus="status">
                                            <tr>
                                                <td class="center">${status.count}</td>
                                                <td class="center">${product.id}</td>
                                                <td><c:out value="${product.name}"/></td>
                                                <td class="number"><fmt:formatNumber value="${product.price}" type="number" pattern="#,##0"/> đ</td>
                                                <td><c:out value="${product.shortDesc}"/></td>
                                                <td class="number">${product.quantity}</td>
                                                <td class="number">${product.sold}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <div class="action-buttons-preview">
                                <a href="<c:url value='/admin/product/report/excel/download'><c:if test='${not empty selectedFactory}'><c:param name='factory' value='${selectedFactory}'/></c:if></c:url>" 
                                   class="btn btn-success">
                                   <i class="fas fa-file-excel me-1"></i> Tải xuống Excel
                                </a>
                            </div>
                        </c:if>
                         <c:if test="${empty listProducts && empty message && empty error_message}">
                            <div class="alert alert-warning alert-profile my-3">Không có dữ liệu sản phẩm để hiển thị với bộ lọc hiện tại.</div>
                        </c:if>
                    </div>
                </div>
            </main>
            <jsp:include page="../../client/layout/chatbot_widget.jsp" />
            <jsp:include page="../layout/footer.jsp"/>
        </div>
    </div>
    <jsp:include page="../layout/common_admin_scripts.jsp"/>
</body>
</html>