<!-- JSP Path: src/main/webapp/WEB-INF/view/client/layout/footer.jsp -->
<!-- Footer Start -->

<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="spring"
uri="http://www.springframework.org/tags" %>

<div class="container-fluid footer-3tlap text-white-50 footer py-5">
  <div class="container py-5">
    <div
      class="pb-4 mb-4"
      style="border-bottom: 1px solid rgba(255, 255, 255, 0.2)"
    >
      <div class="row g-4">
        <div class="col-lg-4">
          <a
            href="<c:url value='/home' />"
            class="d-flex align-items-center text-decoration-none"
          >
            <h1 class="text-primary mb-0 logo-text-footer">
              <spring:message code="layout.footer.brandName" />
            </h1>
          </a>
          <p class="text-white-75 mt-3 mb-0">
            <spring:message code="layout.footer.brandSlogan" />
          </p>
        </div>
        <div class="col-lg-5">
          <h5 class="text-light mb-3">
            <spring:message code="layout.footer.newsletter.title" />
          </h5>
          <p class="text-white-75">
            <spring:message code="layout.footer.newsletter.description" />
          </p>
          <div class="position-relative mx-auto" style="max-width: 400px">
            <spring:message
              code="layout.footer.newsletter.placeholder.email"
              var="newsletterEmailPlaceholder"
            />
            <input
              class="form-control border-0 w-100 py-3 ps-4 pe-5 rounded-pill"
              type="email"
              placeholder="${newsletterEmailPlaceholder}"
            />
            <button
              type="button"
              class="btn btn-primary py-2 px-3 position-absolute top-0 end-0 mt-2 me-2 rounded-pill"
            >
              <spring:message
                code="layout.footer.newsletter.button.subscribe"
              />
            </button>
          </div>
        </div>
        <div class="col-lg-3">
          <h5 class="text-light mb-3 pt-3 pt-lg-0">
            <spring:message code="layout.footer.connect.title" />
          </h5>
          <div class="d-flex justify-content-start justify-content-lg-end">
            <spring:message
              code="layout.footer.connect.facebook.title"
              var="facebookTitle"
            />
            <a
              class="btn btn-outline-light btn-social me-2"
              href="#"
              title="${facebookTitle}"
              ><i class="fab fa-facebook-f"></i
            ></a>
            <spring:message
              code="layout.footer.connect.youtube.title"
              var="youtubeTitle"
            />
            <a
              class="btn btn-outline-light btn-social me-2"
              href="#"
              title="${youtubeTitle}"
              ><i class="fab fa-youtube"></i
            ></a>
            <spring:message
              code="layout.footer.connect.instagram.title"
              var="instagramTitle"
            />
            <a
              class="btn btn-outline-light btn-social me-2"
              href="#"
              title="${instagramTitle}"
              ><i class="fab fa-instagram"></i
            ></a>
            <spring:message
              code="layout.footer.connect.tiktok.title"
              var="tiktokTitle"
            />
            <a
              class="btn btn-outline-light btn-social"
              href="#"
              title="${tiktokTitle}"
              ><i class="fab fa-tiktok"></i
            ></a>
          </div>
        </div>
      </div>
    </div>
    <div class="row g-5">
      <div class="col-lg-3 col-md-6">
        <div class="footer-item">
          <h4 class="text-light mb-4">
            <spring:message code="layout.footer.section.about.title" />
          </h4>
          <a class="btn-link" href="<c:url value='/about-us'/>"
            ><spring:message code="layout.footer.section.about.intro"
          /></a>
          <a class="btn-link" href="<c:url value='/careers'/>"
            ><spring:message code="layout.footer.section.about.careers"
          /></a>
          <a class="btn-link" href="<c:url value='/store-locations'/>"
            ><spring:message code="layout.footer.section.about.stores"
          /></a>
          <a class="btn-link" href="<c:url value='/contact-us'/>"
            ><spring:message code="layout.footer.section.about.contact"
          /></a>
        </div>
      </div>
      <div class="col-lg-3 col-md-6">
        <div class="footer-item">
          <h4 class="text-light mb-4">
            <spring:message code="layout.footer.section.support.title" />
          </h4>
          <a class="btn-link" href="<c:url value='/faq'/>"
            ><spring:message code="layout.footer.section.support.faq"
          /></a>
          <a class="btn-link" href="<c:url value='/how-to-order'/>"
            ><spring:message code="layout.footer.section.support.howToOrder"
          /></a>
          <a class="btn-link" href="<c:url value='/payment-methods'/>"
            ><spring:message
              code="layout.footer.section.support.paymentMethods"
          /></a>
          <a class="btn-link" href="<c:url value='/shipping-policy'/>"
            ><spring:message
              code="layout.footer.section.support.shippingPolicy"
          /></a>
        </div>
      </div>
      <div class="col-lg-3 col-md-6">
        <div class="footer-item">
          <h4 class="text-light mb-4">
            <spring:message code="layout.footer.section.policies.title" />
          </h4>
          <a class="btn-link" href="<c:url value='/warranty-policy'/>"
            ><spring:message code="layout.footer.section.policies.warranty"
          /></a>
          <a class="btn-link" href="<c:url value='/return-policy'/>"
            ><spring:message code="layout.footer.section.policies.return"
          /></a>
          <a class="btn-link" href="<c:url value='/privacy-policy'/>"
            ><spring:message code="layout.footer.section.policies.privacy"
          /></a>
          <a class="btn-link" href="<c:url value='/terms-conditions'/>"
            ><spring:message code="layout.footer.section.policies.terms"
          /></a>
        </div>
      </div>
      <div class="col-lg-3 col-md-6">
        <div class="footer-item">
          <h4 class="text-light mb-4">
            <spring:message code="layout.footer.section.contact3T.title" />
          </h4>
          <p>
            <i class="fas fa-map-marker-alt me-2"></i
            ><spring:message code="layout.footer.section.contact3T.address" />
          </p>
          <p>
            <i class="fas fa-envelope me-2"></i
            ><spring:message code="layout.footer.section.contact3T.email" />
          </p>
          <p>
            <i class="fas fa-phone-alt me-2"></i
            ><spring:message code="layout.footer.section.contact3T.phone" />
          </p>
          <div class="mt-3">
            <p class="mb-2">
              <spring:message
                code="layout.footer.section.contact3T.paymentAccepted"
              />
            </p>
            <spring:message
              code="layout.footer.section.contact3T.paymentMethodsAlt"
              var="paymentAlt"
            />
            <img
              src="<c:url value='/client/img/payment.png'/>"
              class="img-fluid"
              alt="${paymentAlt}"
              style="max-width: 200px"
            />
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- Footer End -->

<!-- Copyright Start -->
<div class="container-fluid copyright-3tlap bg-dark py-4">
  <div class="container">
    <div class="row">
      <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
        <span class="text-light"
          ><a href="<c:url value='/home'/>" class="text-primary"
            ><i class="fas fa-copyright text-primary me-2"></i
            ><spring:message code="layout.footer.copyright.brand"
          /></a>
          <spring:message code="layout.footer.copyright.rightsReserved"
        /></span>
      </div>
      <div class="col-md-6 my-auto text-center text-md-end text-white-50">
        <spring:message code="layout.footer.copyright.developedBy" />
        <a class="border-bottom text-white-75" href="#"
          ><spring:message code="layout.footer.copyright.developerName"
        /></a>
      </div>
    </div>
  </div>
</div>
<!-- Copyright End -->
