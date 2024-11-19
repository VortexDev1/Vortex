function toggleMenu() {
  const menuLinks = document.getElementById('menu-links');
  menuLinks.classList.toggle('show');
}

document.querySelector('.button1').addEventListener('click', function() {
  window.scrollTo({
    top: document.querySelector('.mods').offsetTop,
    behavior: 'smooth'
  });
});

document.querySelector('.aboutbtn').addEventListener('click', function() {
  window.scrollTo({
    top: document.querySelector('.about').offsetTop,
    behavior: 'smooth'
  });
});

document.querySelector('.downloadbtn').addEventListener('click', function() {
  window.scrollTo({
    top: document.querySelector('.mods').offsetTop,
    behavior: 'smooth'
  });
});

document.querySelector('.linksY').addEventListener('click', function() {
  window.open('https://www.youtube.com', '_blank');
});

document.querySelector('.linksD').addEventListener('click', function() {
  window.open('https://www.discord.com', '_blank');
});

document.querySelectorAll('.button2').forEach(button => {
  button.addEventListener('click', function() {
    const filePath = button.getAttribute('data-file');
    const link = document.createElement('a');
    link.href = filePath;
    link.download = filePath.split('/').pop();

    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
  });
});
              
