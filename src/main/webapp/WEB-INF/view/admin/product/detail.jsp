<!-- JSP Path: src/main/webapp/WEB-INF/view/admin/product/detail.jsp -->

<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %> <%@ taglib prefix="security"
uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />
    <title>Chi Tiết Sản Phẩm - ${product.name} - 3TLap Admin</title>
    <jsp:include page="../layout/common_admin_head.jsp" />
    <style>
      .product-detail-admin-card .main-product-image {
        max-width: 100%;
        max-height: 400px;
        object-fit: contain;
        border-radius: 0.375rem;
        border: 1px solid var(--current-admin-border-color);
        background-color: var(--current-admin-card-bg);
        padding: 1rem;
        margin-bottom: 1.5rem;
      }
      body.theme-dark .product-detail-admin-card .main-product-image {
        background-color: var(--current-admin-bg);
      }

      .product-detail-admin-card .detail-item {
        margin-bottom: 0.8rem;
        font-size: 0.95rem;
      }
      .product-detail-admin-card .detail-item strong {
        color: var(--current-admin-text-secondary);
        min-width: 150px;
        display: inline-block;
        font-weight: 500;
      }
      .product-detail-admin-card .detail-item span {
        color: var(--current-admin-text-primary);
      }
      .product-detail-admin-card .description-content {
        padding: 1rem;
        background-color: rgba(0, 0, 0, 0.03);
        border-radius: 0.25rem;
        border: 1px solid var(--current-admin-divider-color);
        line-height: 1.7;
        max-height: 400px;
        overflow-y: auto;
        color: var(--current-admin-text-secondary);
      }
      body.theme-dark .product-detail-admin-card .description-content {
        background-color: rgba(255, 255, 255, 0.03);
      }
      .product-detail-admin-card .actions-bar {
        padding-top: 1.5rem;
        border-top: 1px solid var(--current-admin-divider-color);
        margin-top: 1.5rem;
      }
    </style>
  </head>

  <body class="sb-nav-fixed admin-body-3tlap">
    <c:set
      var="breadcrumbCurrentPage"
      value="Chi Tiết Sản Phẩm"
      scope="request"
    />
    <jsp:include page="../layout/header.jsp" />

    <div id="layoutSidenav">
      <jsp:include page="../layout/navbar.jsp" />
      <div id="layoutSidenav_content">
        <main>
          <div class="container-fluid px-4">
            <h1 class="main-content-title mt-4">Chi Tiết Sản Phẩm</h1>
            <div class="d-flex justify-content-between align-items-center mb-3">
              <ol class="breadcrumb mb-0 bg-transparent p-0">
                <li class="breadcrumb-item">
                  <a href="<c:url value='/admin'/>">Dashboard</a>
                </li>
                <li class="breadcrumb-item">
                  <a href="<c:url value='/admin/product'/>">Sản Phẩm</a>
                </li>
                <li class="breadcrumb-item active">
                  Chi Tiết: <c:out value="${product.name}" />
                </li>
              </ol>
              <div>
                <a
                  href="<c:url value='/admin/product/update/${product.id}'/>"
                  class="btn btn-warning btn-sm admin-btn-action"
                >
                  <i class="fas fa-edit me-1"></i> Sửa
                </a>
                <a
                  href="<c:url value='/admin/product'/>"
                  class="btn btn-outline-secondary btn-sm admin-btn-action ms-2"
                >
                  <i class="fas fa-arrow-left me-1"></i> Quay Lại Danh Sách
                </a>
              </div>
            </div>

            <div class="card admin-detail-card product-detail-admin-card mb-4">
              <div class="card-header">
                <h4>
                  Thông Tin Sản Phẩm: <c:out value="${product.name}" /> (ID:
                  ${product.id})
                </h4>
              </div>
              <div class="card-body">
                <div class="row">
                  <div class="col-md-5 text-center">
                    <img src="<c:url
                      value='/images/product/${not empty product.image ? product.image : "default-product.png"}'
                    />" alt="Ảnh sản phẩm ${product.name}"
                    class="main-product-image">
                  </div>
                  <div class="col-md-7">
                    <div class="detail-item">
                      <strong>Tên sản phẩm:</strong>
                      <span><c:out value="${product.name}" /></span>
                    </div>
                    <div class="detail-item">
                      <strong>Giá bán:</strong>
                      <span class="fw-bold text-danger"
                        ><fmt:formatNumber
                          type="number"
                          value="${product.price}"
                        />
                        đ</span
                      >
                    </div>
                    <div class="detail-item">
                      <strong>Hãng sản xuất:</strong>
                      <span><c:out value="${product.factory}" /></span>
                    </div>
                    <div class="detail-item">
                      <strong>Đối tượng:</strong>
                      <span><c:out value="${product.target}" /></span>
                    </div>
                    <div class="detail-item">
                      <strong>Số lượng tồn:</strong>
                      <span>${product.quantity}</span>
                    </div>
                    <div class="detail-item">
                      <strong>Đã bán:</strong> <span>${product.sold}</span>
                    </div>
                    <div class="mt-3">
                      <strong>Mô tả ngắn:</strong>
                      <p class="text-muted mt-1" style="line-height: 1.6">
                        <c:out value="${product.shortDesc}" />
                      </p>
                    </div>
                  </div>
                </div>
                <hr class="my-4" />
                <div>
                  <h5 class="section-subtitle-admin">
                    Mô Tả Chi Tiết Sản Phẩm
                  </h5>
                  <div class="description-content">
                    <%-- Sử dụng c:out với escapeXml="false" nếu detailDesc là
                    HTML. Cẩn thận XSS! --%>
                    <c:out value="${product.detailDesc}" escapeXml="false" />
                  </div>
                </div>
                <div class="actions-bar text-end mt-4">
                  <a
                    href="<c:url value='/admin/product/update/${product.id}'/>"
                    class="btn btn-warning admin-btn-action"
                  >
                    <i class="fas fa-edit me-1"></i> Chỉnh Sửa Sản Phẩm
                  </a>
                  <button
                    type="button"
                    class="btn btn-danger admin-btn-action ms-2"
                    data-bs-toggle="modal"
                    data-bs-target="#deleteProductModalDetail"
                    data-product-id="${product.id}"
                    data-product-name="${product.name}"
                  >
                    <i class="fas fa-trash-alt me-1"></i> Xóa Sản Phẩm
                  </button>
                </div>
              </div>
            </div>
          </div>
        </main>
        <jsp:include page="../layout/footer.jsp" />
      </div>
    </div>

    <!-- Delete (Tương tự như ở show.jsp, nhưng có thể cần ID khác) -->
    <div
      class="modal fade"
      id="deleteProductModalDetail"
      tabindex="-1"
      aria-labelledby="deleteProductModalDetailLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content admin-modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="deleteProductModalDetailLabel">
              Xác Nhận Xóa Sản Phẩm
            </h5>
            <button
              type="button"
              class="btn-close btn-close-white"
              data-bs-dismiss="modal"
              aria-label="Close"
            ></button>
          </div>
          <div class="modal-body">
            Bạn có chắc chắn muốn xóa sản phẩm
            <strong id="productNameToDeleteDetail"></strong> (ID:
            <span id="productIdToDeleteDetail"></span>)? <br />Hành động này sẽ
            xóa vĩnh viễn sản phẩm.
          </div>
          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-outline-secondary"
              data-bs-dismiss="modal"
            >
              Hủy Bỏ
            </button>
            <form id="deleteProductFormDetail" method="get" action="">
              <button type="submit" class="btn btn-danger">Xác Nhận Xóa</button>
            </form>
          </div>
        </div>
      </div>
    </div>

    <jsp:include page="../layout/common_admin_scripts.jsp" />
    <script>
      document.addEventListener('DOMContentLoaded', function () {
        var deleteProductModalDetail = document.getElementById(
          'deleteProductModalDetail'
        );
        if (deleteProductModalDetail) {
          deleteProductModalDetail.addEventListener(
            'show.bs.modal',
            function (event) {
              var button = event.relatedTarget;
              var productId = button.getAttribute('data-product-id');
              var productName = button.getAttribute('data-product-name');

              deleteProductModalDetail.querySelector(
                '#productIdToDeleteDetail'
              ).textContent = productId;
              deleteProductModalDetail.querySelector(
                '#productNameToDeleteDetail'
              ).textContent = productName;
              deleteProductModalDetail.querySelector(
                '#deleteProductFormDetail'
              ).action = '<c:url value="/admin/product/delete"/>/' + productId;
            }
          );
        }
      });
    </script>
  </body>
</html>
