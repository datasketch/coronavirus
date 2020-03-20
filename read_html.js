const fs = require('fs');
const page = require('webpage').create();

page.open('https://infogram.com/covid-2019-ins-colombia-1hnq41zg9ord63z', function (status) {
  const content = page.content;
  fs.write('static/data/ins/ins.html', content, 'w');
  phantom.exit();
});
