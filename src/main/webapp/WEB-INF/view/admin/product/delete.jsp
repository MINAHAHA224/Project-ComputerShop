<%--src/main/webapp/WEB-INF/view/admin/product/delete.jsp--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content="" />
                <meta name="author" content="" />
                <title>Delete Product</title>
                <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
            </head>

            <body class="sb-nav-fixed">
                <jsp:include page="../layout/header.jsp" />
                <div id="layoutSidenav">
                    <jsp:include page="../layout/navbar.jsp" />
                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container  mt-5">
                                <div class="row">

                                    <div class="col-md-6 col-12 mx-auto">
                                        <c:forEach var="info" items="${product1}">
                                            <div class="header">
                                                Delete Product id = ${info.id}
                                            </div>
                                        </c:forEach>

                                        <form:form method="POST" action="/admin/user/product" modelAttribute="product2"
                                            class="header_form">

                                            <div class="alert alert-primary" role="alert">
                                                Do use realy to delete it !!
                                            </div>
                                            <div class="mb-3" style="display: none;">
                                                <label class="form-label">ID</label>
                                                <form:input type="text" class="form-control" path="id" />
                                            </div>
                                            <button type="submit" class="btn btn-primary">Delete</button>
                                        </form:form>
                                    </div>

                                </div>

                            </div>
                        </main>

                        <jsp:include page="../layout/footer.jsp" />
                    </div>
                </div>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="/js/scripts.js"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
                    crossorigin="anonymous"></script>
                <script src="/js/chart-area-demo.js"></script>
                <script src="/js/chart-bar-demo.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
                    crossorigin="anonymous"></script>
                <script src="/js/datatables-simple-demo.js"></script>
            </body>

            </html>