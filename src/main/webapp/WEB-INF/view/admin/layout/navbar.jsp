<!-- JSP Path: admin/layout/navbar.jsp -->
<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="security"
uri="http://www.springframework.org/security/tags" %>

<div id="layoutSidenav_nav">
  <nav class="sb-sidenav accordion sb-sidenav-admin" id="sidenavAccordion">
    <div class="sb-sidenav-menu">
      <div class="nav">
        <div class="sb-sidenav-menu-heading">Tổng Quan</div>
        <a class="nav-link" href="<c:url value='/admin'/>">
          <div class="sb-nav-link-icon">
            <i class="fas fa-tachometer-alt"></i>
          </div>
          Dashboard
        </a>

        <div class="sb-sidenav-menu-heading">Quản Lý</div>
        <security:authorize access="hasRole('ADMIN')">
          <%-- Chỉ ADMIN thấy mục User --%>
          <a class="nav-link" href="<c:url value='/admin/user'/>">
            <div class="sb-nav-link-icon"><i class="fas fa-users"></i></div>
            Người Dùng
          </a>
        </security:authorize>

        <a class="nav-link" href="<c:url value='/admin/product'/>">
          <div class="sb-nav-link-icon"><i class="fas fa-laptop"></i></div>
          Sản Phẩm
        </a>
        <a class="nav-link" href="<c:url value='/admin/order'/>">
          <div class="sb-nav-link-icon">
            <i class="fas fa-file-invoice-dollar"></i>
          </div>
          Đơn Hàng
        </a>

        <div class="sb-sidenav-menu-heading">Báo Cáo</div>
        <a
          class="nav-link collapsed"
          href="#"
          data-bs-toggle="collapse"
          data-bs-target="#collapseReports"
          aria-expanded="false"
          aria-controls="collapseReports"
        >
          <div class="sb-nav-link-icon"><i class="fas fa-chart-bar"></i></div>
          Báo Cáo Excel
          <div class="sb-sidenav-collapse-arrow">
            <i class="fas fa-angle-down"></i>
          </div>
        </a>
        <div
          class="collapse"
          id="collapseReports"
          aria-labelledby="headingOne"
          data-bs-parent="#sidenavAccordion"
        >
          <nav class="sb-sidenav-menu-nested nav">
            <a
              class="nav-link"
              href="<c:url value='/admin/order/report/excel/preview'/>"
              >Báo cáo Đơn Hàng</a
            >
            <a
              class="nav-link"
              href="<c:url value='/admin/product/report/excel/preview'/>"
              >Báo cáo Sản Phẩm</a
            >
            <security:authorize access="hasRole('ADMIN')">
              <a
                class="nav-link"
                href="<c:url value='/admin/user/report/excel/preview'/>"
                >Báo cáo Người Dùng</a
              >
            </security:authorize>
          </nav>
        </div>

        <%--
        <div class="sb-sidenav-menu-heading">Addons</div>
        <a class="nav-link" href="#">
          <div class="sb-nav-link-icon"><i class="fas fa-chart-area"></i></div>
          Charts
        </a>
        <a class="nav-link" href="#">
          <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
          Tables
        </a>
        --%>
      </div>
    </div>
    <div class="sb-sidenav-footer">
      <div class="small">Đăng nhập với tư cách:</div>
      <c:out
        value="${sessionScope.informationDTO.role != null ? sessionScope.informationDTO.role : 'N/A'}"
      />
    </div>
  </nav>
</div>
