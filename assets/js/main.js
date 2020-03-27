const shareButtons = Array.from(document.querySelectorAll('.share-btn'));
const dropdowns = Array.from(document.querySelectorAll('.dropdown'));
const nav = document.querySelector('.nav');
const menu = nav.querySelector('#menu');

menu.addEventListener('click', function () {
  nav.classList.toggle('opened');
})

if (shareButtons) {
  shareButtons.forEach(shareButton => {
    const chart = JSON.parse(shareButton.dataset.chart);
    const type = shareButton.dataset.type;
    shareButton.addEventListener('click', () => {
      navigator.share(
        {
          title: 'Datasketch · Coronavirus',
          text: chart.title,
          url: `${location.origin}/${type ? 'datasets' : 'viz'}/${chart.uid}`
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

window.addEventListener('scroll', function() {
  if (window.pageYOffset > 100) {
    nav.classList.add('affix')
    return
  }
  nav.classList.remove('affix')
})
