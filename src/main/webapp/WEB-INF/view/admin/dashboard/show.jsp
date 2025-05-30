<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!-- JSP Path: admin/dashboard/show.jsp -->
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
    <title>Dashboard - SB Admin</title>
    <jsp:include page="../layout/common_admin_head.jsp" />
  </head>

  <body class="sb-nav-fixed">
    <jsp:include page="../layout/header.jsp" />
    <div id="layoutSidenav">
      <jsp:include page="../layout/navbar.jsp" />
      <div id="layoutSidenav_content">
        <main>
          <div class="container-fluid px-4">
            <h1 class="mt-4">Dashboard</h1>
            <ol class="breadcrumb mb-4">
              <li class="breadcrumb-item active">Dashboard</li>
            </ol>
            <div class="row">
              <div class="col-xl-4 col-md-6">
                <div class="card bg-primary text-white mb-4">
                  <div class="card-body">Số lượng User ( ${elementUser})</div>
                  <div
                    class="card-footer d-flex align-items-center justify-content-between"
                  >
                    <a
                      class="small text-white stretched-link"
                      href="/admin/user"
                      >Xem chi tiết...
                    </a>
                    <div class="small text-white">
                      <i class="fas fa-angle-right"></i>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-xl-4 col-md-6">
                <div class="card bg-warning text-white mb-4">
                  <div class="card-body">
                    Số lượng product (${elementProduct})
                  </div>
                  <div
                    class="card-footer d-flex align-items-center justify-content-between"
                  >
                    <a
                      class="small text-white stretched-link"
                      href="/admin/product"
                      >Xem chi tiết...</a
                    >
                    <div class="small text-white">
                      <i class="fas fa-angle-right"></i>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-xl-4 col-md-6">
                <div class="card bg-success text-white mb-4">
                  <div class="card-body">Số lượng Order (${elementOrder})</div>
                  <div
                    class="card-footer d-flex align-items-center justify-content-between"
                  >
                    <a
                      class="small text-white stretched-link"
                      href="/admin/order"
                      >Xem chi tiết ...</a
                    >
                    <div class="small text-white">
                      <i class="fas fa-angle-right"></i>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-xl-4 col-md-6">
                <div class="card bg-secondary text-white mb-4">
                  <%-- Chọn màu khác --%>
                  <div class="card-body">Báo cáo Sản Phẩm</div>
                  <div
                    class="card-footer d-flex align-items-center justify-content-between"
                  >
                    <%-- Link đến trang chọn factory --%>
                    <a
                      class="small text-white stretched-link"
                      href="<c:url value='/admin/product/report/excel/preview'/>"
                    >
                      Xuất báo cáo Excel
                    </a>
                    <%-- Hoặc link trực tiếp đến preview với tất cả factory --%>
                    <%--
                    <a
                      class="small text-white stretched-link"
                      href="<c:url value='/admin/product/report/excel/preview'/>"
                    >
                      Xuất báo cáo Excel (Tất cả)
                    </a>
                    --%>
                    <div class="small text-white">
                      <i class="fas fa-angle-right"></i>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-xl-4 col-md-6">
                <div class="card bg-info text-white mb-4">
                  <%-- Chọn màu khác, ví dụ info --%>
                  <div class="card-body">Báo cáo Người Dùng</div>
                  <div
                    class="card-footer d-flex align-items-center justify-content-between"
                  >
                    <%-- Link trực tiếp đến preview với tất cả user, hoặc có thể
                    tạo trang chọn filter trước --%>
                    <a
                      class="small text-white stretched-link"
                      href="<c:url value='/admin/user/report/excel/preview'/>"
                    >
                      Xuất báo cáo Excel
                    </a>
                    <div class="small text-white">
                      <i class="fas fa-angle-right"></i>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-xl-4 col-md-6">
                <div class="card bg-danger text-white mb-4">
                  <%-- Chọn màu khác, ví dụ danger --%>
                  <div class="card-body">Báo cáo Đơn Hàng</div>
                  <div
                    class="card-footer d-flex align-items-center justify-content-between"
                  >
                    <a
                      class="small text-white stretched-link"
                      href="<c:url value='/admin/order/report/excel/preview'/>"
                    >
                      Xuất báo cáo Excel
                    </a>
                    <div class="small text-white">
                      <i class="fas fa-angle-right"></i>
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
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
      crossorigin="anonymous"
    ></script>
    <script src="js/scripts.js"></script>
    <script
      src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
      crossorigin="anonymous"
    ></script>
    <script src="js/chart-area-demo.js"></script>
    <script src="js/chart-bar-demo.js"></script>
    <script
      src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
      crossorigin="anonymous"
    ></script>
    <script src="js/datatables-simple-demo.js"></script>
  </body>
</html>
