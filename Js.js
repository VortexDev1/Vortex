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
document.querySelector('.Gggg').addEventListener('click', function() {
  window.open('index.html');
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

document.addEventListener('DOMContentLoaded', () => {
  const buttons = document.querySelectorAll('.button2');
  console.log(`Found ${buttons.length} buttons.`);

  buttons.forEach((button, index) => {
    console.log(`Adding click listener to button ${index + 1}`);
    button.addEventListener('click', function () {
      const url = this.getAttribute('data-file');
      console.log(`Button ${index + 1} clicked. URL: ${url}`);
      if (url) {
        window.open(url, '_blank');
      } else {
        console.error(`Button ${index + 1} does not have a valid URL.`);
      }
    });
  });

  if (buttons.length === 0) {
    console.error('No buttons found.');
  }
});






    
/*
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
 */
