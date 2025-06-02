<%--src/main/webapp/WEB-INF/view/client/contact/show.jsp--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="utf-8" />
    <title><spring:message code="page.contact.meta.title"/></title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <meta
      content="<spring:message code="page.contact.meta.keywords"/>"
      name="keywords"
    />
    <meta
      content="<spring:message code="page.contact.meta.description"/>"
      name="description"
    />

    <jsp:include page="../layout/common_head_links.jsp" />
    <style>
      .contact-page-header {
        background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
          url('<c:url value="/client/img/contacus.jpg"/>');
        background-position: center center;
        background-repeat: no-repeat;
        background-size: cover;
      }
      .contact-info-item {
        display: flex;
        align-items: flex-start;
        margin-bottom: 1.5rem;
        padding: 1.5rem;
        background-color: var(--light-bg-color);
        border-radius: 0.5rem;
        box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
      }
      .contact-info-icon {
        font-size: 1.8rem;
        color: var(--primary-color);
        margin-right: 1rem;
        flex-shrink: 0;
        width: 40px;
        text-align: center;
      }
      .contact-info-content h5 {
        font-family: var(--font-primary);
        font-weight: 600;
        color: var(--text-color);
        margin-bottom: 0.3rem;
      }
      .contact-info-content p {
        margin-bottom: 0.2rem;
        color: var(--text-muted-color);
        font-size: 0.95rem;
      }
      .contact-info-content a {
        color: var(--primary-color);
        text-decoration: none;
      }
      .contact-info-content a:hover {
        text-decoration: underline;
      }
      .map-container {
        border-radius: 0.5rem;
        overflow: hidden;
        border: 1px solid var(--border-color);
        height: 400px;
      }
      .map-container iframe {
        width: 100%;
        height: 100%;
        border: 0;
      }
      .contact-form-section {
        background-color: #ffffff;
        padding: 2rem;
        border-radius: 0.5rem;
        box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1);
      }
      .contact-form-section h3 {
        color: var(--primary-color);
        margin-bottom: 1.5rem;
        text-align: center;
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
    <div class="container-fluid page-header contact-page-header py-5">
      <h1 class="text-center text-white display-5"><spring:message code="page.contact.header.title"/></h1>
      <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item">
          <a href="<c:url value='/'/>"><spring:message code="page.contact.breadcrumb.home"/></a>
        </li>
        <li class="breadcrumb-item active text-white"><spring:message code="page.contact.breadcrumb.contact"/></li>
      </ol>
    </div>

    <div class="container-fluid contact py-5">
      <div class="container py-5">
        <div class="row g-5">
          <div class="col-lg-7">
            <div class="contact-form-section">
              <h3><spring:message code="page.contact.form.title"/></h3>
              <p class="mb-4 text-center text-muted">
                <spring:message code="page.contact.form.description"/>
              </p>
              <%-- FORM LIÊN HỆ (PLACEHOLDER) - Sẽ cần backend để xử lý... không
              cần cũng được hè hè --%>
              <form action="#" method="post">
                <%-- Sửa action khi có backend --%>
                <div class="row g-3">
                  <div class="col-md-6">
                    <div class="form-floating">
                      <input
                        type="text"
                        class="form-control"
                        id="name"
                        placeholder="<spring:message code="page.contact.form.placeholder.name"/>"
                        required
                      />
                      <label for="name"><spring:message code="page.contact.form.label.name"/></label>
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="form-floating">
                      <input
                        type="email"
                        class="form-control"
                        id="email"
                        placeholder="<spring:message code="page.contact.form.placeholder.email"/>"
                        required
                      />
                      <label for="email"><spring:message code="page.contact.form.label.email"/></label>
                    </div>
                  </div>
                  <div class="col-12">
                    <div class="form-floating">
                      <input
                        type="text"
                        class="form-control"
                        id="subject"
                        placeholder="<spring:message code="page.contact.form.placeholder.subject"/>"
                        required
                      />
                      <label for="subject"><spring:message code="page.contact.form.label.subject"/></label>
                    </div>
                  </div>
                  <div class="col-12">
                    <div class="form-floating">
                      <textarea
                        class="form-control"
                        placeholder="<spring:message code="page.contact.form.placeholder.message"/>"
                        id="message"
                        style="height: 150px"
                        required
                      ></textarea>
                      <label for="message"><spring:message code="page.contact.form.label.message"/></label>
                    </div>
                  </div>
                  <div class="col-12 text-center">
                    <button
                      class="btn btn-primary rounded-pill py-3 px-5"
                      type="submit"
                    >
                      <spring:message code="page.contact.form.button.submit"/>
                    </button>
                  </div>
                </div>
              </form>
            </div>
          </div>

          <div class="col-lg-5">
            <h4 class="mb-4"><spring:message code="page.contact.info.title"/></h4>
            <div class="contact-info-item">
              <div class="contact-info-icon">
                <i class="fas fa-map-marker-alt"></i>
              </div>
              <div class="contact-info-content">
                <h5><spring:message code="page.contact.info.address.title"/></h5>
                <p><spring:message code="page.contact.info.address.line1"/></p>
                <p>
                  <a
                    href="https://maps.google.com/?q=123+Đường+ABC,+Phường+XYZ,+Quận+1,+TP.+Hồ+Chí+Minh"
                    target="_blank"
                    ><spring:message code="page.contact.info.address.mapLink"/></a
                  >
                </p>
              </div>
            </div>
            <div class="contact-info-item">
              <div class="contact-info-icon">
                <i class="fas fa-envelope"></i>
              </div>
              <div class="contact-info-content">
                <h5><spring:message code="page.contact.info.email.title"/></h5>
                <p><a href="mailto:support@3tlap.vn">support@3tlap.vn</a></p>
                <p>
                  <a href="mailto:sales@3tlap.vn">
                    <spring:message code="page.contact.info.email.sales"/></a>
                </p>
              </div>
            </div>
            <div class="contact-info-item">
              <div class="contact-info-icon">
                <i class="fas fa-phone-alt"></i>
              </div>
              <div class="contact-info-content">
                <h5><spring:message code="page.contact.info.phone.title"/></h5>
                <p><a href="tel:+8419008888"><spring:message code="page.contact.info.phone.general"/></a> </p>
                <p>
                  <a href="tel:+84901234567"><spring:message code="page.contact.info.phone.techSupport"/></a>
                </p>
              </div>
            </div>
            <div class="contact-info-item">
              <div class="contact-info-icon">
                <i class="fas fa-clock"></i>
              </div>
              <div class="contact-info-content">
                <h5><spring:message code="page.contact.info.hours.title"/></h5>
                <p><spring:message code="page.contact.info.hours.weekdays"/></p>
                <p><spring:message code="page.contact.info.hours.sunday"/></p>
              </div>
            </div>
          </div>

          <div class="col-12 mt-5">
            <div class="map-container">
              <iframe
                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3919.285394621375!2d106.69815377480514!3d10.789439889360121!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x317528b545b5903b%3A0x2381a6fe3f690419!2sPosts%20and%20Telecommunication%20Institute%20of%20Technology%20-%20Ho%20Chi%20Minh%20City%20Campus!5e0!3m2!1sen!2s!4v1748522327939!5m2!1sen!2s"
                width="600"
                height="450"
                style="border: 0"
                allowfullscreen=""
                loading="lazy"
                referrerpolicy="no-referrer-when-downgrade"
              ></iframe>
            </div>
          </div>
        </div>
      </div>
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
