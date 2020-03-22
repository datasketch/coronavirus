const fs = require('fs');
const page = require('webpage').create();


var fs = require('fs');
var path = 'data/ins/ins.html'

//page.open('https://e.infogram.com/3a4c9dd3-fbb8-4f59-8d82-eb1edc01604b', function (status) {
//  var content = page.content;
//  fs.write(path,content,'w')
page.open('https://infogram.com/covid-2019-ins-colombia-1hnq41zg9ord63z', function (status) {
  const content = page.content;
  fs.write('static/data/ins/prep/ins.html', content, 'w');
  phantom.exit();
});
