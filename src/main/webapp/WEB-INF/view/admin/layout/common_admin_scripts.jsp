<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script
  src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
  crossorigin="anonymous"
></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script
  src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
  crossorigin="anonymous"
></script>
<script
  src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
  crossorigin="anonymous"
></script>
<script src="<c:url value='/js/scripts.js'/>"></script>
<script src="<c:url value='/client/js/goong-autocomplete.js'/>"></script>
<script>
  document.addEventListener('DOMContentLoaded', function () {
    const sidebarToggle = document.getElementById('sidebarToggle');
    const sidebarToggleMobile = document.getElementById('sidebarToggleMobile');
    const adminLayoutWrapper = document.querySelector('.admin-layout-wrapper');

    if (sidebarToggle) {
      sidebarToggle.addEventListener('click', (event) => {
        event.preventDefault();
        adminLayoutWrapper.classList.toggle('sidebar-toggled');
        localStorage.setItem(
          'adminSidebarToggled',
          adminLayoutWrapper.classList.contains('sidebar-toggled')
        );
      });
    }
    if (sidebarToggleMobile) {
      sidebarToggleMobile.addEventListener('click', (event) => {
        event.preventDefault();
        adminLayoutWrapper.classList.remove('sidebar-toggled-mobile');
      });
    }
    const mainSidebarToggler = document.querySelector(
      '.sb-topnav .btn-link#sidebarToggle'
    );
    if (mainSidebarToggler && adminLayoutWrapper) {
      mainSidebarToggler.addEventListener('click', function (e) {
        e.preventDefault();
        if (window.innerWidth < 992) {
          adminLayoutWrapper.classList.toggle('sidebar-toggled-mobile');
        } else {
          adminLayoutWrapper.classList.toggle('sidebar-collapsed');
          localStorage.setItem(
            'adminSidebarCollapsed',
            adminLayoutWrapper.classList.contains('sidebar-collapsed')
          );
        }
      });
    }
    if (
      window.innerWidth >= 992 &&
      localStorage.getItem('adminSidebarCollapsed') === 'true' &&
      adminLayoutWrapper
    ) {
      adminLayoutWrapper.classList.add('sidebar-collapsed');
    }
    const currentPath = window.location.pathname;
    const navLinks = document.querySelectorAll('.sidebar-nav .nav-link');
    navLinks.forEach((link) => {
      const linkPath = new URL(link.href).pathname;
      if (linkPath === currentPath) {
        link.classList.add('active');
        const collapseParent = link.closest('.collapse');
        if (collapseParent) {
          const bsCollapse = new bootstrap.Collapse(collapseParent, {
            toggle: false,
          });
          if (!collapseParent.classList.contains('show')) {
            bsCollapse.show();
          }
          const parentLink = document.querySelector(
            `a[data-bs-target="#${collapseParent.id}"]`
          );
          if (parentLink) {
            parentLink.classList.add('active');
            parentLink.setAttribute('aria-expanded', 'true');
          }
        }
      } else {
        if (
          link.href.endsWith(
            currentPath.substring(0, currentPath.lastIndexOf('/'))
          ) &&
          currentPath.lastIndexOf('/') > link.href.lastIndexOf('/')
        ) {
        } else {
        }
      }
    });
    navLinks.forEach((link) => {
      const linkPath = new URL(link.href).pathname;
      if (
        currentPath.startsWith(linkPath) &&
        linkPath !== currentPath &&
        link.closest('.collapse')
      ) {
        link.classList.add('active-sub');
      }
    });
  });
</script>
