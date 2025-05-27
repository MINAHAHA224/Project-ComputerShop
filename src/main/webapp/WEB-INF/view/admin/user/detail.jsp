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
            <title>User</title>
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


                                        <div class="d-flex justify-content-between">
                                            <h3>User detail with id = ${infoUser.id}</h3>

                                        </div>

                                        <hr />

                                        <table class="table table-bordered table-hover">
                                            <div class="card" style="width: 18rem;">
                                                <div class="card-header">
                                                    User information
                                                </div>
                                                <ul class="list-group list-group-flush">
                                                    <li class="list-group-item">ID : ${infoUser.id} </li>
                                                    <li class="list-group-item">Email : ${infoUser.email}</li>
                                                    <li class="list-group-item">Full Name : ${infoUser.fullName}</li>
                                                    <li class="list-group-item">Adress : ${infoUser.address}</li>
                                                    <li class="list-group-item">Phone : ${infoUser.phone}</li>
                                                    <li class="list-group-item">Role : ${infoUser.roleName}</li>
                                                    <li class="list-group-item">Avatar :

                                                        <img class="img-thumbnail"
                                                            src="/images/avatar/${infoUser.avatar}"
                                                            alt="Description of Image">
                                                    </li>
                                                </ul>
                                            </div>
                                        </table>



                                    <a href="/admin/user" class="btn btn-primary"> Back</a>

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