<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="chatbot-widget-container" class="chatbot-closed">
  <div id="chatbot-toggle-button">
    <i class="fas fa-comments"></i>
    <span class="chatbot-badge" style="display: none"></span>
  </div>

  <div id="chatbot-window">
    <div class="chatbot-header">
      <div class="chatbot-avatar">
        <img
          src="<c:url value='/client/img/favicon_3tlap.png'/>"
          alt="3TLap Bot"
        />
      </div>
      <div class="chatbot-title-status">
        <span class="chatbot-title">3TLap Assistant</span>
        <span class="chatbot-status">Online</span>
      </div>
      <button id="chatbot-minimize-button"><i class="fas fa-minus"></i></button>
      <button id="chatbot-close-button-widget">
        <i class="fas fa-times"></i>
      </button>
    </div>
    <div id="chatbot-messages-container">
      <div class="chatbot-message bot">
        <div class="message-avatar">
          <img
            src="<c:url value='/client/img/favicon_3tlap.png'/>"
            alt="3TLap Bot"
          />
        </div>
        <div class="message-content">
          <p>
            Xin chào! Tôi là trợ lý ảo của 3TLap. Tôi có thể giúp gì cho bạn?
          </p>
        </div>
      </div>
    </div>
    <div id="chatbot-suggested-questions" class="mt-2"></div>
    <div class="chatbot-input-area">
      <textarea
        id="chatbot-input"
        placeholder="Nhập câu hỏi của bạn..."
        rows="1"
      ></textarea>
      <button id="chatbot-send-button">
        <i class="fas fa-paper-plane"></i>
      </button>
    </div>
    <div class="chatbot-footer-brand">Powered by <strong>3TLap AI</strong></div>
  </div>
</div>
