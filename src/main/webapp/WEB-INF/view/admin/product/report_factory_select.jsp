<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!-- JSP Path: admin/product/report_factory_select.jsp -->
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Chọn Hãng Sản Xuất - Báo Cáo Sản Phẩm</title>
    <%-- Link CSS của bạn --%>
    <link href="<c:url value='/css/styles.css'/>" rel="stylesheet" />
    <%-- Điều chỉnh path --%>
    <style>
      .form-container {
        padding: 20px;
        max-width: 500px;
        margin: 50px auto;
        border: 1px solid #ddd;
        border-radius: 5px;
      }
      .form-group {
        margin-bottom: 15px;
      }
      .form-group label {
        display: block;
        margin-bottom: 5px;
      }
      .form-group select,
      .form-group button {
        padding: 8px 12px;
        border-radius: 4px;
        border: 1px solid #ccc;
      }
      .form-group button {
        background-color: #007bff;
        color: white;
        cursor: pointer;
      }
    </style>
  </head>
  <body>
    <jsp:include page="../layout/header.jsp" /> <%-- Header của admin --%>
    <div id="layoutSidenav">
      <jsp:include page="../layout/navbar.jsp" /> <%-- Navbar của admin --%>
      <div id="layoutSidenav_content">
        <main>
          <div class="container-fluid px-4">
            <h1 class="mt-4">Báo Cáo Sản Phẩm</h1>
            <ol class="breadcrumb mb-4">
              <li class="breadcrumb-item">
                <a href="<c:url value='/admin/dashboard'/>">Dashboard</a>
              </li>
              <li class="breadcrumb-item active">Chọn Hãng Sản Xuất</li>
            </ol>

            <div class="form-container">
              <form
                action="<c:url value='/admin/product/report/excel/preview'/>"
                method="get"
              >
                <div class="form-group">
                  <label for="factory">Chọn Hãng Sản Xuất:</label>
                  <select name="factory" id="factory" class="form-control">
                    <option value="">-- Tất cả các hãng --</option>
                    <c:forEach var="fac" items="${factories}">
                      <option value="${fac}"><c:out value="${fac}" /></option>
                    </c:forEach>
                  </select>
                </div>
                <div class="form-group">
                  <button type="submit" class="btn btn-primary">
                    Xem Trước Báo Cáo
                  </button>
                </div>
              </form>
            </div>
          </div>
        </main>
        <jsp:include page="../layout/footer.jsp" /> <%-- Footer của admin --%>
      </div>
    </div>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
      crossorigin="anonymous"
    ></script>
    <script src="<c:url value='/js/scripts.js'/>"></script>
    <%-- Điều chỉnh path --%>
  </body>
</html>
