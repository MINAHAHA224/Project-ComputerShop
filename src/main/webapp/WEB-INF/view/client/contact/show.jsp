<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="utf-8" />
    <title>Liên Hệ - 3TLap | Cửa Hàng Laptop Uy Tín</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <meta
      content="Liên hệ 3TLap, địa chỉ cửa hàng laptop, số điện thoại laptopshop, email hỗ trợ"
      name="keywords"
    />
    <meta
      content="Thông tin liên hệ chính thức của 3TLap. Chúng tôi luôn sẵn sàng hỗ trợ bạn!"
      name="description"
    />

    <jsp:include page="../layout/common_head_links.jsp" />
    <style>
      .contact-page-header {
        background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
          url('<c:url value="/client/img/placeholder/contact-banner.jpg"/>');
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

    <div class="container-fluid page-header contact-page-header py-5">
      <h1 class="text-center text-white display-5">Liên Hệ Với Chúng Tôi</h1>
      <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item">
          <a href="<c:url value='/home'/>">Trang Chủ</a>
        </li>
        <li class="breadcrumb-item active text-white">Liên Hệ</li>
      </ol>
    </div>

    <div class="container-fluid contact py-5">
      <div class="container py-5">
        <div class="row g-5">
          <div class="col-lg-7">
            <div class="contact-form-section">
              <h3>Gửi Lời Nhắn Cho 3TLap</h3>
              <p class="mb-4 text-center text-muted">
                Chúng tôi luôn sẵn lòng lắng nghe ý kiến và giải đáp thắc mắc
                của bạn. Vui lòng điền thông tin vào form dưới đây hoặc liên hệ
                trực tiếp qua các kênh khác.
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
                        placeholder="Họ và Tên"
                        required
                      />
                      <label for="name">Họ và Tên</label>
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="form-floating">
                      <input
                        type="email"
                        class="form-control"
                        id="email"
                        placeholder="Địa chỉ Email"
                        required
                      />
                      <label for="email">Địa chỉ Email</label>
                    </div>
                  </div>
                  <div class="col-12">
                    <div class="form-floating">
                      <input
                        type="text"
                        class="form-control"
                        id="subject"
                        placeholder="Tiêu đề"
                        required
                      />
                      <label for="subject">Tiêu đề</label>
                    </div>
                  </div>
                  <div class="col-12">
                    <div class="form-floating">
                      <textarea
                        class="form-control"
                        placeholder="Nội dung lời nhắn"
                        id="message"
                        style="height: 150px"
                        required
                      ></textarea>
                      <label for="message">Nội dung lời nhắn</label>
                    </div>
                  </div>
                  <div class="col-12 text-center">
                    <button
                      class="btn btn-primary rounded-pill py-3 px-5"
                      type="submit"
                    >
                      Gửi Lời Nhắn
                    </button>
                  </div>
                </div>
              </form>
            </div>
          </div>

          <div class="col-lg-5">
            <h4 class="mb-4">Thông Tin Liên Hệ</h4>
            <div class="contact-info-item">
              <div class="contact-info-icon">
                <i class="fas fa-map-marker-alt"></i>
              </div>
              <div class="contact-info-content">
                <h5>Địa Chỉ Cửa Hàng</h5>
                <p>123 Đường ABC, Phường XYZ, Quận 1, TP. Hồ Chí Minh</p>
                <p>
                  <a
                    href="https://maps.google.com/?q=123+Đường+ABC,+Phường+XYZ,+Quận+1,+TP.+Hồ+Chí+Minh"
                    target="_blank"
                    >Xem bản đồ</a
                  >
                </p>
              </div>
            </div>
            <div class="contact-info-item">
              <div class="contact-info-icon">
                <i class="fas fa-envelope"></i>
              </div>
              <div class="contact-info-content">
                <h5>Email Hỗ Trợ</h5>
                <p><a href="mailto:support@3tlap.vn">support@3tlap.vn</a></p>
                <p>
                  <a href="mailto:sales@3tlap.vn">sales@3tlap.vn</a> (Kinh
                  doanh)
                </p>
              </div>
            </div>
            <div class="contact-info-item">
              <div class="contact-info-icon">
                <i class="fas fa-phone-alt"></i>
              </div>
              <div class="contact-info-content">
                <h5>Hotline Tư Vấn</h5>
                <p><a href="tel:+8419008888">(+84) 1900 8888</a> (Tổng đài)</p>
                <p>
                  <a href="tel:+84901234567">(+84) 901 234 567</a> (Hỗ trợ kỹ
                  thuật)
                </p>
              </div>
            </div>
            <div class="contact-info-item">
              <div class="contact-info-icon">
                <i class="fas fa-clock"></i>
              </div>
              <div class="contact-info-content">
                <h5>Giờ Làm Việc</h5>
                <p>Thứ 2 - Thứ 7: 08:00 - 21:00</p>
                <p>Chủ Nhật: 09:00 - 18:00</p>
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

    <jsp:include page="../layout/footer.jsp" />
    <jsp:include page="../layout/common_scripts.jsp" />
  </body>
</html>
