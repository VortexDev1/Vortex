// Smooth scroll to the popular mods section
document.querySelector('.cta-button').addEventListener('click', function() {
  window.scrollTo({
    top: document.querySelector('.popular-mods').offsetTop,
    behavior: 'smooth'
  });
});
