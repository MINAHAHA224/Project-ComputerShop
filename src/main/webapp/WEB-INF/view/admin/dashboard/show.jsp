<!-- JSP Path: src/main/webapp/WEB-INF/view/admin/dashboard/show.jsp -->
<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Dashboard - 3TLap Admin</title>
    <jsp:include page="../layout/common_admin_head.jsp" />
  </head>

  <body class="sb-nav-fixed admin-body-3tlap">
    <c:set var="breadcrumbCurrentPage" value="Dashboard" scope="request" />
    <jsp:include page="../layout/header.jsp" />

    <div id="layoutSidenav">
      <jsp:include page="../layout/navbar.jsp" />
      <div id="layoutSidenav_content">
        <main>
          <div class="container-fluid px-4">
            <h1 class="main-content-title mt-4">Dashboard</h1>

            <div class="row">
              <div class="col-xl-3 col-md-6 mb-4">
                <div
                  class="card dashboard-card-custom border-left-primary-admin h-100"
                >
                  <div class="card-body position-relative">
                    <div class="row no-gutters align-items-center">
                      <div class="col">
                        <div
                          class="card-title-custom text-primary-admin text-uppercase mb-1"
                        >
                          Người Dùng
                        </div>
                        <div class="card-text-value mb-0 fw-bold">
                          ${elementUser}
                        </div>
                      </div>
                    </div>
                    <div class="card-body-icon">
                      <i class="fas fa-users"></i>
                    </div>
                  </div>
                  <div
                    class="card-footer d-flex align-items-center justify-content-between py-2"
                  >
                    <a
                      class="small stretched-link text-decoration-none"
                      href="<c:url value='/admin/user'/>"
                      >Xem Chi Tiết</a
                    >
                    <div class="small"><i class="fas fa-angle-right"></i></div>
                  </div>
                </div>
              </div>

              <div class="col-xl-3 col-md-6 mb-4">
                <div
                  class="card dashboard-card-custom border-left-success-admin h-100"
                >
                  <div class="card-body position-relative">
                    <div class="row no-gutters align-items-center">
                      <div class="col">
                        <div
                          class="card-title-custom text-success-admin text-uppercase mb-1"
                        >
                          Sản Phẩm
                        </div>
                        <div class="card-text-value mb-0 fw-bold">
                          ${elementProduct}
                        </div>
                      </div>
                    </div>
                    <div class="card-body-icon">
                      <i class="fas fa-laptop-code"></i>
                    </div>
                  </div>
                  <div
                    class="card-footer d-flex align-items-center justify-content-between py-2"
                  >
                    <a
                      class="small stretched-link text-decoration-none"
                      href="<c:url value='/admin/product'/>"
                      >Xem Chi Tiết</a
                    >
                    <div class="small"><i class="fas fa-angle-right"></i></div>
                  </div>
                </div>
              </div>

              <div class="col-xl-3 col-md-6 mb-4">
                <div
                  class="card dashboard-card-custom border-left-info-admin h-100"
                >
                  <div class="card-body position-relative">
                    <div class="row no-gutters align-items-center">
                      <div class="col">
                        <div
                          class="card-title-custom text-info-admin text-uppercase mb-1"
                        >
                          Đơn Hàng
                        </div>
                        <div class="card-text-value mb-0 fw-bold">
                          ${elementOrder}
                        </div>
                      </div>
                    </div>
                    <div class="card-body-icon">
                      <i class="fas fa-file-invoice-dollar"></i>
                    </div>
                  </div>
                  <div
                    class="card-footer d-flex align-items-center justify-content-between py-2"
                  >
                    <a
                      class="small stretched-link text-decoration-none"
                      href="<c:url value='/admin/order'/>"
                      >Xem Chi Tiết</a
                    >
                    <div class="small"><i class="fas fa-angle-right"></i></div>
                  </div>
                </div>
              </div>

              <div class="col-xl-3 col-md-6 mb-4">
                <div
                  class="card dashboard-card-custom border-left-warning-admin h-100"
                >
                  <div class="card-body position-relative">
                    <div class="row no-gutters align-items-center">
                      <div class="col">
                        <div
                          class="card-title-custom text-warning-admin text-uppercase mb-1"
                        >
                          Báo Cáo
                        </div>
                        <div class="card-text-value mb-0 fw-bold">
                          <i
                            class="fas fa-download"
                            style="font-size: 1.5rem"
                          ></i>
                        </div>
                      </div>
                    </div>
                    <div class="card-body-icon">
                      <i class="fas fa-file-excel"></i>
                    </div>
                  </div>
                  <div
                    class="card-footer d-flex align-items-center justify-content-between py-2"
                  >
                    <a
                      class="small stretched-link text-decoration-none"
                      href="#collapseAdminReports"
                      data-bs-toggle="collapse"
                      aria-expanded="false"
                      aria-controls="collapseAdminReports"
                    >
                      Truy Cập Nhanh
                    </a>
                    <div class="small"><i class="fas fa-angle-right"></i></div>
                  </div>
                </div>
              </div>
            </div>

            <div class="row">
              <div class="col-xl-6">
                <div class="chart-container mb-4">
                  <div class="card-header bg-transparent border-0 px-0 pb-2">
                    <i class="fas fa-chart-area me-1"></i>
                    Biểu đồ Doanh Thu
                  </div>
                  <div class="card-body p-0">
                    <canvas id="myAreaChart" width="100%" height="40"></canvas>
                  </div>
                </div>
              </div>
              <div class="col-xl-6">
                <div class="chart-container mb-4">
                  <div class="card-header bg-transparent border-0 px-0 pb-2">
                    <i class="fas fa-chart-bar me-1"></i>
                    Biểu đồ Sản Phẩm Bán Chạy
                  </div>
                  <div class="card-body p-0">
                    <canvas id="myBarChart" width="100%" height="40"></canvas>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </main>
        <jsp:include page="../../client/layout/chatbot_widget.jsp" />
        <jsp:include page="../layout/footer.jsp" />
      </div>
    </div>
    <jsp:include page="../layout/common_admin_scripts.jsp" />
    <script>
      if (typeof Chart !== 'undefined') {
        Chart.defaults.global.defaultFontColor = 'var(--admin-text-secondary)';
        Chart.defaults.global.defaultFontFamily = 'var(--admin-font-secondary)';
        if (document.getElementById('myAreaChart')) {
        }
        if (document.getElementById('myBarChart')) {
        }
      }
    </script>
  </body>
</html>
