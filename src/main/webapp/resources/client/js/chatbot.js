// src/main/webapp/resources/client/js/chatbot.js

$(document).ready(function () {
  const CHATBOT_API_BASE_URL = 'http://8.34.124.122:20610';
  const CHATBOT_API_KEY = 'P39vB66xz1SFKwzKImvvYb3FMkzhUp26';
  let CURRENT_CHATBOT_NAME = null;

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
    if (!CHATBOT_API_KEY || CHATBOT_API_KEY === 'YOUR_ACTUAL_CHATBOT_API_KEY') {
      console.error(
        'Lỗi nghiêm trọng: Chatbot API Key chưa được cấu hình trong chatbot.js!'
      );
      disableChatbot('Trợ lý ảo hiện không sẵn sàng (Lỗi cấu hình).');
      return;
    }

    fetch(`${CHATBOT_API_BASE_URL}/typesense/get_chatbot_info`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ api_key: CHATBOT_API_KEY }),
    })
      .then((response) => {
        if (!response.ok) {
          return response
            .json()
            .then((err) => {
              throw new Error(
                err.detail ||
                  `Không thể lấy thông tin chatbot. Status: ${response.status}`
              );
            })
            .catch(() => {
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
        ? $('body').data('user-avatar-url') ||
          '<c:url value="/images/avatar/default-avatar.png"/>'
        : '<c:url value="/client/img/favicon_3tlap.png"/>';
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
    fetch(`${CHATBOT_API_BASE_URL}/typesense/suggest_questions`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        api_key: CHATBOT_API_KEY,
      },
      body: JSON.stringify({
        previous_response: previousResponse,
        context: context,
        chatbot_name: CURRENT_CHATBOT_NAME,
        query: originalQuery,
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

    if (!CHATBOT_API_KEY || CHATBOT_API_KEY === 'YOUR_ACTUAL_CHATBOT_API_KEY') {
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
      query: userQuery,
      chat_history: chatHistory,
      top_k: 3,
      prompt_from_user: 'Trả lời như một chuyên viên tư vấn laptop tại 3TLap.',
    };

    const queryEndpoint = `${CHATBOT_API_BASE_URL}/typesense/query`;

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

  $toggleButton.on('click', toggleChatbot);
  $closeButtonWidget.on('click', toggleChatbot);
  $minimizeButton.on('click', toggleChatbot);

  $sendButton.on('click', sendMessage);
  $inputField.on('keypress', function (e) {
    if (e.key === 'Enter' && !e.shiftKey) {
      e.preventDefault();
      sendMessage();
    }
  });
  $inputField.on('input', function () {
    this.style.height = 'auto';
    this.style.height = this.scrollHeight + 'px';
  });

  if (!CHATBOT_API_KEY || CHATBOT_API_KEY === 'YOUR_ACTUAL_CHATBOT_API_KEY') {
    disableChatbot('Trợ lý ảo chưa được cấu hình (thiếu API Key).');
  }
});
