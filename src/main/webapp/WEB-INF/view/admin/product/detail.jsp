<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8" />
            <meta http-equiv="X-UA-Compatible" content="IE=edge" />
            <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
            <meta name="description" content="" />
            <meta name="author" content="" />
            <title>Product</title>
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
                        <div class="container mt-5">
                            <div class="row">
                                <div class="col-12 mx-auto">
                                    <c:forEach var="product" items="${products}">

                                        <div class="d-flex justify-content-between">
                                            <h3>product detail with id = ${product.id}</h3>

                                        </div>

                                        <hr />

                                        <table class="table table-bordered table-hover">
                                            <div class="card" style="width: 18rem;">
                                                <div class="card-header">
                                                    User information
                                                </div>
                                                <ul class="list-group list-group-flush">
                                                    <li class="list-group-item">ID : ${product.id} </li>
                                                    <li class="list-group-item">Name : ${product.name}</li>
                                                    <li class="list-group-item">Price : ${product.price}</li>
                                                    <li class="list-group-item">Detail description :
                                                        ${product.detailDesc}</li>
                                                    <li class="list-group-item">Short description : ${product.shortDesc}
                                                    </li>
                                                    <li class="list-group-item">Quantity : ${product.quantity}</li>
                                                    <li class="list-group-item">Factory : ${product.factory}</li>
                                                    <li class="list-group-item">Target : ${product.target}</li>
                                                    <li class="list-group-item">Sold : ${product.sold}</li>
                                                    <li class="list-group-item">Avatar :

                                                        <img class="img-thumbnail"
                                                            src="/images/product/${product.image}"
                                                            alt="Description of Image">
                                                    </li>
                                                </ul>
                                            </div>
                                        </table>

                                    </c:forEach>

                                    <a href="/admin/product" class="btn btn-primary"> Back</a>

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