/* ============================================================
   Go Beyond Challenge — Main JS
   ============================================================ */

document.addEventListener('DOMContentLoaded', () => {

  /* ---- Mobile nav toggle ---- */
  const toggle = document.getElementById('nav-toggle');
  const nav    = document.getElementById('main-nav');
  if (toggle && nav) {
    toggle.addEventListener('click', () => {
      toggle.classList.toggle('open');
      nav.classList.toggle('open');
    });
    // Dropdown toggle on mobile (tap)
    nav.querySelectorAll('.has-dropdown > a').forEach(link => {
      link.addEventListener('click', e => {
        if (window.innerWidth <= 768) {
          e.preventDefault();
          link.parentElement.classList.toggle('mobile-open');
        }
      });
    });
  }

  /* ---- Set active nav link ---- */
  const path = window.location.pathname.replace(/\/$/, '') || '/index.html';
  document.querySelectorAll('#main-nav a').forEach(a => {
    const href = a.getAttribute('href');
    if (href && path.endsWith(href.replace(/\/$/, ''))) {
      a.closest('li')?.classList.add('active');
    }
  });

  /* ---- Image fallback to CDN ---- */
  const CDN = 'https://www.gobeyondchallenge.com/wp-content/uploads/';
  document.querySelectorAll('img[data-cdn]').forEach(img => {
    img.addEventListener('error', function() {
      if (!this.src.includes('gobeyondchallenge.com')) {
        this.src = CDN + this.dataset.cdn;
      }
    }, { once: true });
  });

  /* ---- Smooth scroll for anchor links ---- */
  document.querySelectorAll('a[href^="#"]').forEach(a => {
    a.addEventListener('click', e => {
      const target = document.querySelector(a.getAttribute('href'));
      if (target) {
        e.preventDefault();
        target.scrollIntoView({ behavior: 'smooth', block: 'start' });
      }
    });
  });

  /* ---- Close nav on outside click (mobile) ---- */
  document.addEventListener('click', e => {
    if (nav && nav.classList.contains('open')) {
      if (!nav.contains(e.target) && !toggle.contains(e.target)) {
        nav.classList.remove('open');
        toggle.classList.remove('open');
      }
    }
  });

  /* ── Preview watermark ── */
  const wm = document.createElement('div');
  wm.setAttribute('aria-hidden', 'true');
  wm.style.cssText = [
    'position:fixed',
    'top:50%',
    'left:50%',
    'transform:translate(-50%,-50%)',
    'width:100vw',
    'text-align:center',
    'font-family:Oswald,sans-serif',
    'font-size:18vw',
    'font-weight:700',
    'letter-spacing:-.02em',
    'text-transform:uppercase',
    'color:#000',
    'opacity:0.08',
    'pointer-events:none',
    '-webkit-user-select:none',
    'user-select:none',
    'z-index:9999',
    'white-space:nowrap',
  ].join(';');
  wm.textContent = 'Preview';
  document.body.appendChild(wm);
});
