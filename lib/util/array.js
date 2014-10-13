/**
 * User: kristianmandrup
 * Date: 13/10/14
 * Time: 08:38
 */
var flatten = function(toFlatten) {
  var isArray = Object.prototype.toString.call(toFlatten) === '[object Array]';

  if (isArray && toFlatten.length > 0) {
    var head = toFlatten[0];
    var tail = toFlatten.slice(1);

    return flatten(head).concat(flatten(tail));
  } else {
    return [].concat(toFlatten);
  }
};

module.exports = {
  flatten: flatten
}
