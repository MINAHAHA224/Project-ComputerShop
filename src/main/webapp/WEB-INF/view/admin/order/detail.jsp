<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- JSP Path: admin/order/detail.jsp -->
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
    <title>User</title>
    <link
      href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
      rel="stylesheet"
    />
    <link href="/css/styles.css" rel="stylesheet" />
    <script
      src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
      crossorigin="anonymous"
    ></script>
  </head>

  <body class="sb-nav-fixed">
    <jsp:include page="../layout/header.jsp" />
    <div id="layoutSidenav">
      <jsp:include page="../layout/navbar.jsp" />
      <div id="layoutSidenav_content">
        <main>
          <div class="container mt-5">
            <div class="row">
              <div class="col-12 mx-auto">
                <hr />
                <table class="table table-bordered table-hover">
                  <thead>
                    <tr>
                      <th>Sản Phẩm</th>
                      <th>Tên</th>
                      <th>GIá Cả</th>
                      <th>Số Lượng</th>
                      <th>Thành Tiền</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="orderDetail" items="${orderDetails}">
                      <tr>
                        <th>
                          <img
                            style="
                              width: 150px;
                              height: 150px;
                              border-radius: 50%;
                              overflow: hidden;
                            "
                            src="/images/product/${orderDetail.productImage}"
                          />
                        </th>
                        <td>
                          <a href="/product/${orderDetail.productId}"
                            >${orderDetail.productName}</a
                          >
                        </td>
                        <td>
                          <fmt:formatNumber
                            type="number"
                            value="${orderDetail.price}"
                          />
                          đ
                        </td>
                        <td>${orderDetail.productQuantity}</td>
                        <td>
                          <fmt:formatNumber
                            type="number"
                            value="${orderDetail.price * orderDetail.productQuantity}"
                          />
                          đ
                        </td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
          <button class="btn btn-success">
            <a href="/admin/order">Back</a>
          </button>
        </main>

        <jsp:include page="../layout/footer.jsp" />
      </div>
    </div>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
      crossorigin="anonymous"
    ></script>
    <script src="/js/scripts.js"></script>
    <script
      src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
      crossorigin="anonymous"
    ></script>
    <script src="/js/chart-area-demo.js"></script>
    <script src="/js/chart-bar-demo.js"></script>
    <script
      src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
      crossorigin="anonymous"
    ></script>
    <script src="/js/datatables-simple-demo.js"></script>
  </body>
</html>
