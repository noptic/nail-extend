# nail-extend
# https://github.com/Oliver/nail-extend
#
# Copyright (c) 2013 noptic
# Licensed under the MIT license.
_ = require('underscore')
module.exports.augment = (newClass) ->
  if ! _.isUndefined newClass.definition.extend
    constructor           = newClass.constructor
    newClass::            = new newClass.definition.extend()
    newClass::constructor = constructor
    newClass::$parent     = newClass.definition.extend
  return this