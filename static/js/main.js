const shareButtons = Array.from(document.querySelectorAll('.chart .btn'));

shareButtons.forEach(shareButton => {
  const chart = JSON.parse(shareButton.dataset.chart);
  shareButton.addEventListener('click', () => {
    navigator.share(
      {
        title: 'Datasketch · Coronavirus',
        text: chart.title,
        url: `${location.href}${chart.path}`
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
