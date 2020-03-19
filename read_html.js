// scrape_techstars.js

var webPage = require('webpage');
var page = webPage.create();

var fs = require('fs');
var path = 'data/ins/ins.html'

page.open('https://e.infogram.com/3a4c9dd3-fbb8-4f59-8d82-eb1edc01604b', function (status) {
  var content = page.content;
  fs.write(path,content,'w')
  phantom.exit();
});
