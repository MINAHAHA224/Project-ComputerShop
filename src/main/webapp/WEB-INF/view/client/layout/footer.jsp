<!-- JSP Path: client/layout/footer.jsp -->
<!-- Footer Start -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fn"
uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="container-fluid footer-3tlap text-white-50 footer py-5">
  <%-- Thay class và màu nền chính --%>
  <div class="container py-5">
    <div
      class="pb-4 mb-4"
      style="border-bottom: 1px solid rgba(255, 255, 255, 0.2)"
    >
      <div class="row g-4">
        <div class="col-lg-4">
          <%-- Tăng độ rộng cho phần logo/brand --%>
          <a
            href="<c:url value='/home' />"
            class="d-flex align-items-center text-decoration-none"
          >
            <%-- Logo Placeholder - Sẽ được style bằng CSS. Bạn có thể thay bằng
            thẻ <img /> nếu có logo --%>
            <h1 class="text-primary mb-0 logo-text-footer">3TLap</h1>
            <%--
            <img
              src="<c:url value='/client/img/logo-3tlap-white.png'/>"
              alt="3TLap Logo"
              height="40"
            />
            --%>
          </a>
          <p class="text-white-75 mt-3 mb-0">
            <%-- text-white-75 cho độ tương phản tốt hơn --%> Nơi mua sắm laptop
            uy tín với sản phẩm chính hãng, giá cả cạnh tranh và dịch vụ hậu mãi
            tận tâm.
          </p>
        </div>
        <div class="col-lg-5">
          <%-- Giảm độ rộng form newsletter --%>
          <h5 class="text-light mb-3">Đăng ký nhận tin</h5>
          <p class="text-white-75">
            Nhận thông tin khuyến mãi và sản phẩm mới nhất từ 3TLap.
          </p>
          <div class="position-relative mx-auto" style="max-width: 400px">
            <input
              class="form-control border-0 w-100 py-3 ps-4 pe-5 rounded-pill"
              type="email"
              placeholder="Địa chỉ email của bạn"
            />
            <button
              type="button"
              class="btn btn-primary py-2 px-3 position-absolute top-0 end-0 mt-2 me-2 rounded-pill"
            >
              Đăng Ký
            </button>
          </div>
        </div>
        <div class="col-lg-3">
          <h5 class="text-light mb-3 pt-3 pt-lg-0">Kết nối với chúng tôi</h5>
          <div class="d-flex justify-content-start justify-content-lg-end">
            <a
              class="btn btn-outline-light btn-social me-2"
              href="#"
              title="Facebook"
              ><i class="fab fa-facebook-f"></i
            ></a>
            <a
              class="btn btn-outline-light btn-social me-2"
              href="#"
              title="YouTube"
              ><i class="fab fa-youtube"></i
            ></a>
            <a
              class="btn btn-outline-light btn-social me-2"
              href="#"
              title="Instagram"
              ><i class="fab fa-instagram"></i
            ></a>
            <a class="btn btn-outline-light btn-social" href="#" title="TikTok"
              ><i class="fab fa-tiktok"></i
            ></a>
          </div>
        </div>
      </div>
    </div>
    <div class="row g-5">
      <div class="col-lg-3 col-md-6">
        <div class="footer-item">
          <h4 class="text-light mb-4">Về 3TLap</h4>
          <a class="btn-link" href="<c:url value='/about-us'/>"
            >Giới thiệu 3TLap</a
          >
          <a class="btn-link" href="<c:url value='/careers'/>">Tuyển dụng</a>
          <a class="btn-link" href="<c:url value='/store-locations'/>"
            >Hệ thống cửa hàng</a
          >
          <a class="btn-link" href="<c:url value='/contact-us'/>">Liên hệ</a>
        </div>
      </div>
      <div class="col-lg-3 col-md-6">
        <div class="footer-item">
          <h4 class="text-light mb-4">Hỗ Trợ Khách Hàng</h4>
          <a class="btn-link" href="<c:url value='/faq'/>"
            >Câu hỏi thường gặp (FAQ)</a
          >
          <a class="btn-link" href="<c:url value='/how-to-order'/>"
            >Hướng dẫn mua hàng</a
          >
          <a class="btn-link" href="<c:url value='/payment-methods'/>"
            >Phương thức thanh toán</a
          >
          <a class="btn-link" href="<c:url value='/shipping-policy'/>"
            >Chính sách vận chuyển</a
          >
        </div>
      </div>
      <div class="col-lg-3 col-md-6">
        <div class="footer-item">
          <h4 class="text-light mb-4">Chính Sách</h4>
          <a class="btn-link" href="<c:url value='/warranty-policy'/>"
            >Chính sách bảo hành</a
          >
          <a class="btn-link" href="<c:url value='/return-policy'/>"
            >Chính sách đổi trả</a
          >
          <a class="btn-link" href="<c:url value='/privacy-policy'/>"
            >Chính sách bảo mật</a
          >
          <a class="btn-link" href="<c:url value='/terms-conditions'/>"
            >Điều khoản sử dụng</a
          >
        </div>
      </div>
      <div class="col-lg-3 col-md-6">
        <div class="footer-item">
          <h4 class="text-light mb-4">Liên Hệ 3TLap</h4>
          <p>
            <i class="fas fa-map-marker-alt me-2"></i>11 Nguyễn Đình Chiểu, P.
            Đa Kao, Q.1 TP Hồ Chí Minh
          </p>
          <p><i class="fas fa-envelope me-2"></i>support@3tlap.vn</p>
          <p><i class="fas fa-phone-alt me-2"></i>(+84) 1900 8888</p>
          <div class="mt-3">
            <p class="mb-2">Chấp nhận thanh toán:</p>
            <img
              src="<c:url value='/client/img/payment.png'/>"
              class="img-fluid"
              alt="Phương thức thanh toán"
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
            ><i class="fas fa-copyright text-primary me-2"></i>3TLap</a
          >
          Đã đăng ký Bản quyền.</span
        >
      </div>
      <div class="col-md-6 my-auto text-center text-md-end text-white-50">
        <%-- Bạn có thể giữ lại hoặc bỏ đi phần này --%> Phát triển bởi
        <a class="border-bottom text-white-75" href="#">3TLap</a>
      </div>
    </div>
  </div>
</div>
<!-- Copyright End -->
