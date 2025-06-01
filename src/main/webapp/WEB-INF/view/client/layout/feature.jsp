<%--src/main/webapp/WEB-INF/view/client/layout/feature.jsp--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- Featurs Section Start -->
<div class="container-fluid featurs-3tlap py-5">
  <div class="container py-5">
    <div class="row g-4 justify-content-center">
      <div class="col-md-6 col-lg-3 wow fadeInUp" data-wow-delay="0.1s">
        <div class="featurs-item text-center rounded bg-light p-4 h-100">
          <div
                  class="featurs-icon btn-square rounded-circle bg-primary mb-4 mx-auto"
          >
            <i class="fas fa-shipping-fast fa-3x text-white"></i>
          </div>
          <div class="featurs-content text-center">
            <h5><spring:message code="section.features.fastShipping.title"/></h5>
            <p class="mb-0 text-muted">
              <spring:message code="section.features.fastShipping.description"/>
            </p>
          </div>
        </div>
      </div>
      <div class="col-md-6 col-lg-3 wow fadeInUp" data-wow-delay="0.3s">
        <div class="featurs-item text-center rounded bg-light p-4 h-100">
          <div
                  class="featurs-icon btn-square rounded-circle bg-primary mb-4 mx-auto"
          >
            <i class="fas fa-shield-alt fa-3x text-white"></i>
          </div>
          <div class="featurs-content text-center">
            <h5><spring:message code="section.features.securePayment.title"/></h5>
            <p class="mb-0 text-muted">
              <spring:message code="section.features.securePayment.description"/>
            </p>
          </div>
        </div>
      </div>
      <div class="col-md-6 col-lg-3 wow fadeInUp" data-wow-delay="0.5s">
        <div class="featurs-item text-center rounded bg-light p-4 h-100">
          <div
                  class="featurs-icon btn-square rounded-circle bg-primary mb-4 mx-auto"
          >
            <i class="fas fa-award fa-3x text-white"></i>
          </div>
          <div class="featurs-content text-center">
            <h5><spring:message code="section.features.genuineWarranty.title"/></h5>
            <p class="mb-0 text-muted">
              <spring:message code="section.features.genuineWarranty.description"/>
            </p>
          </div>
        </div>
      </div>
      <div class="col-md-6 col-lg-3 wow fadeInUp" data-wow-delay="0.7s">
        <div class="featurs-item text-center rounded bg-light p-4 h-100">
          <div
                  class="featurs-icon btn-square rounded-circle bg-primary mb-4 mx-auto"
          >
            <i class="fas fa-headset fa-3x text-white"></i>
          </div>
          <div class="featurs-content text-center">
            <h5><spring:message code="section.features.support247.title"/></h5>
            <p class="mb-0 text-muted">
              <spring:message code="section.features.support247.description"/>
            </p>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- Featurs Section End -->