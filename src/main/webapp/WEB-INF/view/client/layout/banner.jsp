<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Hero Start -->
<div class="container-fluid py-5 mb-5 hero-header-3tlap">
  <div class="container py-5">
    <div class="row g-5 align-items-center mt-5">
      <div class="col-md-12 col-lg-7">
        <h4 class="mb-3 text-secondary animated slideInDown">
          3TLAP - ĐỈNH CAO CÔNG NGHỆ
        </h4>
        <h1 class="mb-4 display-3 text-primary animated slideInDown">
          Hiệu Năng Vượt Trội,<br />Giá Cả Tối Ưu
        </h1>
        <p
          class="mb-4 animated slideInDown"
          style="color: var(--text-muted-color)"
        >
          Khám phá bộ sưu tập laptop mới nhất từ các thương hiệu hàng đầu. Dù
          bạn là game thủ, nhà thiết kế hay dân văn phòng, 3TLap luôn có sản
          phẩm phù hợp.
        </p>
        <div class="animated slideInDown">
          <a
            href="<c:url value='/products'/>"
            class="btn btn-primary btn-lg rounded-pill py-3 px-5 me-3"
            >Xem Tất Cả Laptop</a
          >
          <%--
          <a
            href="#top-deals"
            class="btn btn-outline-secondary btn-lg rounded-pill py-3 px-5"
            >Ưu Đãi Hot</a
          >
          --%>
        </div>
      </div>
      <div class="col-md-12 col-lg-5">
        <div id="hero-carousel" class="carousel slide" data-bs-ride="carousel">
          <div class="carousel-indicators">
            <button
              type="button"
              data-bs-target="#hero-carousel"
              data-bs-slide-to="0"
              class="active"
              aria-current="true"
              aria-label="Slide 1"
            ></button>
            <button
              type="button"
              data-bs-target="#hero-carousel"
              data-bs-slide-to="1"
              aria-label="Slide 2"
            ></button>
            <button
              type="button"
              data-bs-target="#hero-carousel"
              data-bs-slide-to="2"
              aria-label="Slide 3"
            ></button>
          </div>
          <div class="carousel-inner rounded shadow-lg" role="listbox">
            <div class="carousel-item active">
              <%-- TODO: Thay bằng ảnh banner phù hợp --%>
              <img
                src="<c:url value='/client/img/hero-img-1.png'/>"
                class="d-block w-100"
                alt="Laptop Gaming Hiệu Năng Cao"
              />
              <div class="carousel-caption d-none d-md-block">
                <h5>Laptop Gaming Mới Nhất</h5>
                <p>Chinh phục mọi tựa game đỉnh cao.</p>
              </div>
            </div>
            <div class="carousel-item">
              <%-- TODO: Thay bằng ảnh banner phù hợp --%>
              <img
                src="<c:url value='/client/img/hero-img-3.png'/>"
                class="d-block w-100"
                alt="Laptop Văn Phòng Mỏng Nhẹ"
              />
              <div class="carousel-caption d-none d-md-block">
                <h5>Laptop Văn Phòng Thanh Lịch</h5>
                <p>Hiệu suất ổn định, thiết kế tinh tế.</p>
              </div>
            </div>
            <div class="carousel-item">
              <%-- TODO: Thay bằng ảnh banner phù hợp --%>
              <img
                src="<c:url value='/client/img/hero-img-2.png'/>"
                class="d-block w-100"
                alt="Ưu Đãi Laptop Đặc Biệt"
              />
              <div class="carousel-caption d-none d-md-block">
                <h5>Ưu Đãi Khủng Cuối Tuần</h5>
                <p>Đừng bỏ lỡ cơ hội sở hữu laptop giá tốt.</p>
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
            <span class="visually-hidden">Previous</span>
          </button>
          <button
            class="carousel-control-next"
            type="button"
            data-bs-target="#hero-carousel"
            data-bs-slide="next"
          >
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
          </button>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- Hero End -->
