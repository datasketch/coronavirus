const shareButtons = Array.from(document.querySelectorAll('.share-btn'));
const dropdowns = Array.from(document.querySelectorAll('.dropdown'));
const header = document.querySelector('.header');

window.addEventListener('scroll', function() {
  if (window.pageYOffset > 100) {
    header.classList.add('affix')
    return
  }
  header.classList.remove('affix')
})

if (shareButtons) {
  shareButtons.forEach(shareButton => {
    const chart = JSON.parse(shareButton.dataset.chart);
    shareButton.addEventListener('click', () => {
      navigator.share(
        {
          title: 'Datasketch · Coronavirus',
          text: chart.title,
          url: `${location.href}viz/${chart.uid}`
        },
        {
          print: false,
          sms: false,
          skype: false,
          language: 'es'
        }
      );
    });
  });
}

if (dropdowns) {
  dropdowns.forEach(function(dropdown) {
    dropdown.addEventListener('click', function(event) {
      this.classList.toggle('opened');
    });
  });
}
