const shareButtons = Array.from(document.querySelectorAll('.chart .share-btn'));

shareButtons.forEach(shareButton => {
  const chart = JSON.parse(shareButton.dataset.chart);
  shareButton.addEventListener('click', () => {
    navigator.share(
      {
        title: 'Datasketch · Coronavirus',
        text: chart.title,
        // url: `${location.href}${chart.path}`
        url: `${location.href}` + 'vis/' + chart.uid
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
