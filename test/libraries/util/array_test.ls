/**
 * User: kristianmandrup
 * Date: 13/10/14
 * Time: 08:47
 */

array   = require '../../../lib/util/array'
flatten = array.flatten

expect = require 'chai' .expect

log = console.log

describe 'flatten' ->
  specify 'flatten list' ->
    expect flatten [1,[3,'abc', [\x]], 7] .to.eql [1,3,'abc', \x, 7]

  specify 'does not flatten any string' ->
    expect flatten 'abc' .to.eql 'abc'
