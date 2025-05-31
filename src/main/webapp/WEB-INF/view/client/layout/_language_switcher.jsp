<%-- File: WEB-INF/view/client/layout/_language_switcher.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="language-switcher-container">
    <%-- Vietnamese Flag --%>
    <spring:message code="layout.header.lang.vietnamese.title" var="vietnameseTitle" htmlEscape="false" />
    <spring:message code="layout.header.lang.vietnamese.alt" var="vietnameseAlt" htmlEscape="false" />
    <a href="?lang=vi_VN" title="${vietnameseTitle}" class="language-flag">
        <img src="<c:url value='/images/flag/flag-vn.png'/>" alt="${vietnameseAlt}" />
    </a>

    <%-- English (US) Flag --%>
    <spring:message code="layout.header.lang.english.title" var="englishTitle" htmlEscape="false" />
    <spring:message code="layout.header.lang.english.alt" var="englishAlt" htmlEscape="false" />
    <a href="?lang=en_US" title="${englishTitle}" class="language-flag">
        <img src="<c:url value='/images/flag/flag-us.png'/>" alt="${englishAlt}" />
    </a>
</div>