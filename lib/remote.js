var http = require('http');
var request = require('request');

var download = function(url, dest, cb) {
  var file = fs.createWriteStream(dest);
  http.get(url, function(response) {
    response.pipe(file);
    file.on('finish', function() {
      file.close(cb);  // close() is async, call cb after close completes.
    });
  }).on('error', function(err) { // Handle errors
    fs.unlink(dest); // Delete the file async. (But we don't check the result)
    if (cb) cb(err.message);
  });
};

var retrieve = function (uri, cb) {
  console.log('fetching', uri);
  return request.get(uri, function (error, response, body) {
    console.log('response', response);
    if (!error && response.statusCode == 200) {
      console.log(JONS.parse(body));
      cb(body());
    } else {
      console.error('error', err);
      return null;
    }
  });
};


module.exports = {
  download: download,
  retrieve: retrieve,
};

