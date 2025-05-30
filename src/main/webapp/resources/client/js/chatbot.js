$(document).ready(function () {
  // --- CHATBOT CONFIGURATION ---
  const CHATBOT_API_BASE_URL = 'http://8.34.124.122:20610'; // URL API Chatbot của bạn
  const CHATBOT_API_KEY = 'P39vB66xz1SFKwzKImvvYb3FMkzhUp26'; // !!!! THAY BẰNG API KEY THỰC TẾ CỦA BẠN !!!!
  let CURRENT_CHATBOT_NAME = null; // Sẽ được lấy từ API hoặc bạn có thể đặt tên mặc định nếu biết

  // --- CHATBOT UI ELEMENTS ---
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

  let chatHistory = []; // Lưu lịch sử chat cho session hiện tại (tối đa 5 cặp)

  // --- CORE FUNCTIONS ---

  // Function để lấy tên chatbot từ API key (API số 18)
  function initializeChatbot() {
    if (!CHATBOT_API_KEY || CHATBOT_API_KEY === 'YOUR_ACTUAL_CHATBOT_API_KEY') {
      console.error(
        'Lỗi nghiêm trọng: Chatbot API Key chưa được cấu hình trong chatbot.js!'
      );
      disableChatbot('Trợ lý ảo hiện không sẵn sàng (Lỗi cấu hình).');
      return;
    }

    // Nếu bạn biết chắc chắn tên collection/chatbot cho API key này, có thể gán trực tiếp:
    // CURRENT_CHATBOT_NAME = "tên_chatbot_của_bạn";
    // console.log("Sử dụng chatbot (cấu hình cứng):", CURRENT_CHATBOT_NAME);
    // $inputField.prop('disabled', false).attr('placeholder', 'Nhập câu hỏi của bạn...');
    // $sendButton.prop('disabled', false);
    // return; // Bỏ qua gọi API nếu đã biết tên

    // Hoặc gọi API để lấy tên chatbot
    fetch(`${CHATBOT_API_BASE_URL}/typesense/get_chatbot_info`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        // Nếu API này yêu cầu CSRF từ phía Spring Boot (khá hiếm cho API gateway kiểu này), thêm vào:
        // '<security:csrfHeaderName/>': '<security:csrfToken/>'
      },
      body: JSON.stringify({ api_key: CHATBOT_API_KEY }),
    })
      .then((response) => {
        if (!response.ok) {
          // Thử parse lỗi JSON từ server API
          return response
            .json()
            .then((err) => {
              throw new Error(
                err.detail ||
                  `Không thể lấy thông tin chatbot. Status: ${response.status}`
              );
            })
            .catch(() => {
              // Nếu parse lỗi cũng thất bại (phản hồi không phải JSON)
              throw new Error(
                `Không thể lấy thông tin chatbot. Status: ${response.status}`
              );
            });
        }
        return response.json();
      })
      .then((data) => {
        if (data.chatbot_name) {
          CURRENT_CHATBOT_NAME = data.chatbot_name;
          console.log('Đã kết nối với chatbot:', CURRENT_CHATBOT_NAME);
          $inputField
            .prop('disabled', false)
            .attr('placeholder', 'Nhập câu hỏi của bạn...');
          $sendButton.prop('disabled', false);
          // Bạn có thể cập nhật tiêu đề chatbox ở đây nếu muốn
          // $('.chatbot-title').text(CURRENT_CHATBOT_NAME + " Assistant");
        } else {
          throw new Error('API không trả về tên chatbot.');
        }
      })
      .catch((error) => {
        console.error('Lỗi khởi tạo chatbot (get_chatbot_info):', error);
        disableChatbot(error.message || 'Lỗi kết nối với trợ lý ảo.');
      });
  }

  function disableChatbot(message) {
    $inputField.prop('disabled', true).attr('placeholder', message);
    $sendButton.prop('disabled', true);
    appendMessage(message, 'bot-error'); // Thêm class mới để style lỗi
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
        // Chỉ gọi nếu chưa có tên và API key đã được set (tránh gọi lại mỗi lần mở)
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
        ? $('body').data('user-avatar-url') ||
          '<c:url value="/images/avatar/default-avatar.png"/>' // Lấy avatar từ data attribute của body
        : '<c:url value="/client/img/favicon_3tlap.png"/>';
    const senderName =
      sender === 'user'
        ? $('body').data('user-fullname') || 'Bạn'
        : '3TLap Assistant';

    let sourcesHtml = '';
    if (sources && sources.length > 0) {
      sourcesHtml = '<div class="sources mt-2 pt-2 border-top">'; // Thêm border-top
      sourcesHtml += '<strong>Nguồn tham khảo:</strong>';
      sources.forEach((source) => {
        // Giả sử API sources trả về document_id là ID sản phẩm hoặc tên file có thể dùng để link
        // Cần điều chỉnh logic tạo link cho phù hợp
        let sourceLink = '#'; // Link mặc định
        if (source.file_name) {
          // Ưu tiên file_name nếu có
          // Giả sử bạn có trang hiển thị tài liệu dựa trên tên file
          // sourceLink = `<c:url value='/documents/${encodeURIComponent(CURRENT_CHATBOT_NAME)}/${encodeURIComponent(source.file_name)}'/>`;
          // Hoặc nếu document_id là ID sản phẩm thì link tới sản phẩm
          // sourceLink = `<c:url value='/product/${source.document_id}'/>`;
        } else if (source.document_id) {
          // sourceLink = `<c:url value='/product/${source.document_id}'/>`;
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
        // Chỉ thêm nếu chưa có
        $messagesContainer.append(messageHtml);
      }
    } else {
      $('#typing-indicator').remove(); // Xóa typing indicator trước khi thêm tin nhắn mới
      $messagesContainer.append(messageHtml);
    }
    $messagesContainer.scrollTop($messagesContainer[0].scrollHeight);
  }

  function showTypingIndicator(show) {
    if (show) {
      appendMessage('', 'bot', [], true); // true để báo là typing indicator
    } else {
      $('#typing-indicator').remove();
    }
  }

  function displaySuggestedQuestions(questions) {
    $suggestedQuestionsContainer.empty();
    if (questions && questions.length > 0) {
      questions.slice(0, 3).forEach((qText) => {
        if (qText && qText.trim() !== '') {
          // Đảm bảo câu hỏi không rỗng
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
      // Cần tên chatbot để gọi API này
      console.warn('Không có tên chatbot để gợi ý câu hỏi.');
      return;
    }
    showTypingIndicator(true); // Cho biết đang xử lý
    fetch(`${CHATBOT_API_BASE_URL}/typesense/suggest_questions`, {
      // API số 16
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        api_key: CHATBOT_API_KEY, // API này có thể không cần api_key trong header, kiểm tra lại docs
      },
      body: JSON.stringify({
        previous_response: previousResponse,
        context: context,
        chatbot_name: CURRENT_CHATBOT_NAME,
        query: originalQuery,
        cloud_call: false, // Theo tài liệu
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

    if (!CHATBOT_API_KEY || CHATBOT_API_KEY === 'YOUR_ACTUAL_CHATBOT_API_KEY') {
      appendMessage(
        'Xin lỗi, tôi chưa được cấu hình API Key để hoạt động.',
        'bot-error'
      );
      return;
    }
    // if (!CURRENT_CHATBOT_NAME) { // Được kiểm tra ở initializeChatbot
    //     appendMessage("Không thể xác định chatbot. Vui lòng thử lại sau.", "bot-error");
    //     return;
    // }

    appendMessage(userQuery, 'user');
    $inputField.val('').trigger('input'); // Xóa input và trigger input để reset chiều cao
    $suggestedQuestionsContainer.empty();
    showTypingIndicator(true);

    const requestBody = {
      query: userQuery,
      chat_history: chatHistory,
      top_k: 3, // Số sources
      prompt_from_user: 'Trả lời như một chuyên viên tư vấn laptop tại 3TLap.', // Tùy chỉnh prompt
    };

    // API endpoint (chọn 1 trong 2, hoặc làm logic chọn dựa trên điều kiện nào đó)
    const queryEndpoint = `${CHATBOT_API_BASE_URL}/typesense/query`; // API 13
    // const queryEndpoint = `${CHATBOT_API_BASE_URL}/typesense/query_ver_thai`; // API 14 (nếu muốn dùng phiên bản này)
    // if (queryEndpoint.includes('query_ver_thai')) {
    //     requestBody.cloud_call = true; // Ví dụ thêm trường cho API ver_thai
    // }

    fetch(queryEndpoint, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        api_key: CHATBOT_API_KEY,
      },
      body: JSON.stringify(requestBody),
    })
      .then((response) => {
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
