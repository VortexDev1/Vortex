let clickCount = 0;
const continueBtn = document.getElementById('continue-btn');
const clickCountDisplay = document.getElementById('click-count');
const switchModeBtn = document.getElementById('switch-mode');
const body = document.body;

continueBtn.addEventListener('click', () => {
    clickCount++;
    clickCountDisplay.textContent = `Clicks: ${clickCount}`;
    if (clickCount === 4) {
        window.location.href = 'your-file.zip'; // Change this to your file path
    }
});

switchModeBtn.addEventListener('click', () => {
    if (body.classList.contains('light-mode')) {
        body.classList.remove('light-mode');
        switchModeBtn.textContent = 'Switch to Light Mode';
    } else {
        body.classList.add('light-mode');
        switchModeBtn.textContent = 'Switch to Dark Mode';
    }
});

setInterval(() => {
    if (clickCount > 0 && clickCount < 4) {
        clickCountDisplay.textContent = `Clicks: ${clickCount} - ${4 - clickCount} more to download`;
    }
}, 1000);
