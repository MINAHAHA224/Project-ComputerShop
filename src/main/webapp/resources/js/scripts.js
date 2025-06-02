window.addEventListener('DOMContentLoaded', (event) => {
  //  Chatbot

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
    if (!CHATBOT_API_KEY || CHATBOT_API_KEY === 'YOUR_ACTUAL_CHATBOT_API_KEY') {
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

  // --- SIDEBAR TOGGLE ---
  const sidebarToggleAdmin = document.body.querySelector('#sidebarToggleAdmin');
  if (sidebarToggleAdmin) {
    sidebarToggleAdmin.addEventListener('click', (e) => {
      e.preventDefault();
      document.body.classList.toggle('sb-sidenav-toggled');
      localStorage.setItem(
        'sb|sidebar-toggle-admin',
        document.body.classList.contains('sb-sidenav-toggled')
      );
    });
  }

  // --- SIDEBAR LINKS & BREADCRUMB ---
  const sidenavAccordionAdmin = document.getElementById(
    'sidenavAccordionAdmin'
  );
  const currentPath = window.location.pathname;

  if (sidenavAccordionAdmin) {
    const navLinks = sidenavAccordionAdmin.querySelectorAll(
      'a.nav-link.nav-item-main'
    );
    let activePageTitle = 'Dashboard';

    navLinks.forEach((link) => {
      const linkHref = link.getAttribute('href');
      let isActive = false;

      if (
        linkHref === currentPath ||
        (linkHref !== '/admin' && currentPath.startsWith(linkHref))
      ) {
        isActive = true;
      }

      const nestedCollapse = link.nextElementSibling;
      if (nestedCollapse && nestedCollapse.classList.contains('collapse')) {
        const subNavLinks = nestedCollapse.querySelectorAll('a.nav-link');
        subNavLinks.forEach((subLink) => {
          const subLinkHref = subLink.getAttribute('href');
          if (
            subLinkHref === currentPath ||
            (subLinkHref !== '/admin' && currentPath.startsWith(subLinkHref))
          ) {
            subLink.classList.add('active');
            isActive = true;
            if (subLink.dataset.page) {
              activePageTitle = subLink.dataset.page;
            }
            if (!nestedCollapse.classList.contains('show')) {
              const toggler = document.querySelector(
                `[data-bs-target="#${nestedCollapse.id}"]`
              );
              if (toggler) {
                toggler.classList.remove('collapsed');
                toggler.setAttribute('aria-expanded', 'true');
                nestedCollapse.classList.add('show');
              }
            }
          } else {
            subLink.classList.remove('active');
          }
        });
      }

      if (isActive) {
        link.classList.add('active');
        if (link.dataset.page && activePageTitle === 'Dashboard') {
          activePageTitle = link.dataset.page;
        }
      } else {
        link.classList.remove('active');
      }
    });

    const currentBreadcrumbPage = document.getElementById(
      'currentBreadcrumbPage'
    );
    if (currentBreadcrumbPage) {
      if (activePageTitle === 'Dashboard' && currentPath !== '/admin') {
        if (currentPath.includes('/user/'))
          activePageTitle = 'Quản lý Người Dùng';
        else if (currentPath.includes('/product/'))
          activePageTitle = 'Quản lý Sản Phẩm';
        else if (currentPath.includes('/order/'))
          activePageTitle = 'Quản lý Đơn Hàng';
      }
      currentBreadcrumbPage.textContent = activePageTitle;
    }
  }

  // --- THEME (DARK/LIGHT) FOR ADMIN ---
  const adminThemeToggleButton = document.getElementById('adminThemeToggle');
  const adminBody = document.querySelector('body.admin-body-3tlap');

  const applyAdminTheme = (theme) => {
    if (!adminBody) return;

    if (theme === 'dark') {
      adminBody.classList.add('theme-dark');
      if (adminThemeToggleButton) {
        adminThemeToggleButton.setAttribute(
          'title',
          'Chuyển sang Giao diện Sáng'
        );
        adminThemeToggleButton.innerHTML = '<i class="fas fa-sun"></i>';
      }
    } else {
      adminBody.classList.remove('theme-dark');
      if (adminThemeToggleButton) {
        adminThemeToggleButton.setAttribute(
          'title',
          'Chuyển sang Giao diện Tối'
        );
        adminThemeToggleButton.innerHTML = '<i class="fas fa-moon"></i>';
      }
    }
    if (
      typeof Chart !== 'undefined' &&
      (typeof window.myLineChart !== 'undefined' ||
        typeof window.myBarChart !== 'undefined')
    ) {
      updateChartColorsForTheme(theme);
    }
  };

  if (adminBody) {
    const savedTheme = localStorage.getItem('3tlapAdminTheme') || 'light';
    applyAdminTheme(savedTheme);
  }

  if (adminThemeToggleButton && adminBody) {
    adminThemeToggleButton.addEventListener('click', () => {
      let newTheme = adminBody.classList.contains('theme-dark')
        ? 'light'
        : 'dark';
      localStorage.setItem('3tlapAdminTheme', newTheme);
      applyAdminTheme(newTheme);
    });
  }

  function updateChartColorsForTheme(theme) {
    const isDark = theme === 'dark';
    const rootStyles = getComputedStyle(document.documentElement);

    const newFontColor =
      (isDark
        ? rootStyles.getPropertyValue('--admin-text-secondary-dark')
        : rootStyles.getPropertyValue('--admin-text-secondary-light')
      )?.trim() || (isDark ? '#adb5bd' : '#6c757d');
    const newGridColor =
      (isDark
        ? rootStyles.getPropertyValue('--admin-divider-color-dark')
        : rootStyles.getPropertyValue('--admin-divider-color-light')
      )?.trim() || (isDark ? '#323840' : '#e9ecef');
    const newPrimaryAccent =
      rootStyles.getPropertyValue('--admin-primary-accent').trim() || '#0A7AFF';
    const newSecondaryAccent =
      rootStyles.getPropertyValue('--admin-secondary-accent').trim() ||
      '#FF8C00';
    const cardBg =
      (isDark
        ? rootStyles.getPropertyValue('--admin-card-bg-dark')
        : rootStyles.getPropertyValue('--admin-card-bg-light')
      )?.trim() || (isDark ? '#2c313a' : '#ffffff');
    const textPrimary =
      (isDark
        ? rootStyles.getPropertyValue('--admin-text-primary-dark')
        : rootStyles.getPropertyValue('--admin-text-primary-light')
      )?.trim() || (isDark ? '#e9ecef' : '#212529');

    if (Chart.defaults.global) {
      Chart.defaults.global.defaultFontColor = newFontColor;
    }

    if (
      typeof window.myLineChart !== 'undefined' &&
      window.myLineChart.options
    ) {
      const lineChartOptions = window.myLineChart.options;
      if (lineChartOptions.scales.xAxes && lineChartOptions.scales.xAxes[0]) {
        lineChartOptions.scales.xAxes[0].ticks.fontColor = newFontColor;
        lineChartOptions.scales.xAxes[0].gridLines.color = newGridColor;
        lineChartOptions.scales.xAxes[0].gridLines.zeroLineColor = newGridColor;
      }
      if (lineChartOptions.scales.yAxes && lineChartOptions.scales.yAxes[0]) {
        lineChartOptions.scales.yAxes[0].ticks.fontColor = newFontColor;
        lineChartOptions.scales.yAxes[0].gridLines.color = newGridColor;
        lineChartOptions.scales.yAxes[0].gridLines.zeroLineColor = newGridColor;
      }
      if (lineChartOptions.legend && lineChartOptions.legend.labels) {
        lineChartOptions.legend.labels.fontColor = newFontColor;
      }

      if (lineChartOptions.tooltips) {
        lineChartOptions.tooltips.backgroundColor = cardBg;
        lineChartOptions.tooltips.titleFontColor = textPrimary;
        lineChartOptions.tooltips.bodyFontColor = newFontColor;
        lineChartOptions.tooltips.borderColor = newGridColor;
      }

      window.myLineChart.data.datasets[0].borderColor = newPrimaryAccent;
      window.myLineChart.data.datasets[0].backgroundColor = `rgba(${hexToRgb(
        newPrimaryAccent
      )}, 0.15)`;
      window.myLineChart.data.datasets[0].pointBackgroundColor =
        newPrimaryAccent;
      window.myLineChart.update();
    }

    if (typeof window.myBarChart !== 'undefined' && window.myBarChart.options) {
      const barChartOptions = window.myBarChart.options;
      if (barChartOptions.scales.xAxes && barChartOptions.scales.xAxes[0]) {
        barChartOptions.scales.xAxes[0].ticks.fontColor = newFontColor;
        barChartOptions.scales.xAxes[0].gridLines.color = newGridColor;
      }
      if (barChartOptions.scales.yAxes && barChartOptions.scales.yAxes[0]) {
        barChartOptions.scales.yAxes[0].ticks.fontColor = newFontColor;
        barChartOptions.scales.yAxes[0].gridLines.color = newGridColor;
      }
      if (barChartOptions.tooltips) {
        barChartOptions.tooltips.backgroundColor = cardBg;
        barChartOptions.tooltips.titleFontColor = textPrimary;
        barChartOptions.tooltips.bodyFontColor = newFontColor;
        barChartOptions.tooltips.borderColor = newGridColor;
      }
      window.myBarChart.data.datasets[0].backgroundColor = newSecondaryAccent;
      window.myBarChart.data.datasets[0].borderColor = darkenColor(
        newSecondaryAccent,
        10
      );
      window.myBarChart.update();
    }
  }

  function hexToRgb(hex) {
    var result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
    return result
      ? `${parseInt(result[1], 16)}, ${parseInt(result[2], 16)}, ${parseInt(
          result[3],
          16
        )}`
      : '0,0,0';
  }
  function darkenColor(hex, percent) {
    hex = hex.replace(/^\s*#|\s*$/g, '');
    if (hex.length == 3) {
      hex = hex.replace(/(.)/g, '$1$1');
    }
    var r = parseInt(hex.substr(0, 2), 16),
      g = parseInt(hex.substr(2, 2), 16),
      b = parseInt(hex.substr(4, 2), 16);
    r = parseInt((r * (100 - percent)) / 100);
    g = parseInt((g * (100 - percent)) / 100);
    b = parseInt((b * (100 - percent)) / 100);
    r = r < 0 ? 0 : r;
    g = g < 0 ? 0 : g;
    b = b < 0 ? 0 : b;
    return (
      '#' +
      r.toString(16).padStart(2, '0') +
      g.toString(16).padStart(2, '0') +
      b.toString(16).padStart(2, '0')
    );
  }
});
