<!-- JSP Path: src/main/webapp/WEB-INF/view/admin/layout/footer.jsp -->

<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<footer class="py-3 bg-light mt-auto footer-admin-3tlap">
  <div class="container-fluid px-4">
    <div class="d-flex align-items-center justify-content-between small">
      <div class="text-muted">
        Bản quyền © 3TLap Admin ${java.time.Year.now()}
      </div>
      <div>
        <!--
        <a href="#">Privacy Policy</a>
        ·
        <a href="#">Terms & Conditions</a>
        -->
      </div>
    </div>
  </div>
  <button
    id="adminThemeToggle"
    class="theme-toggle-button"
    title="Chuyển đổi giao diện Sáng/Tối"
  >
    <i class="fas fa-moon"></i>
    <i class="fas fa-sun"></i>
  </button>
</footer>
