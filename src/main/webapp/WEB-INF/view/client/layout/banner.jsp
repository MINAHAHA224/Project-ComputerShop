<%--src/main/webapp/WEB-INF/view/client/layout/banner.jsp--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- Hero Start -->
<div class="container-fluid py-5 mb-5 hero-header-3tlap">
  <div class="container py-5">
    <div class="row g-5 align-items-center mt-5">
      <div class="col-md-12 col-lg-7">
        <h4 class="mb-3 text-secondary animated slideInDown">
          <spring:message code="section.hero.subheading"/>
        </h4>
        <h1 class="mb-4 display-3 text-primary animated slideInDown">
          <spring:message code="section.hero.mainHeading.line1"/><br />
          <spring:message code="section.hero.mainHeading.line2"/>
        </h1>
        <p
                class="mb-4 animated slideInDown"
                style="color: var(--text-muted-color)"
        >
          <spring:message code="section.hero.description"/>
        </p>
        <div class="animated slideInDown">
          <a
                  href="<c:url value='/products'/>"
                  class="btn btn-primary btn-lg rounded-pill py-3 px-5 me-3"
          ><spring:message code="section.hero.button.viewAllLaptops"/></a
          >
          <%--
          <a
            href="#top-deals"
            class="btn btn-outline-secondary btn-lg rounded-pill py-3 px-5"
            ><spring:message code="section.hero.button.hotDeals"/></a
          >
          --%>
        </div>
      </div>
      <div class="col-md-12 col-lg-5">
        <div id="hero-carousel" class="carousel slide" data-bs-ride="carousel">
          <div class="carousel-indicators">
            <spring:message code="section.hero.carousel.slide1.ariaLabel" var="slide1AriaLabel"/>
            <button
                    type="button"
                    data-bs-target="#hero-carousel"
                    data-bs-slide-to="0"
                    class="active"
                    aria-current="true"
                    aria-label="${slide1AriaLabel}"
            ></button>
            <spring:message code="section.hero.carousel.slide2.ariaLabel" var="slide2AriaLabel"/>
            <button
                    type="button"
                    data-bs-target="#hero-carousel"
                    data-bs-slide-to="1"
                    aria-label="${slide2AriaLabel}"
            ></button>
            <spring:message code="section.hero.carousel.slide3.ariaLabel" var="slide3AriaLabel"/>
            <button
                    type="button"
                    data-bs-target="#hero-carousel"
                    data-bs-slide-to="2"
                    aria-label="${slide3AriaLabel}"
            ></button>
          </div>
          <div class="carousel-inner rounded shadow-lg" role="listbox">
            <div class="carousel-item active">
              <spring:message code="section.hero.carousel.item1.alt" var="item1Alt"/>
              <img
                      src="<c:url value='/client/img/hero-img-1.jpg'/>"
                      class="d-block w-100"
                      alt="${item1Alt}"
              />
              <div class="carousel-caption d-none d-md-block">
                <h5><spring:message code="section.hero.carousel.item1.caption.title"/></h5>
                <p><spring:message code="section.hero.carousel.item1.caption.description"/></p>
              </div>
            </div>
            <div class="carousel-item">
              <spring:message code="section.hero.carousel.item2.alt" var="item2Alt"/>
              <img
                      src="<c:url value='/client/img/hero-img-3.jpg'/>"
                      class="d-block w-100"
                      alt="${item2Alt}"
              />
              <div class="carousel-caption d-none d-md-block">
                <h5><spring:message code="section.hero.carousel.item2.caption.title"/></h5>
                <p><spring:message code="section.hero.carousel.item2.caption.description"/></p>
              </div>
            </div>
            <div class="carousel-item">
              <spring:message code="section.hero.carousel.item3.alt" var="item3Alt"/>
              <img
                      src="<c:url value='/client/img/hero-img-2.jpg'/>"
                      class="d-block w-100"
                      alt="${item3Alt}"
              />
              <div class="carousel-caption d-none d-md-block">
                <h5><spring:message code="section.hero.carousel.item3.caption.title"/></h5>
                <p><spring:message code="section.hero.carousel.item3.caption.description"/></p>
              </div>
            </div>
          </div>
          <button
                  class="carousel-control-prev"
                  type="button"
                  data-bs-target="#hero-carousel"
                  data-bs-slide="prev"
          >
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden"><spring:message code="section.hero.carousel.control.previous"/></span>
          </button>
          <button
                  class="carousel-control-next"
                  type="button"
                  data-bs-target="#hero-carousel"
                  data-bs-slide="next"
          >
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden"><spring:message code="section.hero.carousel.control.next"/></span>
          </button>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- Hero End -->