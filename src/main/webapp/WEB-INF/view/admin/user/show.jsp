
<!-- JSP Path: admin/user/show.jsp -->
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <title>Quản Lý Người Dùng - 3TLap Admin</title>
    <jsp:include page="../layout/common_admin_head.jsp"/>

    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet"/>
    
    <style>
        .table-actions .btn {
            margin-right: 0.3rem;
            padding: 0.3rem 0.6rem;
            font-size: 0.8rem;
        }
        .table-actions .btn i {
            margin-right: 0.3rem;
        }
        .table td, .table th {
            vertical-align: middle;
        }
    </style>
</head>

<body class="sb-nav-fixed admin-body-3tlap">
    <c:set var="breadcrumbCurrentPage" value="Quản Lý Người Dùng" scope="request"/>
    <jsp:include page="../layout/header.jsp"/>

    <div id="layoutSidenav">
        <jsp:include page="../layout/navbar.jsp"/>
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <h1 class="main-content-title mt-4">Danh Sách Người Dùng</h1>
                    
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <ol class="breadcrumb mb-0 bg-transparent p-0">
                            <li class="breadcrumb-item"><a href="<c:url value='/admin'/>">Dashboard</a></li>
                            <li class="breadcrumb-item active">Người Dùng</li>
                        </ol>
                        <security:authorize access="hasRole('ADMIN')">
                             <a href="<c:url value='/admin/user/create'/>" class="btn btn-primary btn-sm admin-btn-create">
                                <i class="fas fa-plus me-1"></i> Thêm Người Dùng Mới
                            </a>
                        </security:authorize>
                    </div>

           
                    <c:if test="${not empty messageSuccess}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            ${messageSuccess}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>
                    <c:if test="${not empty messageError}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            ${messageError}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <div class="card mb-4 admin-table-card">
                        <div class="card-header">
                            <i class="fas fa-table me-1"></i>
                            Danh sách chi tiết
                        </div>
                        <div class="card-body">
                            <table id="usersTable" class="table table-hover"> 
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Email</th>
                                        <th>Họ và Tên</th>
                                        <th>Vai Trò</th>
                                        <th class="text-center">Hành Động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="user" items="${listUser}">
                                        <tr>
                                            <td>${user.id}</td>
                                            <td><c:out value="${user.email}"/></td>
                                            <td><c:out value="${user.fullName}"/></td>
                                            <td>
                                                <span class="badge 
                                                    <c:choose>
                                                        <c:when test='${user.nameRole == "ADMIN"}'>bg-danger</c:when>
                                                        <c:when test='${user.nameRole == "USER"}'>bg-success</c:when>
                                                        <c:otherwise>bg-secondary</c:otherwise>
                                                    </c:choose>
                                                ">${user.nameRole}</span>
                                            </td>
                                            <td class="text-center table-actions">
                                                <a href="<c:url value='/admin/user/${user.id}'/>" class="btn btn-info btn-sm" title="Xem chi tiết">
                                                    <i class="fas fa-eye"></i>
                                                </a>
                                                <security:authorize access="hasRole('ADMIN')">
                                                    <a href="<c:url value='/admin/user/update/${user.id}'/>" class="btn btn-warning btn-sm" title="Cập nhật">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                      
                                                    <button type="button" class="btn btn-danger btn-sm" title="Xóa"
                                                            data-bs-toggle="modal" data-bs-target="#deleteUserModal"
                                                            data-user-id="${user.id}" data-user-name="${user.fullName}">
                                                        <i class="fas fa-trash-alt"></i>
                                                    </button>
                                                </security:authorize>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </main>

            <jsp:include page="../layout/footer.jsp"/>
        </div>
    </div>

    <!-- Delete Modal -->
    <security:authorize access="hasRole('ADMIN')">
        <div class="modal fade" id="deleteUserModal" tabindex="-1" aria-labelledby="deleteUserModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content admin-modal-content"> 
                    <div class="modal-header">
                        <h5 class="modal-title" id="deleteUserModalLabel">Xác Nhận Xóa Người Dùng</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        Bạn có chắc chắn muốn xóa người dùng <strong id="userNameToDelete"></strong> (ID: <span id="userIdToDelete"></span>)?
                        <br/>Hành động này không thể hoàn tác.
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Hủy Bỏ</button>
                        <form:form id="deleteUserForm" method="post" action=""> 
                            <security:csrfInput/>
                            <button type="submit" class="btn btn-danger">Xác Nhận Xóa</button>
                        </form:form>
                    </div>
                </div>
            </div>
        </div>
    </security:authorize>

    <jsp:include page="../layout/common_admin_scripts.jsp"/> 
    
    
    <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {

            var deleteUserModal = document.getElementById('deleteUserModal');
            if (deleteUserModal) {
                deleteUserModal.addEventListener('show.bs.modal', function (event) {
                    var button = event.relatedTarget;
                    var userId = button.getAttribute('data-user-id');
                    var userName = button.getAttribute('data-user-name');
                    
                    var modalTitle = deleteUserModal.querySelector('.modal-title');
                    var modalBodyUserId = deleteUserModal.querySelector('#userIdToDelete');
                    var modalBodyUserName = deleteUserModal.querySelector('#userNameToDelete');
                    var deleteForm = deleteUserModal.querySelector('#deleteUserForm');

                    modalBodyUserId.textContent = userId;
                    modalBodyUserName.textContent = userName;
                  
                    deleteForm.action = '<c:url value="/admin/user/delete"/>/' + userId; 
                });
            }
        });
    </script>
</body>
</html>