<!-- JSP Path: admin/layout/footer.jsp -->
<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<footer class="py-4 bg-light mt-auto footer-admin">
  <div class="container-fluid px-4">
    <div class="d-flex align-items-center justify-content-between small">
      <div class="text-muted">
        Bản quyền © 3TLap Admin ${java.time.Year.now()}
      </div>
      <div>
        <%-- <a href="#">Privacy Policy</a>
        ·
        <a href="#">Terms & Conditions</a> --%>
      </div>
    </div>
  </div>
</footer>
