document.addEventListener('DOMContentLoaded', () => {
    const dialog = document.getElementById('update-dialog');
    const closeBtn = document.querySelector('.close-btn');
    const gotItBtn = document.getElementById('DoneBtn');

    // Show the dialog when the page loads
    dialog.style.display = 'flex';

    // Hide the dialog when the close button is clicked
    closeBtn.addEventListener('click', () => {
        dialog.style.display = 'none';
    });

    // Hide the dialog when the "Got it!" button is clicked
    gotItBtn.addEventListener('click', () => {
        dialog.style.display = 'none';
    });
});
