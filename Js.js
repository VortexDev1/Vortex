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
  // Select all buttons with the class 'button2'
  const buttons = document.querySelectorAll('.button2');

  // Loop through each button and add an event listener
  buttons.forEach(button => {
    button.addEventListener('click', function () {
      const filePath = this.getAttribute('data-file'); // Get URL from 'data-file'
      if (filePath) {
        window.open(filePath, '_blank'); // Open the URL in a new tab
      } else {
        console.error('No URL specified in the data-file attribute.');
      }
    });
  });

  if (buttons.length === 0) {
    console.error('No buttons with the class "button2" were found.');
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
