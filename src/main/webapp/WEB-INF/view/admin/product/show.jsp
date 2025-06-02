<!-- JSP Path: src/main/webapp/WEB-INF/view/admin/product/show.jsp -->
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
    <title>Quản Lý Sản Phẩm - 3TLap Admin</title>
    <jsp:include page="../layout/common_admin_head.jsp" />
    <link
      href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
      rel="stylesheet"
    />
    <style>
      .product-thumbnail-admin {
        width: 60px;
        height: 60px;
        object-fit: contain;
        border-radius: 0.25rem;
        border: 1px solid var(--current-admin-border-color);
        background-color: var(--white-color); /* Nền trắng để ảnh nổi bật */
      }
      body.theme-dark .product-thumbnail-admin {
        background-color: var(
          --current-admin-card-bg
        ); /* Nền tối hơn cho ảnh trong dark mode */
      }
      .table-actions .btn {
        margin-right: 0.3rem;
        padding: 0.3rem 0.6rem;
        font-size: 0.8rem;
      }
      .table-actions .btn i {
        margin-right: 0;
      }
      .table td,
      .table th {
        vertical-align: middle;
      }
    </style>
  </head>

  <body class="sb-nav-fixed admin-body-3tlap">
    <c:set
      var="breadcrumbCurrentPage"
      value="Quản Lý Sản Phẩm"
      scope="request"
    />
    <jsp:include page="../layout/header.jsp" />

    <div id="layoutSidenav">
      <jsp:include page="../layout/navbar.jsp" />
      <div id="layoutSidenav_content">
        <main>
          <div class="container-fluid px-4">
            <h1 class="main-content-title mt-4">Danh Sách Sản Phẩm</h1>

            <div class="d-flex justify-content-between align-items-center mb-3">
              <ol class="breadcrumb mb-0 bg-transparent p-0">
                <li class="breadcrumb-item">
                  <a href="<c:url value='/admin'/>">Dashboard</a>
                </li>
                <li class="breadcrumb-item active">Sản Phẩm</li>
              </ol>
              <a
                href="<c:url value='/admin/product/create'/>"
                class="btn btn-primary btn-sm admin-btn-create"
              >
                <i class="fas fa-plus me-1"></i> Thêm Sản Phẩm Mới
              </a>
            </div>

            <c:if test="${not empty messageSuccess}">
              <div
                class="alert alert-success alert-dismissible fade show"
                role="alert"
              >
                ${messageSuccess}<button
                  type="button"
                  class="btn-close"
                  data-bs-dismiss="alert"
                  aria-label="Close"
                ></button>
              </div>
            </c:if>
            <c:if test="${not empty messageError}">
              <div
                class="alert alert-danger alert-dismissible fade show"
                role="alert"
              >
                ${messageError}<button
                  type="button"
                  class="btn-close"
                  data-bs-dismiss="alert"
                  aria-label="Close"
                ></button>
              </div>
            </c:if>

            <div class="card mb-4 admin-table-card">
              <div class="card-header">
                <i class="fas fa-laptop me-1"></i>
                Danh sách chi tiết sản phẩm
              </div>
              <div class="card-body">
                <table id="productsTable" class="table table-hover">
                  <thead>
                    <tr>
                      <%-- Có thể thêm ảnh sau --%>
                      <th style="width: 5%">ID</th>
                      <%--
                      <th style="width: 10%">Ảnh</th>
                      --%>
                      <th style="width: 30%">Tên Sản Phẩm</th>
                      <th style="width: 15%">Giá</th>
                      <th style="width: 15%">Hãng</th>
                      <%--
                      <th>Số lượng</th>
                      <th>Đã bán</th>
                      --%>
                      <th class="text-center" style="width: 25%">Hành Động</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="product" items="${listProduct}">
                      <tr>
                        <td>${product.id}</td>
                        <%--
                        <td>
                          <img src="<c:url
                            value='/images/product/${not empty product.image ? product.image : "default-product.png"}'
                          />" alt="${product.name}"
                          class="product-thumbnail-admin">
                        </td>
                        --%>
                        <td><c:out value="${product.name}" /></td>
                        <td>
                          <fmt:formatNumber
                            type="number"
                            value="${product.price}"
                          />
                          đ
                        </td>
                        <td><c:out value="${product.factory}" /></td>
                        <%--
                        <td>${product.quantity}</td>
                        <td>${product.sold}</td>
                        --%>
                        <td class="text-center table-actions">
                          <a
                            href="<c:url value='/admin/product/${product.id}'/>"
                            class="btn btn-info btn-sm"
                            title="Xem chi tiết"
                          >
                            <i class="fas fa-eye"></i>
                          </a>
                          <a
                            href="<c:url value='/admin/product/update/${product.id}'/>"
                            class="btn btn-warning btn-sm"
                            title="Cập nhật"
                          >
                            <i class="fas fa-edit"></i>
                          </a>
                          <button
                            type="button"
                            class="btn btn-danger btn-sm"
                            title="Xóa"
                            data-bs-toggle="modal"
                            data-bs-target="#deleteProductModal"
                            data-product-id="${product.id}"
                            data-product-name="${product.name}"
                          >
                            <i class="fas fa-trash-alt"></i>
                          </button>
                        </td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>

                <c:if test="${totalPages > 1}">
                  <nav aria-label="Product navigation">
                    <ul class="pagination justify-content-center mt-4">
                      <li
                        class="page-item ${currentPage == 1 ? 'disabled' : ''}"
                      >
                        <a
                          class="page-link"
                          href="<c:url value='/admin/product?page=${currentPage - 1}'/>"
                          >Trước</a
                        >
                      </li>
                      <c:forEach begin="1" end="${totalPages}" var="i">
                        <li
                          class="page-item ${currentPage == i ? 'active' : ''}"
                        >
                          <a
                            class="page-link"
                            href="<c:url value='/admin/product?page=${i}'/>"
                            >${i}</a
                          >
                        </li>
                      </c:forEach>
                      <li
                        class="page-item ${currentPage == totalPages ? 'disabled' : ''}"
                      >
                        <a
                          class="page-link"
                          href="<c:url value='/admin/product?page=${currentPage + 1}'/>"
                          >Sau</a
                        >
                      </li>
                    </ul>
                  </nav>
                </c:if>
              </div>
            </div>
          </div>
        </main>
        <jsp:include page="../../client/layout/chatbot_widget.jsp" />
        <jsp:include page="../layout/footer.jsp" />
      </div>
    </div>

    <!-- Delete Modal -->
    <div
      class="modal fade"
      id="deleteProductModal"
      tabindex="-1"
      aria-labelledby="deleteProductModalLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content admin-modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="deleteProductModalLabel">
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
            <strong id="productNameToDelete"></strong> (ID:
            <span id="productIdToDelete"></span>)? <br />Việc này sẽ xóa vĩnh
            viễn sản phẩm khỏi hệ thống.
          </div>
          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-outline-secondary"
              data-bs-dismiss="modal"
            >
              Hủy Bỏ
            </button>
            <%-- Form này action sẽ được set bằng JS --%>
            <form id="deleteProductForm" method="get" action="">
              <button type="submit" class="btn btn-danger">Xác Nhận Xóa</button>
            </form>
          </div>
        </div>
      </div>
    </div>

    <jsp:include page="../layout/common_admin_scripts.jsp" />
    <script
      src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
      crossorigin="anonymous"
    ></script>
    <script>
      document.addEventListener('DOMContentLoaded', function () {
        const productsTable = document.getElementById('productsTable');
        var totalPages = <c:out value="${totalPages}" />;
        if (productsTable && totalPages <= 1) {
          // Chỉ dùng SimpleDataTables nếu không phân trang từ backend hoặc chỉ có 1 trang
          new simpleDatatables.DataTable(productsTable, {
            perPage: 10, // Số lượng item mỗi trang mặc định
            perPageSelect: [5, 10, 20, 50],
            labels: {
              placeholder: 'Tìm kiếm trong bảng...',
              perPage: '{select} sản phẩm mỗi trang',
              noRows: 'Không tìm thấy sản phẩm nào',
              info: 'Hiển thị {start} đến {end} của {rows} sản phẩm',
            },
          });
        }

        var deleteProductModal = document.getElementById('deleteProductModal');
        if (deleteProductModal) {
          deleteProductModal.addEventListener(
            'show.bs.modal',
            function (event) {
              var button = event.relatedTarget;
              var productId = button.getAttribute('data-product-id');
              var productName = button.getAttribute('data-product-name');

              deleteProductModal.querySelector(
                '#productIdToDelete'
              ).textContent = productId;
              deleteProductModal.querySelector(
                '#productNameToDelete'
              ).textContent = productName;
              deleteProductModal.querySelector('#deleteProductForm').action =
                '<c:url value="/admin/product/delete"/>/' + productId;
            }
          );
        }
      });
    </script>
  </body>
</html>
