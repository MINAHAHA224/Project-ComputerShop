// src/main/webapp/resources/client/js/productDetail/productDetail.js

(function ($) {
  'use strict';

  // Spinner
  var spinner = function () {
    setTimeout(function () {
      if ($('#spinner').length > 0) {
        $('#spinner').removeClass('show');
      }
    }, 1);
  };
  spinner(0);

  // Fixed Navbar
  $(window).scroll(function () {
    if ($(window).width() < 992) {
      if ($(this).scrollTop() > 55) {
        $('.fixed-top').addClass('shadow');
      } else {
        $('.fixed-top').removeClass('shadow');
      }
    } else {
      if ($(this).scrollTop() > 55) {
        $('.fixed-top').addClass('shadow').css('top', 0);
      } else {
        $('.fixed-top').removeClass('shadow').css('top', 0);
      }
    }
  });

  // Back to top button
  $(window).scroll(function () {
    if ($(this).scrollTop() > 300) {
      $('.back-to-top').fadeIn('slow');
    } else {
      $('.back-to-top').fadeOut('slow');
    }
  });
  $('.back-to-top').click(function () {
    $('html, body').animate({ scrollTop: 0 }, 1500, 'easeInOutExpo');
    return false;
  });

  // Testimonial carousel
  $('.testimonial-carousel').owlCarousel({
    autoplay: true,
    smartSpeed: 2000,
    center: false,
    dots: true,
    loop: true,
    margin: 25,
    nav: true,
    navText: [
      '<i class="bi bi-arrow-left"></i>',
      '<i class="bi bi-arrow-right"></i>',
    ],
    responsiveClass: true,
    responsive: {
      0: {
        items: 1,
      },
      576: {
        items: 1,
      },
      768: {
        items: 1,
      },
      992: {
        items: 2,
      },
      1200: {
        items: 2,
      },
    },
  });

  // vegetable carousel
  $('.vegetable-carousel').owlCarousel({
    autoplay: true,
    smartSpeed: 1500,
    center: false,
    dots: true,
    loop: true,
    margin: 25,
    nav: true,
    navText: [
      '<i class="bi bi-arrow-left"></i>',
      '<i class="bi bi-arrow-right"></i>',
    ],
    responsiveClass: true,
    responsive: {
      0: {
        items: 1,
      },
      576: {
        items: 1,
      },
      768: {
        items: 2,
      },
      992: {
        items: 3,
      },
      1200: {
        items: 4,
      },
    },
  });

  // Modal Video
  $(document).ready(function () {
    var $videoSrc;
    $('.btn-play').click(function () {
      $videoSrc = $(this).data('src');
    });
    // console.log($videoSrc); // Có thể giữ lại để debug nếu cần

    $('#videoModal').on('shown.bs.modal', function (e) {
      $('#video').attr(
        'src',
        $videoSrc + '?autoplay=1&modestbranding=1&showinfo=0'
      );
    });

    $('#videoModal').on('hide.bs.modal', function (e) {
      $('#video').attr('src', $videoSrc); // Không cần "?autoplay=0" vì modal ẩn đi video sẽ dừng
    });

    //add active class to header
    const navElement = $('#navbarCollapse');
    if (navElement.length) {
      // Kiểm tra navElement có tồn tại không
      const currentUrl = window.location.pathname;
      navElement.find('a.nav-link').each(function () {
        const link = $(this);
        const href = link.attr('href');

        // So sánh chính xác hơn, bao gồm cả context path nếu có
        if (
          href &&
          (currentUrl === href || currentUrl.startsWith(href + '/'))
        ) {
          if (href === '/' && currentUrl !== '/') {
            // Tránh active trang chủ khi ở trang con
            link.removeClass('active');
          } else {
            link.addClass('active');
          }
        } else {
          link.removeClass('active');
        }
      });
    }
    // Quantity control for product detail page
    const $displayInputDetail = $('#formQuantityInputDetail');

    $('.quantity .btn-plus-detail').on('click', function () {
      let oldValue = parseFloat($displayInputDetail.val());
      if (isNaN(oldValue)) {
        oldValue = 0;
      }
      let newVal = oldValue + 1;
      // TODO: Có thể thêm kiểm tra số lượng tối đa ở đây (dựa trên product.quantity từ server)
      $displayInputDetail.val(newVal);
    });

    $('.quantity .btn-minus-detail').on('click', function () {
      let oldValue = parseFloat($displayInputDetail.val());
      if (isNaN(oldValue)) {
        oldValue = 1;
      }
      let newVal;
      if (oldValue > 1) {
        newVal = oldValue - 1;
      } else {
        newVal = 1;
      }
      $displayInputDetail.val(newVal);
    });

    // Logic chuyển ảnh chính khi click thumbnail (nếu bạn thêm gallery thumbnail)
    window.changeMainImage = function (newSrc) {
      $('#mainProductImage').attr('src', newSrc);
      // Optional: Add 'active' class to the clicked thumbnail and remove from others
      $('.product-gallery-thumbnails img').removeClass('active');
      $('.product-gallery-thumbnails img[src="' + newSrc + '"]').addClass(
        'active'
      );
    };
  });

  //   // Product Quantity (SINGLE PRODUCT PAGE)
  //   // Selector này sẽ chỉ áp dụng cho các nút +/- trong div có class 'quantity'
  //   // và input hiển thị có id 'displayQuantity' và input ẩn có id 'formQuantityInput'
  //   // Điều này giúp tránh xung đột nếu bạn có các nút quantity khác ở nơi khác trên trang.
  //   if ($('#displayQuantity').length && $('#formQuantityInput').length) {
  //     $('.quantity .btn-plus, .quantity .btn-minus').on('click', function () {
  //       var $button = $(this);
  //       var $displayInput = $('#displayQuantity'); // Input hiển thị
  //       var $formInput = $('#formQuantityInput'); // Input ẩn trong form

  //       var oldValue = parseFloat($displayInput.val());
  //       var newVal;

  //       if ($button.hasClass('btn-plus')) {
  //         newVal = oldValue + 1;
  //       } else {
  //         // Don't allow decrementing below 1
  //         if (oldValue > 1) {
  //           newVal = oldValue - 1;
  //         } else {
  //           newVal = 1;
  //         }
  //       }
  //       $displayInput.val(newVal);
  //       $formInput.val(newVal); // *** QUAN TRỌNG: Cập nhật cả input ẩn trong form ***
  //     });
  //   }

  // Lưu ý: Đoạn code JS xử lý quantity phức tạp hơn mà bạn cung cấp ban đầu
  // (với data-cart-detail-index, data-cart-detail-price, v.v.)
  // dường như dành cho trang giỏ hàng (cart page) nơi có nhiều sản phẩm.
  // Đoạn JS ở trên là phiên bản đơn giản hóa cho trang chi tiết sản phẩm (single product page)
  // nơi chỉ có một ô quantity cần quản lý cho form.
  // Nếu bạn cần đoạn code phức tạp đó cho trang giỏ hàng, hãy giữ nó riêng và chỉ áp dụng cho trang giỏ hàng.

  function formatCurrency(value) {
    // Use the 'vi-VN' locale to format the number according to Vietnamese currency format
    // and 'VND' as the currency type for Vietnamese đồng
    const formatter = new Intl.NumberFormat('vi-VN', {
      style: 'decimal',
      minimumFractionDigits: 0, // No decimal part for whole numbers
    });

    let formatted = formatter.format(value);
    //Đảm bảo là string trước khi replace
    formatted = String(formatted);
    // Replace dots with commas for thousands separator if that's the vi-VN standard,
    // or ensure it's using the correct locale's standard.
    // Intl.NumberFormat for 'vi-VN' should handle this correctly.
    // Nếu formatter không ra đúng dấu phẩy, bạn có thể cần:
    // formatted = formatted.replace(/\./g, ',');
    return formatted;
  }

  //handle filter products
  $('#btnFilter').click(function (event) {
    event.preventDefault();

    let factoryArr = [];
    let targetArr = [];
    let priceArr = [];
    //factory filter
    $('#factoryFilter .form-check-input:checked').each(function () {
      factoryArr.push($(this).val());
    });

    //target filter
    $('#targetFilter .form-check-input:checked').each(function () {
      targetArr.push($(this).val());
    });

    //price filter
    $('#priceFilter .form-check-input:checked').each(function () {
      priceArr.push($(this).val());
    });

    //sort order
    let sortValue = $('input[name="radio-sort"]:checked').val();
    if (typeof sortValue === 'undefined') {
      // Nếu không có radio nào được chọn
      sortValue = ''; // Hoặc một giá trị mặc định
    }

    const currentUrl = new URL(window.location.href);
    const searchParams = currentUrl.searchParams;

    // Add or update query parameters
    searchParams.set('page', '1'); // Luôn reset về trang 1 khi filter

    if (sortValue) {
      searchParams.set('sort', sortValue);
    } else {
      searchParams.delete('sort');
    }

    //reset
    searchParams.delete('factory');
    searchParams.delete('target');
    searchParams.delete('price');

    if (factoryArr.length > 0) {
      searchParams.set('factory', factoryArr.join(','));
    }

    if (targetArr.length > 0) {
      searchParams.set('target', targetArr.join(','));
    }

    if (priceArr.length > 0) {
      searchParams.set('price', priceArr.join(','));
    }

    // Update the URL and reload the page
    window.location.href = currentUrl.toString();
  });

  //handle auto checkbox after page loading
  function applyFiltersFromUrl() {
    const params = new URLSearchParams(window.location.search);

    // Set checkboxes for 'factory'
    if (params.has('factory')) {
      const factories = params.get('factory').split(',');
      factories.forEach((factory) => {
        $(`#factoryFilter .form-check-input[value="${factory}"]`).prop(
          'checked',
          true
        );
      });
    }

    // Set checkboxes for 'target'
    if (params.has('target')) {
      const targets = params.get('target').split(',');
      targets.forEach((target) => {
        $(`#targetFilter .form-check-input[value="${target}"]`).prop(
          'checked',
          true
        );
      });
    }

    // Set checkboxes for 'price'
    if (params.has('price')) {
      const prices = params.get('price').split(',');
      prices.forEach((price) => {
        $(`#priceFilter .form-check-input[value="${price}"]`).prop(
          'checked',
          true
        );
      });
    }

    // Set radio buttons for 'sort'
    if (params.has('sort')) {
      const sort = params.get('sort');
      $(`input[type="radio"][name="radio-sort"][value="${sort}"]`).prop(
        'checked',
        true
      );
    }
  }
  // Call the function to apply filters when the page loads
  applyFiltersFromUrl();
})(jQuery);
