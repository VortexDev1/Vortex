// Smooth scroll to the popular mods section
document.querySelector('.cta-button').addEventListener('click', function() {
  window.scrollTo({
    top: document.querySelector('.popular-mods').offsetTop,
    behavior: 'smooth'
  });
});
// Function to trigger download
document.getElementById('download-button').addEventListener('click', function() {
  // URL of the ZIP file (it could be a local path or a URL)
  const zipFileUrl = 'path_to_your_zip_file.zip'; // Replace with your file path
  
  // Create a temporary <a> element to trigger download
  const link = document.createElement('a');
  link.href = zipFileUrl;
  link.download = 'Vpanel1 .8.5.zip'; // Specify the name you want for the downloaded file

  // Programmatically click the link to trigger download
  link.click();
});
                                                         
