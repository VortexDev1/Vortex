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
  console.log('DOM fully loaded!');

  const buttons = document.querySelectorAll('.button2');
  console.log(`Found ${buttons.length} buttons.`);

  buttons.forEach((button, index) => {
    console.log(`Adding click listener to button ${index + 1}`);

    button.addEventListener('click', function () {
      const filePath = this.getAttribute('data-file');
      console.log(`Button ${index + 1} clicked. URL: ${filePath}`);

      if (filePath) {
        window.open(filePath, '_blank');
      } else {
        console.error(`Button ${index + 1} has no valid "data-file" attribute.`);
      }
    });
  });
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
