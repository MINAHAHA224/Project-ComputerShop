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
                            <div class="container  mt-5">
                                <div class="row">

                                    <div class="col-md-6 col-12 mx-auto">
                                        <div class="header">
                                            update
                                        </div>
                                        <form:form method="POST" enctype="multipart/form-data"
                                            action="/admin/user/update" modelAttribute="newUser" class="header_form">
                                            <div class="mb-3" style="display: none;">
                                                <label class="form-label">ID</label>
                                                <form:input type="text" class="form-control" path="id" />
                                            </div>
                                            <div class="mb-3">

                                                <label class="form-label">Email address</label>
                                                <form:input type="email" class="form-control"
                                                    aria-describedby="emailHelp" path="email" disabled="true" />
                                                <div id="emailHelp" class="form-text">We'll never share your email with
                                                    anyone else.
                                                </div>
                                            </div>

                                            <div class="mb-3">
                                                <c:set var="errorFullname">
                                                    <form:errors path="fullName" cssClass="invalid-feedback" />
                                                </c:set>
                                                <label class="form-label">Fullname</label>
                                                <form:input type="text"
                                                    class="form-control ${not empty errorFullname ? 'is-invalid' : ''}"
                                                    path="fullName" />
                                                ${errorFullname}

                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Address</label>
                                                <form:input type="text" class="form-control" path="address" />

                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Phone</label>
                                                <form:input type="text" class="form-control" path="phone" />

                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Role:</label>
                                                <form:select class="form-select" path="role.name">
                                                    <form:option value="ADMIN">ADMIN</form:option>
                                                    <form:option value="USER">USER</form:option>
                                                </form:select>
                                            </div>
                                            <div class="mb-3 ">
                                                <h3>Current Images</h3>

                                                <img id="selectedAvatar" src="/images/avatar/${newUser.avatar}"
                                                    class="rounded-circle"
                                                    style="width: 200px; height: 200px; object-fit: cover;"
                                                    alt="example placeholder" />
                                                <div class="d-flex justify-content-center">
                                                    <div data-mdb-ripple-init class="btn btn-primary btn-rounded">
                                                        <label class="form-label text-white m-1"
                                                            for="customFile2">Choose
                                                            file</label>
                                                        <input type="file" class="form-control d-none"
                                                            name="hoidanitFile" id="customFile2"
                                                            accept=".png, .jpg, .jpeg"
                                                            onchange="displaySelectedImage(event, 'selectedAvatar')" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12 mb-5">
                                                <button type="submit" class="btn btn-primary">Create</button>
                                            </div>
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
                <script src="/js/upload-image.js"></script>
            </body>

            </html>