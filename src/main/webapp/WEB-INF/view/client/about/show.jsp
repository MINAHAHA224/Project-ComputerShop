
<%-- src/main/webapp/WEB-INF/view/client/about/show.jsp --%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
<head>
  <meta charset="utf-8" />
  <title><spring:message code="page.about.meta.title"/></title>
  <meta content="width=device-width, initial-scale=1.0" name="viewport" />
  <meta content="<spring:message code="page.about.meta.keywords"/>" name="keywords"/>
  <meta content="<spring:message code="page.about.meta.description"/>" name="description"/>

  <jsp:include page="../layout/common_head_links.jsp" />
  <%-- Styles giữ nguyên --%>
  <style>
    .about-page-header {
      background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)),
      url('<c:url value="/client/img/placeholder/about-banner.jpg"/>');
      background-position: center center;
      background-repeat: no-repeat;
      background-size: cover;
      padding-top: 150px;
      padding-bottom: 100px;
    }
    .about-page-header h1 {
      font-size: calc(2rem + 2.5vw);
      font-weight: 800;
    }
    .about-page-header p.lead {
      font-size: calc(1rem + 0.5vw);
      color: rgba(255, 255, 255, 0.85);
    }

    .section-padding {
      padding: 80px 0;
    }
    .section-title {
      font-family: var(--font-primary);
      font-weight: 700;
      color: var(--primary-color);
      margin-bottom: 1rem;
      font-size: 1.3rem;
      text-transform: uppercase;
      letter-spacing: 1px;
    }
    .section-main-title {
      font-family: var(--font-primary);
      font-weight: 700;
      font-size: 2.5rem;
      margin-bottom: 1.5rem;
      color: var(--text-color);
    }
    .text-content p {
      font-size: 1.05rem;
      line-height: 1.8;
      color: var(--text-muted-color);
      margin-bottom: 1rem;
    }

    .value-item {
      text-align: center;
      margin-bottom: 30px;
    }
    .value-item .icon-circle {
      width: 80px;
      height: 80px;
      background-color: rgba(var(--primary-rgb), 0.1);
      color: var(--primary-color);
      border-radius: 50%;
      display: inline-flex;
      align-items: center;
      justify-content: center;
      margin-bottom: 1rem;
      font-size: 2.5rem;
      transition: all 0.3s ease;
    }
    .value-item:hover .icon-circle {
      background-color: var(--primary-color);
      color: var(--white-color);
      transform: scale(1.1);
    }
    .value-item h5 {
      font-family: var(--font-primary);
      font-weight: 600;
      font-size: 1.2rem;
      margin-bottom: 0.5rem;
      color: var(--text-color);
    }
    .value-item p {
      font-size: 0.95rem;
      color: var(--text-muted-color);
    }

    .team-member img {
      border: 5px solid var(--light-bg-color);
      box-shadow: 0 0.25rem 0.75rem rgba(0, 0, 0, 0.1);
    }
    .team-member h5 {
      color: var(--primary-color);
    }
    .cta-section {
      background-color: var(--primary-color);
    }
  </style>
</head>

<body>
<div
        id="spinner"
        class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center"
>
  <div class="spinner-grow text-primary" role="status"></div>
</div>

<jsp:include page="../layout/header.jsp" />
<script type="text/javascript">
    window.productSearchData = JSON.parse('${dataSearchJson}'); 
    // Nếu dùng session: window.productSearchData = JSON.parse('${sessionScope.dataSearchJson}');
</script>



<div class="container-fluid page-header about-page-header py-5">
  <div class="container text-center">
    <h1 class="text-white animated slideInDown"><spring:message code="page.about.header.title"/></h1>
    <p class="lead text-white-75 mb-0 animated slideInUp">
      <spring:message code="page.about.header.subheading"/>
    </p>
  </div>
</div>

<div class="container-fluid section-padding">
  <div class="container">
    <div class="row align-items-center g-5">
      <div class="col-lg-6 wow fadeIn" data-wow-delay="0.1s">
        <spring:message code="page.about.story.alt.storyImage" var="storyImageAlt"/>
        <img
                src="<c:url value='/client/img/about-story.png'/>"
                class="img-fluid rounded shadow-lg"
                alt="${storyImageAlt}"
        />
      </div>
      <div class="col-lg-6 wow fadeIn text-content" data-wow-delay="0.5s">
        <h4 class="section-title"><spring:message code="page.about.story.sectionTitle"/></h4>
        <h2 class="section-main-title mb-4">
          <spring:message code="page.about.story.mainTitle"/>
        </h2>
        <p><spring:message code="page.about.story.paragraph1"/></p>
        <p><spring:message code="page.about.story.paragraph2"/></p>
        <a
                href="<c:url value='/products'/>"
                class="btn btn-primary rounded-pill py-3 px-5 mt-3"
        ><spring:message code="page.about.story.button.exploreProducts"/></a
        >
      </div>
    </div>
  </div>
</div>

<div class="container-fluid section-padding bg-light">
  <div class="container">
    <div class="row g-5">
      <div class="col-lg-6 wow fadeIn text-content" data-wow-delay="0.1s">
        <h4 class="section-title"><spring:message code="page.about.development.sectionTitle"/></h4>
        <h2 class="section-main-title mb-4"><spring:message code="page.about.development.mainTitle"/></h2>
        <h5><spring:message code="page.about.development.vision.title"/></h5>
        <p><spring:message code="page.about.development.vision.text"/></p>
        <h5 class="mt-4"><spring:message code="page.about.development.mission.title"/></h5>
        <p><spring:message code="page.about.development.mission.text"/></p>
      </div>
      <div class="col-lg-6 wow fadeIn" data-wow-delay="0.5s">
        <spring:message code="page.about.development.alt.visionImage" var="visionImageAlt"/>
        <img
                src="<c:url value='/client/img/about-vision.png'/>"
                class="img-fluid rounded shadow-lg"
                alt="${visionImageAlt}"
        />
      </div>
    </div>
  </div>
</div>

<div class="container-fluid section-padding">
  <div class="container">
    <div
            class="text-center mx-auto wow fadeInUp"
            data-wow-delay="0.1s"
            style="max-width: 700px"
    >
      <h4 class="section-title"><spring:message code="page.about.coreValues.sectionTitle"/></h4>
      <h2 class="section-main-title mb-5"><spring:message code="page.about.coreValues.mainTitle"/></h2>
    </div>
    <div class="row g-4 justify-content-center">
      <div class="col-md-6 col-lg-3 wow fadeInUp" data-wow-delay="0.2s">
        <div class="value-item">
          <div class="icon-circle"><i class="fas fa-medal"></i></div>
          <h5><spring:message code="page.about.coreValues.quality.title"/></h5>
          <p><spring:message code="page.about.coreValues.quality.text"/></p>
        </div>
      </div>
      <div class="col-md-6 col-lg-3 wow fadeInUp" data-wow-delay="0.4s">
        <div class="value-item">
          <div class="icon-circle"><i class="fas fa-handshake"></i></div>
          <h5><spring:message code="page.about.coreValues.trust.title"/></h5>
          <p><spring:message code="page.about.coreValues.trust.text"/></p>
        </div>
      </div>
      <div class="col-md-6 col-lg-3 wow fadeInUp" data-wow-delay="0.6s">
        <div class="value-item">
          <div class="icon-circle"><i class="fas fa-heart"></i></div>
          <h5><spring:message code="page.about.coreValues.dedication.title"/></h5>
          <p><spring:message code="page.about.coreValues.dedication.text"/></p>
        </div>
      </div>
      <div class="col-md-6 col-lg-3 wow fadeInUp" data-wow-delay="0.8s">
        <div class="value-item">
          <div class="icon-circle"><i class="fas fa-lightbulb"></i></div>
          <h5><spring:message code="page.about.coreValues.innovation.title"/></h5>
          <p><spring:message code="page.about.coreValues.innovation.text"/></p>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="container-fluid cta-section text-white text-center py-5">
  <div class="container py-4">
    <div class="wow fadeInUp" data-wow-delay="0.1s">
      <h2 class="section-main-title text-white mb-4">
        <spring:message code="page.about.cta.mainTitle"/>
      </h2>
      <p class="lead mb-4 mx-auto" style="max-width: 700px">
        <spring:message code="page.about.cta.description"/>
      </p>
      <a
              href="<c:url value='/products'/>"
              class="btn btn-outline-light rounded-pill py-3 px-5 me-0 me-sm-3 mb-3 mb-sm-0"
      ><spring:message code="page.about.cta.button.viewLaptops"/></a
      >
      <a
              href="<c:url value='/contact-us'/>"
              class="btn btn-light text-primary rounded-pill py-3 px-5"
      ><spring:message code="page.about.cta.button.contactSupport"/></a
      >
    </div>

    <div
      class="toast-container position-fixed top-0 end-0 p-3"
      style="z-index: 1100"
    ></div>

    <c:if test="${not empty param.messageSuccess || not empty messageSuccess}">
      <div
        id="toast-message-success"
        class="d-none"
        data-message="${param.messageSuccess}${messageSuccess}"
      ></div>
    </c:if>
    <c:if test="${not empty param.messageError || not empty messageError}">
      <div
        id="toast-message-error"
        class="d-none"
        data-message="${param.messageError}${messageError}"
      ></div>
    </c:if>
    <c:if
      test="${not empty requestScope['SPRING_REDIRECT_FLASH_ATTRIBUTES'].messageSuccess}"
    >
      <div
        id="flash-toast-message-success"
        class="d-none"
        data-message="${requestScope['SPRING_REDIRECT_FLASH_ATTRIBUTES'].messageSuccess}"
      ></div>
    </c:if>
    <c:if
      test="${not empty requestScope['SPRING_REDIRECT_FLASH_ATTRIBUTES'].messageError}"
    >
      <div
        id="flash-toast-message-error"
        class="d-none"
        data-message="${requestScope['SPRING_REDIRECT_FLASH_ATTRIBUTES'].messageError}"
      ></div>
    </c:if>

    <jsp:include page="../layout/chatbot_widget.jsp" />
    <jsp:include page="../layout/footer.jsp" />
    <jsp:include page="../layout/common_scripts.jsp" />
  </body>
</html>
