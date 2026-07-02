document.addEventListener('DOMContentLoaded', function() {
  // Mobile nav toggle
  var toggle = document.getElementById('navToggle');
  var mobileNav = document.getElementById('mobileNav');
  var closeBtn = document.getElementById('mobileNavClose');
  if (toggle && mobileNav) {
    toggle.addEventListener('click', function() { mobileNav.classList.toggle('active'); document.body.style.overflow = mobileNav.classList.contains('active') ? 'hidden' : ''; });
    if (closeBtn) closeBtn.addEventListener('click', function() { mobileNav.classList.remove('active'); document.body.style.overflow = ''; });
    mobileNav.addEventListener('click', function(e) { if (e.target === mobileNav) { mobileNav.classList.remove('active'); document.body.style.overflow = ''; } });
  }
  // Mobile subnav toggle
  document.querySelectorAll('.has-sub-mobile > a').forEach(function(el) {
    el.addEventListener('click', function(e) {
      e.preventDefault();
      var sub = this.nextElementSibling;
      if (sub) sub.classList.toggle('open');
    });
  });
  // Candle lighting
  var candles = document.querySelectorAll('.candle');
  candles.forEach(function(c) {
    c.addEventListener('click', function() {
      this.classList.toggle('lit');
      var msg = this.classList.contains('lit') ? 'Your prayer intention has been lifted up!' : 'Candle extinguished';
      showToast(msg);
    });
  });
  // Toast notification
  function showToast(msg) {
    var t = document.getElementById('toast');
    if (!t) { t = document.createElement('div'); t.id = 'toast'; t.className = 'toast'; document.body.appendChild(t); }
    t.textContent = msg;
    t.classList.add('show');
    setTimeout(function() { t.classList.remove('show'); }, 3000);
  }
  // Active nav highlighting
  var path = window.location.pathname.replace(/\/$/,'') || '/index.html';
  document.querySelectorAll('nav a, .mobile-nav a').forEach(function(a) {
    var href = a.getAttribute('href');
    if (href && path.indexOf(href) !== -1 && href !== '/') a.classList.add('active');
  });
  // Dropdown hover fix for touch
  if ('ontouchstart' in window) {
    document.querySelectorAll('nav ul li.has-sub').forEach(function(li) {
      li.addEventListener('click', function(e) {
        var dd = this.querySelector('.dropdown');
        if (dd) { dd.style.display = dd.style.display === 'block' ? 'none' : 'block'; e.preventDefault(); }
      });
    });
  }
  // Typewriter animation
  var typewriterEl = document.getElementById('typewriterText');
  if (typewriterEl) {
    var verses = [
      { text: '"For God so loved the world that he gave his one and only Son, that whoever believes in him shall not perish but have eternal life."', ref: 'John 3:16' },
      { text: '"I can do all things through him who strengthens me."', ref: 'Philippians 4:13' },
      { text: '"The Lord is my shepherd; I shall not want."', ref: 'Psalm 23:1' },
      { text: '"For I know the plans I have for you, declares the Lord, plans for welfare and not for evil, to give you a future and a hope."', ref: 'Jeremiah 29:11' },
      { text: '"Be strong and courageous. Do not be frightened, and do not be dismayed, for the Lord your God is with you wherever you go."', ref: 'Joshua 1:9' },
      { text: '"Come to me, all who labor and are heavy laden, and I will give you rest."', ref: 'Matthew 11:28' },
      { text: '"Trust in the Lord with all your heart, and do not lean on your own understanding."', ref: 'Proverbs 3:5' },
      { text: '"The Lord is my light and my salvation; whom shall I fear?"', ref: 'Psalm 27:1' },
      { text: '"And we know that for those who love God all things work together for good."', ref: 'Romans 8:28' },
      { text: '"But those who hope in the Lord will renew their strength."', ref: 'Isaiah 40:31' },
      { text: '"Rejoice in the Lord always; again I will say, rejoice."', ref: 'Philippians 4:4' },
      { text: '"The name of the Lord is a strong tower; the righteous man runs into it and is safe."', ref: 'Proverbs 18:10' },
      { text: '"And it shall come to pass that everyone who calls upon the name of the Lord shall be saved."', ref: 'Acts 2:21' },
      { text: '"Delight yourself in the Lord, and he will give you the desires of your heart."', ref: 'Psalm 37:4' },
      { text: '"Fear not, for I am with you; be not dismayed, for I am your God; I will strengthen you, I will help you, I will uphold you with my righteous right hand."', ref: 'Isaiah 41:10' },
      { text: '"Therefore I tell you, whatever you ask in prayer, believe that you have received it, and it will be yours."', ref: 'Mark 11:24' }
    ];
    var idx = 0; var charIdx = 0; var isDeleting = false; var speed = 50;
    var verseText = typewriterEl.querySelector('.verse-text');
    var verseRef = document.createElement('span');
    verseRef.className = 'verse-ref';
    typewriterEl.appendChild(verseRef);
    function typeIt() {
      var current = verses[idx];
      if (!isDeleting) {
        if (charIdx <= current.text.length) {
          verseText.textContent = current.text.substring(0, charIdx);
          charIdx++; speed = 40;
          setTimeout(typeIt, speed);
        } else {
          verseRef.textContent = current.ref;
          isDeleting = true; speed = 2000;
          setTimeout(typeIt, speed);
        }
      } else {
        if (charIdx >= 0) {
          verseText.textContent = current.text.substring(0, charIdx);
          charIdx--; speed = 20;
          setTimeout(typeIt, speed);
        } else {
          verseRef.textContent = '';
          isDeleting = false; idx = (idx + 1) % verses.length; charIdx = 0; speed = 500;
          setTimeout(typeIt, speed);
        }
      }
    }
    setTimeout(typeIt, 1000);
  }
  // Scroll animation
  var observer = new IntersectionObserver(function(entries) {
    entries.forEach(function(entry) {
      if (entry.isIntersecting) { entry.target.style.opacity = '1'; entry.target.style.transform = 'translateY(0)'; }
    });
  }, { threshold: 0.1 });
  document.querySelectorAll('.card, .prayer-card').forEach(function(el) {
    el.style.opacity = '0'; el.style.transform = 'translateY(30px)'; el.style.transition = 'all 0.6s ease';
    observer.observe(el);
  });
  // Bible verse API fetch
  var verseEl = document.getElementById('dailyVerse');
  if (verseEl) {
    fetch('https://labs.bible.org/api/?passage=random&type=json').then(function(r) { return r.json(); }).then(function(d) {
      if (d && d[0]) { verseEl.innerHTML = '"' + d[0].text + '"<span class="verse-ref">' + d[0].bookname + ' ' + d[0].chapter + ':' + d[0].verse + '</span>'; }
    }).catch(function() { verseEl.innerHTML = '"For God so loved the world that he gave his one and only Son, that whoever believes in him shall not perish but have eternal life."<span class="verse-ref">John 3:16</span>'; });
  }
  // Saint of the day
  var saintEl = document.getElementById('saintOfDay');
  if (saintEl) {
    var saints = [
      { name: 'St. Francis of Assisi', date: 'October 4', desc: 'Founder of the Franciscan Order, patron of ecology.' },
      { name: 'St. Teresa of Calcutta', date: 'September 5', desc: 'Missionary of Charity, known for her work with the poor.' },
      { name: 'St. John Paul II', date: 'October 22', desc: 'Pope who traveled the world, spreading the message of faith.' },
      { name: 'St. Padre Pio', date: 'September 23', desc: 'Franciscan friar known for stigmata and spiritual gifts.' },
      { name: 'St. Anthony of Padua', date: 'June 13', desc: 'Doctor of the Church, patron of lost things.' },
      { name: 'St. Michael the Archangel', date: 'September 29', desc: 'Leader of the army of God against Satan.' },
      { name: 'St. Joseph', date: 'March 19', desc: 'Patron of the universal Church and workers.' },
      { name: 'Our Lady of Fatima', date: 'May 13', desc: 'Apparition of the Virgin Mary to three shepherd children.' }
    ];
    var s = saints[Math.floor(Math.random() * saints.length)];
    saintEl.innerHTML = '<div class="saint-card"><div class="saint-icon">&#x1F54F;</div><h3>' + s.name + '</h3><p>' + s.desc + '</p><p><small>Feast Day: ' + s.date + '</small></p></div>';
  }
  // Liturgical calendar
  var calEl = document.getElementById('liturgicalCalendar');
  if (calEl) {
    var now = new Date(); var y = now.getFullYear();
    var seasons = [
      { name: 'Advent', start: 'November 30', end: 'December 24' },
      { name: 'Christmas', start: 'December 25', end: 'January 6' },
      { name: 'Lent', start: 'Ash Wednesday (March)', end: 'Holy Thursday' },
      { name: 'Easter', start: 'Easter Sunday (March/April)', end: 'Pentecost' },
      { name: 'Ordinary Time', start: 'After Christmas & Pentecost', end: 'Before Advent' }
    ];
    var html = '<ul style="list-style:none;padding:0">';
    seasons.forEach(function(s) { html += '<li style="padding:8px 0;border-bottom:1px solid #eee"><strong>' + s.name + ':</strong> ' + s.start + ' - ' + s.end + '</li>'; });
    html += '</ul>';
    calEl.innerHTML = html;
  }
});
