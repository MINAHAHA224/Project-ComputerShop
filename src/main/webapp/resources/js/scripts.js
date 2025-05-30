window.addEventListener('DOMContentLoaded', (event) => {
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
