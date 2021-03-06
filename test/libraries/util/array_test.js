// Generated by LiveScript 1.2.0
/**
 * User: kristianmandrup
 * Date: 13/10/14
 * Time: 08:47
 */
(function(){
  var array, flatten, expect, log;
  array = require('../../../lib/util/array');
  flatten = array.flatten;
  expect = require('chai').expect;
  log = console.log;
  describe('flatten', function(){
    specify('flatten list', function(){
      return expect(flatten([1, [3, 'abc', ['x']], 7])).to.eql([1, 3, 'abc', 'x', 7]);
    });
    return specify('does not flatten any string', function(){
      return expect(flatten('abc')).to.eql('abc');
    });
  });
}).call(this);
