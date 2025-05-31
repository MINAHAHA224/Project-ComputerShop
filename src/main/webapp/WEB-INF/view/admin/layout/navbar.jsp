<!-- JSP Path: src/main/webapp/WEB-INF/view/admin/layout/navbar.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
prefix="security" uri="http://www.springframework.org/security/tags" %>

<div id="layoutSidenav_nav">
  <nav class="sb-sidenav accordion admin-sidenav" id="sidenavAccordionAdmin">
    <div class="sb-sidenav-menu">
      <div class="nav">
        <div class="sb-sidenav-menu-heading">Tổng Quan</div>
        <a
          class="nav-link nav-item-main"
          href="<c:url value='/admin'/>"
          data-page="Tổng Quan"
        >
          <div class="sb-nav-link-icon">
            <i class="fas fa-tachometer-alt"></i>
          </div>
          <span>Dashboard</span>
        </a>

        <div class="sb-sidenav-menu-heading">Quản Lý Nội Dung</div>
        <security:authorize access="hasRole('ADMIN')">
          <a
            class="nav-link nav-item-main"
            href="<c:url value='/admin/user'/>"
            data-page="Người Dùng"
          >
            <div class="sb-nav-link-icon"><i class="fas fa-users-cog"></i></div>
            <span>Người Dùng</span>
          </a>
        </security:authorize>

        <a
          class="nav-link nav-item-main"
          href="<c:url value='/admin/product'/>"
          data-page="Sản Phẩm"
        >
          <div class="sb-nav-link-icon"><i class="fas fa-laptop-code"></i></div>
          <span>Sản Phẩm</span>
        </a>
        <a
          class="nav-link nav-item-main"
          href="<c:url value='/admin/order'/>"
          data-page="Đơn Hàng"
        >
          <div class="sb-nav-link-icon">
            <i class="fas fa-file-invoice-dollar"></i>
          </div>
          <span>Đơn Hàng</span>
        </a>

        <div class="sb-sidenav-menu-heading">Công Cụ</div>
        <a
          class="nav-link collapsed nav-item-main"
          href="#"
          data-bs-toggle="collapse"
          data-bs-target="#collapseAdminReports"
          aria-expanded="false"
          aria-controls="collapseAdminReports"
        >
          <div class="sb-nav-link-icon"><i class="fas fa-file-excel"></i></div>
          <span>Báo Cáo</span>
          <div class="sb-sidenav-collapse-arrow">
            <i class="fas fa-angle-down"></i>
          </div>
        </a>
        <div
          class="collapse"
          id="collapseAdminReports"
          aria-labelledby="headingReports"
          data-bs-parent="#sidenavAccordionAdmin"
        >
          <nav class="sb-sidenav-menu-nested nav">
            <a
              class="nav-link"
              href="<c:url value='/admin/order/report/excel/preview'/>"
              data-page="Báo Cáo Đơn Hàng"
              >Đơn Hàng</a
            >
            <a
              class="nav-link"
              href="<c:url value='/admin/product/report/excel/preview'/>"
              data-page="Báo Cáo Sản Phẩm"
              >Sản Phẩm</a
            >
            <security:authorize access="hasRole('ADMIN')">
              <a
                class="nav-link"
                href="<c:url value='/admin/user/report/excel/preview'/>"
                data-page="Báo Cáo Người Dùng"
                >Người Dùng</a
              >
            </security:authorize>
          </nav>
        </div>

        <a
          class="nav-link nav-item-main"
          href="<c:url value='/home'/>"
          target="_blank"
        >
          <div class="sb-nav-link-icon">
            <i class="fas fa-external-link-alt"></i>
          </div>
          <span>Xem Trang Client</span>
        </a>
      </div>
    </div>
    <div class="sb-sidenav-footer">
      <div class="small">Logged in as:</div>
      <span class="fw-semibold"
        ><c:out
          value="${sessionScope.informationDTO.role != null ? sessionScope.informationDTO.role : 'N/A'}"
      /></span>
    </div>
  </nav>
</div>
