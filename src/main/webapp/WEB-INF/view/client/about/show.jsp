<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="utf-8" />
    <title>Về Chúng Tôi - 3TLap | Kiến Tạo Tương Lai Số</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <meta
      content="Giới thiệu 3TLap, câu chuyện thương hiệu, tầm nhìn, sứ mệnh, giá trị cốt lõi laptopshop"
      name="keywords"
    />
    <meta
      content="Tìm hiểu về 3TLap - đơn vị cung cấp laptop hàng đầu với cam kết về chất lượng, uy tín và dịch vụ tận tâm."
      name="description"
    />

    <jsp:include page="../layout/common_head_links.jsp" />
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

    <div class="container-fluid page-header about-page-header py-5">
      <div class="container text-center">
        <h1 class="text-white animated slideInDown">Về 3TLap</h1>
        <p class="lead text-white-75 mb-0 animated slideInUp">
          Kiến Tạo Tương Lai Số Cùng Chúng Tôi
        </p>
      </div>
    </div>

    <div class="container-fluid section-padding">
      <div class="container">
        <div class="row align-items-center g-5">
          <div class="col-lg-6 wow fadeIn" data-wow-delay="0.1s">
            <img
              src="<c:url value='/client/img/about-story.png'/>"
              class="img-fluid rounded shadow-lg"
              alt="Câu chuyện 3TLap"
            />
          </div>
          <div class="col-lg-6 wow fadeIn text-content" data-wow-delay="0.5s">
            <h4 class="section-title">Câu Chuyện Của Chúng Tôi</h4>
            <h2 class="section-main-title mb-4">
              Hành Trình Mang Công Nghệ Đến Gần Bạn Hơn
            </h2>
            <p>
              Ra đời từ niềm đam mê mãnh liệt với công nghệ và khát vọng mang
              đến những sản phẩm laptop chất lượng nhất, 3TLap đã không ngừng nỗ
              lực để trở thành người bạn đồng hành tin cậy của mọi khách hàng
              trên con đường chinh phục thế giới số.
            </p>
            <p>
              Từ những ngày đầu thành lập, chúng tôi đã đặt ra mục tiêu không
              chỉ là một cửa hàng bán lẻ, mà còn là một trung tâm tư vấn, chia
              sẻ kiến thức và kết nối cộng đồng yêu công nghệ. Mỗi sản phẩm tại
              3TLap đều được lựa chọn kỹ lưỡng, đảm bảo nguồn gốc xuất xứ rõ
              ràng và chất lượng vượt trội.
            </p>
            <a
              href="<c:url value='/products'/>"
              class="btn btn-primary rounded-pill py-3 px-5 mt-3"
              >Khám Phá Sản Phẩm</a
            >
          </div>
        </div>
      </div>
    </div>

    <div class="container-fluid section-padding bg-light">
      <div class="container">
        <div class="row g-5">
          <div class="col-lg-6 wow fadeIn text-content" data-wow-delay="0.1s">
            <h4 class="section-title">Định Hướng Phát Triển</h4>
            <h2 class="section-main-title mb-4">Tầm Nhìn & Sứ Mệnh</h2>
            <h5>Tầm Nhìn</h5>
            <p>
              Trở thành biểu tượng hàng đầu tại Việt Nam trong lĩnh vực cung cấp
              giải pháp công nghệ và laptop, nơi khách hàng luôn tìm thấy sự tin
              cậy, sản phẩm đột phá và dịch vụ xuất sắc.
            </p>
            <h5 class="mt-4">Sứ Mệnh</h5>
            <p>
              Với 3TLap, sứ mệnh của chúng tôi là "Nâng tầm trải nghiệm số" cho
              mỗi cá nhân và doanh nghiệp. Chúng tôi cam kết mang đến những sản
              phẩm công nghệ tiên tiến, phù hợp với mọi nhu cầu, cùng dịch vụ tư
              vấn và hỗ trợ tận tâm, giúp khách hàng khai thác tối đa tiềm năng
              của công nghệ trong công việc và cuộc sống.
            </p>
          </div>
          <div class="col-lg-6 wow fadeIn" data-wow-delay="0.5s">
            <img
              src="<c:url value='/client/img/about-vision.png'/>"
              class="img-fluid rounded shadow-lg"
              alt="Tầm nhìn 3TLap"
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
          <h4 class="section-title">Nền Tảng Vững Chắc</h4>
          <h2 class="section-main-title mb-5">Giá Trị Cốt Lõi Của 3TLap</h2>
        </div>
        <div class="row g-4 justify-content-center">
          <div class="col-md-6 col-lg-3 wow fadeInUp" data-wow-delay="0.2s">
            <div class="value-item">
              <div class="icon-circle"><i class="fas fa-medal"></i></div>
              <h5>Chất Lượng</h5>
              <p>Cam kết 100% sản phẩm chính hãng, nguồn gốc rõ ràng.</p>
            </div>
          </div>
          <div class="col-md-6 col-lg-3 wow fadeInUp" data-wow-delay="0.4s">
            <div class="value-item">
              <div class="icon-circle"><i class="fas fa-handshake"></i></div>
              <h5>Uy Tín</h5>
              <p>Minh bạch thông tin, đặt lợi ích khách hàng lên hàng đầu.</p>
            </div>
          </div>
          <div class="col-md-6 col-lg-3 wow fadeInUp" data-wow-delay="0.6s">
            <div class="value-item">
              <div class="icon-circle"><i class="fas fa-heart"></i></div>
              <h5>Tận Tâm</h5>
              <p>
                Đội ngũ tư vấn chuyên nghiệp, hỗ trợ chu đáo trước và sau bán
                hàng.
              </p>
            </div>
          </div>
          <div class="col-md-6 col-lg-3 wow fadeInUp" data-wow-delay="0.8s">
            <div class="value-item">
              <div class="icon-circle"><i class="fas fa-lightbulb"></i></div>
              <h5>Đổi Mới</h5>
              <p>
                Luôn cập nhật công nghệ và sản phẩm mới nhất trên thị trường.
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="container-fluid cta-section text-white text-center py-5">
      <div class="container py-4">
        <div class="wow fadeInUp" data-wow-delay="0.1s">
          <h2 class="section-main-title text-white mb-4">
            Sẵn Sàng Nâng Cấp Trải Nghiệm Số Của Bạn?
          </h2>
          <p class="lead mb-4 mx-auto" style="max-width: 700px">
            Khám phá ngay hàng ngàn mẫu laptop đa dạng tại 3TLap hoặc liên hệ
            với đội ngũ chuyên gia của chúng tôi để được tư vấn giải pháp phù
            hợp nhất.
          </p>
          <a
            href="<c:url value='/products'/>"
            class="btn btn-outline-light rounded-pill py-3 px-5 me-0 me-sm-3 mb-3 mb-sm-0"
            >Xem Tất Cả Laptop</a
          >
          <a
            href="<c:url value='/contact-us'/>"
            class="btn btn-light text-primary rounded-pill py-3 px-5"
            >Liên Hệ Tư Vấn</a
          >
        </div>
      </div>
    </div>

    <jsp:include page="../layout/footer.jsp" />
    <jsp:include page="../layout/common_scripts.jsp" />
  </body>
</html>
