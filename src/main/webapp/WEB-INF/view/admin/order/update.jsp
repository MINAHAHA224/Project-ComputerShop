<%--src/main/webapp/WEB-INF/view/admin/order/update.jsp--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <title>Cập Nhật Đơn Hàng #${orders.id} - 3TLap Admin</title>
    <jsp:include page="../layout/common_admin_head.jsp"/>
    <style>

        .order-status-stepper-main {
            padding: 1.5rem 0.5rem;
            margin-bottom: 2rem;
            border-bottom: 1px solid var(--current-admin-divider-color);
            background-color: var(--current-admin-card-bg);
            border-radius: 0.375rem;
            box-shadow: 0 0.1rem 0.3rem var(--current-admin-shadow-color-soft);
            margin-top: 1.5rem;
        }
       
    </style>
</head>

<body class="sb-nav-fixed admin-body-3tlap">
    <c:set var="breadcrumbCurrentPage" value="Cập Nhật Đơn Hàng" scope="request"/>
    <jsp:include page="../layout/header.jsp"/>

    <div id="layoutSidenav">
        <jsp:include page="../layout/navbar.jsp"/>
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <div class="d-flex justify-content-between align-items-center">
                         <h1 class="main-content-title mt-4">Cập Nhật Đơn Hàng #${orders.id}</h1>
                         <a href="<c:url value='/admin/order'/>" class="btn btn-outline-secondary btn-sm admin-btn-action mt-4">
                            <i class="fas fa-arrow-left me-1"></i> Quay Lại Danh Sách
                        </a>
                    </div>
                    
                    <div class="order-status-stepper-main">
                        <div class="steps-container">
                            <c:set var="currentStatusValue" value="${orders.status}"/>
                            <c:set var="statusFlow" value="${['PENDING', 'CONFIRMED', 'SHIPPED', 'DELIVERED']}" />
                            <c:set var="statusLabelsMap" value="${{'PENDING':'Chờ Xác Nhận', 'CONFIRMED':'Đã Xác Nhận', 'SHIPPED':'Đang Giao', 'DELIVERED':'Đã Giao'}}"/>
                            <c:set var="statusIconsMap" value="${{'PENDING':'far fa-clock', 'CONFIRMED':'fas fa-clipboard-check', 'SHIPPED':'fas fa-truck', 'DELIVERED':'fas fa-box-check'}}"/>

                            <c:set var="isCancelledOrder" value="${currentStatusValue == 'CANCELLED'}"/>
                            <c:set var="currentFlowIndex" value="-1"/>
                            <c:forEach var="flowStatus" items="${statusFlow}" varStatus="loop">
                                <c:if test="${flowStatus == currentStatusValue}">
                                    <c:set var="currentFlowIndex" value="${loop.index}"/>
                                </c:if>
                            </c:forEach>

                            <c:forEach var="stepStatus" items="${statusFlow}" varStatus="loop">
                                <div class="step-item 
                                    <c:if test='${loop.index <= currentFlowIndex && !isCancelledOrder}'>active</c:if> 
                                    <c:if test='${loop.index == currentFlowIndex && !isCancelledOrder}'>current</c:if>
                                    <c:if test='${isCancelledOrder}'>disabled</c:if>"
                                     data-status="${stepStatus}">
                                    <div class="step-icon-wrapper">
                                        <div class="step-icon">
                                            <c:choose>
                                                <c:when test="${loop.index < currentFlowIndex && !isCancelledOrder}"><i class="fas fa-check"></i></c:when>
                                                <c:when test="${loop.index == currentFlowIndex && !isCancelledOrder}"><i class="${statusIconsMap[stepStatus]}"></i></c:when>
                                                <c:otherwise><i class="${statusIconsMap[stepStatus]}"></i></c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    <div class="step-label">${statusLabelsMap[stepStatus]}</div>
                                </div>
                                <c:if test="${!loop.last}">
                                    <div class="step-connector <c:if test='${loop.index < currentFlowIndex && !isCancelledOrder}'>active</c:if> <c:if test='${isCancelledOrder}'>disabled</c:if>"></div>
                                </c:if>
                            </c:forEach>

                            <c:if test="${isCancelledOrder}">
                                 <div class="step-connector disabled"></div>
                                <div class="step-item cancelled active current" data-status="CANCELLED">
                                     <div class="step-icon-wrapper">
                                        <div class="step-icon"><i class="fas fa-times-circle"></i></div>
                                    </div>
                                    <div class="step-label">Đã Hủy</div>
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <ol class="breadcrumb mb-4 mt-3 bg-transparent p-0">
                        <li class="breadcrumb-item"><a href="<c:url value='/admin'/>">Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="<c:url value='/admin/order'/>">Đơn Hàng</a></li>
                        <li class="breadcrumb-item active">Cập Nhật Đơn Hàng</li>
                    </ol>
                    
                    <c:if test="${not empty messageSuccess}">
                        <div class="alert alert-success alert-dismissible fade show alert-profile" role="alert">
                            ${messageSuccess}<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>
                    <c:if test="${not empty messageError}">
                        <div class="alert alert-danger alert-dismissible fade show alert-profile" role="alert">
                            ${messageError}<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <div class="card admin-form-card">
                        <div class="card-header">
                            <h4>Chỉnh Sửa Thông Tin Đơn Hàng</h4>
                        </div>
                        <div class="card-body">
                            <form:form method="post" action="/admin/order/update" modelAttribute="orders">
                                <security:csrfInput />
                                <form:hidden path="id"/>
                                <form:hidden path="totalPrice"/> 
                                <form:hidden path="typePayment"/>

                                <div class="row g-4">
                                    <div class="col-lg-7"> 
                                         <h5 class="section-subtitle-admin mb-3">Thông Tin Người Nhận</h5>
                                         <div class="row gx-3">
                                            <div class="col-md-6 mb-3">
                                                <label for="receiverName" class="form-label">Tên người nhận <span class="text-danger">*</span></label>
                                                <form:input path="receiverName" cssClass="form-control" id="receiverName"/>
                                                <form:errors path="receiverName" cssClass="form-error"/>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label for="receiverPhone" class="form-label">Số điện thoại <span class="text-danger">*</span></label>
                                                <form:input path="receiverPhone" cssClass="form-control" id="receiverPhone"/>
                                                <form:errors path="receiverPhone" cssClass="form-error"/>
                                            </div>
                                        </div>
                                        <div class="mb-3">
                                            <label for="updateReceiverAddress" class="form-label">Địa chỉ <span class="text-danger">*</span></label>
                                            <div class="address-autocomplete-wrapper position-relative">
                                                <form:textarea path="receiverAddress" cssClass="form-control goong-address-input" id="updateReceiverAddress" rows="3" placeholder="Nhập địa chỉ để tìm gợi ý..."/>
                                                <div class="dropdown-menu goong-address-suggestions w-100" aria-labelledby="updateReceiverAddress"></div>
                                            </div>
                                            <form:errors path="receiverAddress" cssClass="form-error"/>
                                        </div>
                                    </div>
                                    <div class="col-lg-5"> 
                                        <h5 class="section-subtitle-admin mb-3">Trạng Thái & Thông Tin Đơn</h5>
                                        <div class="mb-3">
                                            <label class="form-label">Mã đơn hàng:</label>
                                            <p class="form-control-plaintext ps-0 py-1"><strong>#${orders.id}</strong></p>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Tổng tiền:</label>
                                            <p class="form-control-plaintext ps-0 py-1"><strong><fmt:formatNumber type="number" value="${orders.totalPrice}"/> đ</strong></p>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Phương thức thanh toán:</label>
                                            <p class="form-control-plaintext ps-0 py-1"><strong>${orders.typePayment}</strong></p>
                                        </div>
                                        <div class="mb-3">
                                            <label for="status" class="form-label">Trạng thái đơn hàng <span class="text-danger">*</span></label>
                                            <form:select path="status" cssClass="form-select" id="status">
                                                <form:option value="PENDING">Chờ xác nhận</form:option>
                                                <form:option value="CONFIRMED">Đã xác nhận</form:option>
                                                <form:option value="SHIPPED">Đang giao</form:option>
                                                <form:option value="DELIVERED">Đã giao</form:option>
                                                <form:option value="CANCELLED">Đã hủy</form:option>
                                            </form:select>
                                            <form:errors path="status" cssClass="form-error"/>
                                        </div>
                                        <div class="mb-3">
                                            <label for="statusPayment" class="form-label">Trạng thái thanh toán <span class="text-danger">*</span></label>
                                            <form:select path="statusPayment" cssClass="form-select" id="statusPayment">
                                                <form:option value="UNPAID">Chưa thanh toán</form:option>
                                                <form:option value="PAID">Đã thanh toán</form:option>
                                                <form:option value="REFUNDED">Đã hoàn tiền</form:option>
                                                <form:option value="FAILED">Thanh toán thất bại</form:option>
                                            </form:select>
                                            <form:errors path="statusPayment" cssClass="form-error"/>
                                        </div>
                                    </div>
                                </div>
                                
                                <hr class="my-4">
                                <div class="text-end">
                                    <a href="<c:url value='/admin/order'/>" class="btn btn-outline-secondary me-2 rounded-pill px-4 py-2">Hủy Bỏ</a>
                                    <button type="submit" class="btn btn-primary rounded-pill px-4 py-2">Lưu Thay Đổi</button>
                                </div>
                            </form:form>
                        </div>
                    </div>
                </div>
            </main>
            <jsp:include page="../../client/layout/chatbot_widget.jsp" />
            <jsp:include page="../layout/footer.jsp"/>
        </div>
    </div>

    <jsp:include page="../layout/common_admin_scripts.jsp"/>
    <script src="<c:url value='/client/js/goong-autocomplete.js'/>"></script>
    <script>
    document.addEventListener('DOMContentLoaded', function () {
        const statusDropdown = document.getElementById('status');
        const stepsContainer = document.querySelector('.order-status-stepper-main .steps-container');

        const statusFlow = ['PENDING', 'CONFIRMED', 'SHIPPED', 'DELIVERED'];
        const statusIcons = {
            'PENDING': 'far fa-clock',     
            'CONFIRMED': 'fas fa-clipboard-check', 
            'SHIPPED': 'fas fa-truck',          
            'DELIVERED': 'fas fa-box-check',    
            'CANCELLED': 'fas fa-times-circle' 
        };
     
        if (statusDropdown && stepsContainer) {
            const allStepItems = Array.from(stepsContainer.querySelectorAll('.step-item'));
            const allConnectors = stepsContainer.querySelectorAll('.step-connector');

            const updateStepperVisuals = (selectedStatusValue) => {
                let currentFlowStatusIndex = statusFlow.indexOf(selectedStatusValue);
                let isCancelledOrder = selectedStatusValue === 'CANCELLED';

                allStepItems.forEach((stepEl) => {
                    const stepDataStatus = stepEl.getAttribute('data-status');
                    const stepIndexInFlow = statusFlow.indexOf(stepDataStatus);
                    const iconElement = stepEl.querySelector('.step-icon i');

                    stepEl.classList.remove('active', 'current', 'disabled', 'cancelled');

                    if (isCancelledOrder) {
                        if (stepDataStatus === 'CANCELLED') {
                            stepEl.classList.add('active', 'current', 'cancelled');
                            if (iconElement) iconElement.className = statusIcons['CANCELLED'];
                        } else {
                            stepEl.classList.add('disabled');
                            if (iconElement && statusIcons[stepDataStatus]) iconElement.className = statusIcons[stepDataStatus];
                            else if (iconElement) iconElement.className = 'far fa-circle';
                        }
                    } else {
                        if (stepDataStatus === 'CANCELLED') {
                            stepEl.classList.add('disabled');
                            if (iconElement) iconElement.className = statusIcons['CANCELLED'];
                        } else if (stepIndexInFlow !== -1) {
                            if (stepIndexInFlow <= currentFlowStatusIndex) {
                                stepEl.classList.add('active');
                                if (iconElement) iconElement.className = 'fas fa-check';
                            } else {
                               if (iconElement && statusIcons[stepDataStatus]) iconElement.className = statusIcons[stepDataStatus];
                               else if (iconElement) iconElement.className = 'far fa-circle';
                            }

                            if (stepIndexInFlow === currentFlowStatusIndex) {
                                stepEl.classList.add('current');
                                if (iconElement && iconElement.className !== 'fas fa-check' && statusIcons[stepDataStatus]) {
                                     iconElement.className = statusIcons[stepDataStatus];
                                     if (selectedStatusValue === 'PENDING' || selectedStatusValue === 'CONFIRMED' || selectedStatusValue === 'SHIPPED') {
                                     } else {
                                         iconElement.classList.remove('fa-spin');
                                     }
                                } else if (iconElement && iconElement.className !== 'fas fa-check') {
                                     iconElement.className = 'fas fa-circle-notch fa-spin';
                                }
                            } else {
                                if (iconElement) iconElement.classList.remove('fa-spin');
                            }
                        }
                    }
                });

                allConnectors.forEach((connector, index) => {
                    connector.classList.remove('active', 'disabled');
                    if (isCancelledOrder) {
                        connector.classList.add('disabled');
                    } else {
                        if (index < currentFlowStatusIndex) {
                            connector.classList.add('active');
                        }
                    }
                });
            };

            statusDropdown.addEventListener('change', function() {
                updateStepperVisuals(this.value);
            });

            if (statusDropdown.value) {
                updateStepperVisuals(statusDropdown.value);
            }
        }
    });
    </script>
</body>
</html>
