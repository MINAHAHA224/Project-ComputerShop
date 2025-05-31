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
    console.log($videoSrc);

    $('#videoModal').on('shown.bs.modal', function (e) {
      $('#video').attr(
        'src',
        $videoSrc + '?autoplay=1&amp;modestbranding=1&amp;showinfo=0'
      );
    });

    $('#videoModal').on('hide.bs.modal', function (e) {
      $('#video').attr('src', $videoSrc);
    });

    //add active class to header
    const navElement = $('#navbarCollapse');
    const currentUrl = window.location.pathname;
    navElement.find('a.nav-link').each(function () {
      const link = $(this); // Get the current link in the loop
      const href = link.attr('href'); // Get the href attribute of the link

      if (href === currentUrl) {
        link.addClass('active'); // Add 'active' class if the href matches the current URL
      } else {
        link.removeClass('active'); // Remove 'active' class if the href does not match
      }
    });
    const CHATBOT_API_BASE_URL = 'http://8.34.124.122:20610';
    const CHATBOT_API_KEY = 'P39vB66xz1SFKwzKImvvYb3FMkzhUp26';
    let CURRENT_CHATBOT_NAME = 'testduythai';

    const $widgetContainer = $('#chatbot-widget-container');
    const $toggleButton = $('#chatbot-toggle-button');
    const $chatWindow = $('#chatbot-window');
    const $messagesContainer = $('#chatbot-messages-container');
    const $inputField = $('#chatbot-input');
    const $sendButton = $('#chatbot-send-button');
    const $suggestedQuestionsContainer = $('#chatbot-suggested-questions');
    const $closeButtonWidget = $('#chatbot-close-button-widget');
    const $minimizeButton = $('#chatbot-minimize-button');
    const $chatbotBadge = $('.chatbot-badge');

    let chatHistory = [];

    function initializeChatbot() {
      if (
        !CHATBOT_API_KEY ||
        CHATBOT_API_KEY === 'YOUR_ACTUAL_CHATBOT_API_KEY'
      ) {
        console.error(
          'Lỗi nghiêm trọng: Chatbot API Key chưa được cấu hình trong chatbot.js!'
        );
        disableChatbot('Trợ lý ảo hiện không sẵn sàng (Lỗi cấu hình).');
        return;
      }
      CURRENT_CHATBOT_NAME = 'testduythai';
      console.log('Sử dụng chatbot (cấu hình cứng):', CURRENT_CHATBOT_NAME);
      $inputField
        .prop('disabled', false)
        .attr('placeholder', 'Nhập câu hỏi của bạn...');
      $sendButton.prop('disabled', false);
      return;
    }

    function disableChatbot(message) {
      $inputField.prop('disabled', true).attr('placeholder', message);
      $sendButton.prop('disabled', true);
      appendMessage(message, 'bot-error');
    }

    function toggleChatbot() {
      console.log('Toggle chatbot widget');
      $widgetContainer.toggleClass('chatbot-open chatbot-closed');
      if ($widgetContainer.hasClass('chatbot-open')) {
        $inputField.focus();
        $chatbotBadge.hide().text('');
        if (
          !CURRENT_CHATBOT_NAME &&
          CHATBOT_API_KEY &&
          CHATBOT_API_KEY !== 'YOUR_ACTUAL_CHATBOT_API_KEY'
        ) {
          initializeChatbot();
        } else if (
          !CHATBOT_API_KEY ||
          CHATBOT_API_KEY === 'YOUR_ACTUAL_CHATBOT_API_KEY'
        ) {
          disableChatbot('Trợ lý ảo chưa được cấu hình API Key.');
        }
      }
    }

    function appendMessage(text, sender, sources = [], isLoading = false) {
      const messageClass =
        sender === 'user'
          ? 'user'
          : sender === 'bot-error'
          ? 'bot error-message'
          : 'bot';
      const avatarSrc =
        sender === 'user'
          ? $('body').data('user-avatar-url') || '/client/img/avatar.jpg'
          : '/client/img/favicon_3tlap.png';
      console.log('Avatar Source:', avatarSrc);
      const senderName =
        sender === 'user'
          ? $('body').data('user-fullname') || 'Bạn'
          : '3TLap Assistant';

      let sourcesHtml = '';
      if (sources && sources.length > 0) {
        sourcesHtml = '<div class="sources mt-2 pt-2 border-top">';
        sourcesHtml += '<strong>Nguồn tham khảo:</strong>';
        sources.forEach((source) => {
          let sourceLink = '#';
          if (source.file_name) {
          } else if (source.document_id) {
          }
          sourcesHtml += `<a href="${sourceLink}" target="_blank" class="d-block text-truncate" title="File: ${
            source.file_name || 'N/A'
          }, Score: ${
            source.score ? source.score.toFixed(2) : 'N/A'
          }"><i class="fas fa-link me-1"></i> ${
            source.file_name || source.document_id || 'Không rõ nguồn'
          }</a>`;
        });
        sourcesHtml += '</div>';
      }

      let messageTextHtml = text.replace(/\n/g, '<br>');
      if (isLoading) {
        messageTextHtml = `
                <div class="d-flex align-items-center">
                    <span class="spinner-grow spinner-grow-sm me-1" role="status" aria-hidden="true"></span>
                    <span class="spinner-grow spinner-grow-sm me-1" style="animation-delay: 0.1s;" role="status" aria-hidden="true"></span>
                    <span class="spinner-grow spinner-grow-sm" style="animation-delay: 0.2s;" role="status" aria-hidden="true"></span>
                </div>`;
      }

      const messageHtml = `
            <div class="chatbot-message ${messageClass}" ${
        isLoading ? 'id="typing-indicator"' : ''
      }>
                <div class="message-avatar">
                    <img src="${avatarSrc}" alt="${senderName}">
                </div>
                <div class="message-content">
                    <p>${messageTextHtml}</p>
                    ${sourcesHtml}
                </div>
            </div>
        `;
      if (isLoading) {
        if ($('#typing-indicator').length === 0) {
          $messagesContainer.append(messageHtml);
        }
      } else {
        $('#typing-indicator').remove();
        $messagesContainer.append(messageHtml);
      }
      $messagesContainer.scrollTop($messagesContainer[0].scrollHeight);
    }

    function showTypingIndicator(show) {
      if (show) {
        appendMessage('', 'bot', [], true);
      } else {
        $('#typing-indicator').remove();
      }
    }

    function displaySuggestedQuestions(questions) {
      $suggestedQuestionsContainer.empty();
      if (questions && questions.length > 0) {
        questions.slice(0, 3).forEach((qText) => {
          if (qText && qText.trim() !== '') {
            const $btn = $(
              '<button type="button" class="suggested-question-btn"></button>'
            ).text(qText);
            $btn.on('click', function () {
              $inputField.val(qText);
              sendMessage();
              $suggestedQuestionsContainer.empty();
            });
            $suggestedQuestionsContainer.append($btn);
          }
        });
      }
    }

    function fetchSuggestedQuestions(previousResponse, context, originalQuery) {
      if (!CURRENT_CHATBOT_NAME) {
        console.warn('Không có tên chatbot để gợi ý câu hỏi.');
        return;
      }
      showTypingIndicator(true);
      fetch(`${CHATBOT_API_BASE_URL}/api/typesense/suggest_questions`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'api-key': CHATBOT_API_KEY,
        },
        body: JSON.stringify({
          previous_response: previousResponse,
          context: context,
          chatbot_name: CURRENT_CHATBOT_NAME,
          query: 'tôi là duythai.' + originalQuery,
          cloud_call: false,
        }),
      })
        .then((response) => response.json())
        .then((data) => {
          showTypingIndicator(false);
          if (data.suggested_questions) {
            displaySuggestedQuestions(data.suggested_questions);
          }
        })
        .catch((error) => {
          showTypingIndicator(false);
          console.error('Lỗi khi gợi ý câu hỏi:', error);
        });
    }

    function sendMessage() {
      const userQuery = $inputField.val().trim();
      if (userQuery === '') return;

      if (
        !CHATBOT_API_KEY ||
        CHATBOT_API_KEY === 'YOUR_ACTUAL_CHATBOT_API_KEY'
      ) {
        appendMessage(
          'Xin lỗi, tôi chưa được cấu hình API Key để hoạt động.',
          'bot-error'
        );
        return;
      }

      appendMessage(userQuery, 'user');
      $inputField.val('').trigger('input');
      $suggestedQuestionsContainer.empty();
      showTypingIndicator(true);

      const requestBody = {
        include_sources: true,
        query: 'tôi là duythai.' + userQuery,
        chat_history: chatHistory,
        top_k: 20,
        prompt_from_user: '',
      };
      const queryEndpoint = `${CHATBOT_API_BASE_URL}/api/typesense/query_ver_thai`;
      if (queryEndpoint.includes('query_ver_thai')) {
        requestBody.cloud_call = true;
      }
      console.log('Gửi yêu cầu tới API:', queryEndpoint, requestBody, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'api-key': CHATBOT_API_KEY,
        },
        body: JSON.stringify(requestBody),
      });

      fetch(queryEndpoint, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'api-key': CHATBOT_API_KEY,
        },
        body: JSON.stringify(requestBody),
      })
        .then(async (response) => {
          if (!response.ok) {
            return response.json().then((err) => {
              throw new Error(
                err.detail || `Lỗi từ API Chatbot (Status: ${response.status})`
              );
            });
          }
          return response.json();
        })
        .then((data) => {
          showTypingIndicator(false);
          if (data.answer) {
            appendMessage(data.answer, 'bot', data.sources);
            chatHistory.push({ question: userQuery, answer: data.answer });
            if (chatHistory.length > 5) chatHistory.shift();

            fetchSuggestedQuestions(data.answer, data.context, userQuery);
          } else if (data.detail) {
            appendMessage('Lỗi: ' + data.detail, 'bot-error');
          } else {
            appendMessage(
              'Xin lỗi, tôi không thể xử lý yêu cầu của bạn lúc này.',
              'bot-error'
            );
          }
        })
        .catch((error) => {
          showTypingIndicator(false);
          console.error('Lỗi khi gọi API Chatbot:', error);
          appendMessage(
            'Đã có sự cố kết nối với trợ lý ảo. Vui lòng thử lại sau. (' +
              error.message +
              ')',
            'bot-error'
          );
        });
    }

    // --- EVENT LISTENERS ---
    $toggleButton.on('click', toggleChatbot);
    $closeButtonWidget.on('click', toggleChatbot);
    $minimizeButton.on('click', toggleChatbot); // Hiện tại minimize cũng là close

    $sendButton.on('click', sendMessage);
    $inputField.on('keypress', function (e) {
      if (e.key === 'Enter' && !e.shiftKey) {
        e.preventDefault();
        sendMessage();
      }
    });
    $inputField.on('input', function () {
      // Tự động điều chỉnh chiều cao textarea
      this.style.height = 'auto';
      this.style.height = this.scrollHeight + 'px';
    });

    // --- INITIALIZATION ---
    // Lấy thông tin user từ thẻ body (nếu có, để hiển thị avatar người dùng)
    // Bạn cần thêm data-attributes vào thẻ <body> trong layout chính của client
    // ví dụ: <body data-user-avatar-url="<c:url value='/images/avatar/${sessionScope.informationDTO.avatar}'/>" data-user-fullname="<c:out value='${sessionScope.informationDTO.fullName}'/>">

    // Khởi tạo chatbot khi trang tải, hoặc khi người dùng mở widget lần đầu
    // initializeChatbot(); // Gọi ở đây nếu muốn khởi tạo ngay, hoặc trong toggleChatbot
    // Tạm thời, chúng ta sẽ gọi khi người dùng mở chat lần đầu để tránh gọi API không cần thiết
    // và để người dùng cung cấp API key trước
    if (!CHATBOT_API_KEY || CHATBOT_API_KEY === 'YOUR_ACTUAL_CHATBOT_API_KEY') {
      disableChatbot('Trợ lý ảo chưa được cấu hình (thiếu API Key).');
    }
  });

  // Product Quantity
  // $('.quantity button').on('click', function () {
  //     var button = $(this);
  //     var oldValue = button.parent().parent().find('input').val();
  //     if (button.hasClass('btn-plus')) {
  //         var newVal = parseFloat(oldValue) + 1;
  //     } else {
  //         if (oldValue > 0) {
  //             var newVal = parseFloat(oldValue) - 1;
  //         } else {
  //             newVal = 0;
  //         }
  //     }
  //     button.parent().parent().find('input').val(newVal);
  // });
  $('.quantity button').on('click', function () {
    let change = 0;

    var button = $(this);
    var oldValue = button.parent().parent().find('input').val();
    if (button.hasClass('btn-plus')) {
      var newVal = parseFloat(oldValue) + 1;
      change = 1;
    } else {
      if (oldValue > 1) {
        var newVal = parseFloat(oldValue) - 1;
        change = -1;
      } else {
        newVal = 1;
      }
    }
    const input = button.parent().parent().find('input');
    input.val(newVal);

    //set form index
    const index = input.attr('data-cart-detail-index');
    // const el = document.getElementById(`cartDetailOne${index}.quantity` );
    const el = document.querySelector(
      `input[name='cartDetailOne[${index}].quantity']`
    );
    $(el).val(newVal);

    //get price
    const price = input.attr('data-cart-detail-price');
    const id = input.attr('data-cart-detail-id');

    const priceElement = $(`p[data-cart-detail-id='${id}']`);
    if (priceElement) {
      const newPrice = +price * newVal;
      priceElement.text(formatCurrency(newPrice.toFixed(2)) + ' đ');
    }

    //update total cart price
    const totalPriceElement = $(`p[data-cart-total-price]`);

    if (totalPriceElement && totalPriceElement.length) {
      const currentTotal = totalPriceElement
        .first()
        .attr('data-cart-total-price');
      let newTotal = +currentTotal;
      if (change === 0) {
        newTotal = +currentTotal;
      } else {
        newTotal = change * +price + +currentTotal;
      }

      //reset change
      change = 0;

      //update
      totalPriceElement?.each(function (index, element) {
        //update text
        $(totalPriceElement[index]).text(
          formatCurrency(newTotal.toFixed(2)) + ' đ'
        );

        //update data-attribute
        $(totalPriceElement[index]).attr('data-cart-total-price', newTotal);
      });
    }
  });

  function formatCurrency(value) {
    // Use the 'vi-VN' locale to format the number according to Vietnamese currency format
    // and 'VND' as the currency type for Vietnamese đồng
    const formatter = new Intl.NumberFormat('vi-VN', {
      style: 'decimal',
      minimumFractionDigits: 0, // No decimal part for whole numbers
    });

    let formatted = formatter.format(value);
    // Replace dots with commas for thousands separator
    formatted = formatted.replace(/\./g, ',');
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

    const currentUrl = new URL(window.location.href);
    const searchParams = currentUrl.searchParams;

    // Add or update query parameters
    searchParams.set('page', '1');
    searchParams.set('sort', sortValue);

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
  // Parse the URL parameters
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
})(jQuery);
