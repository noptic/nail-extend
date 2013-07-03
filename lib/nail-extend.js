(function() {
  var _;

  _ = require('underscore');

  module.exports.augment = function(newClass) {
    var constructor;
    if (!_.isUndefined(newClass.definition.extend)) {
      constructor = newClass.constructor;
      newClass.prototype = new newClass.definition.extend();
      newClass.prototype.constructor = constructor;
      newClass.prototype.$parent = newClass.definition.extend;
    }
    return this;
  };

}).call(this);
