subject = require('../lib/nail-extend.js')
nail = require('nail-core').use(
  subject, require('nail-methods')
)
_ = require("underscore")
module.exports =
  'structure':
    setUp: (done) ->
      done()

    'augment is a function': (test) ->
      test.expect 1
      test.ok (_.isFunction subject.augment),
        "module must export a 'augment' method"
      test.done()

  "methods":
    setUp: (done) ->
      @classes = {}
      sampleText =  'what in the name of sanity is that on your head?'
      @sampleText = sampleText
      nail.to @classes, 'test',
        parentClass:
          methods:
            sampleMethod: () -> sampleText
            overrideMe: () -> 'parent'
      nail.to @classes, 'test',
        childClass:
          extend: @classes.parentClass
          methods:
            overrideMe: () -> 'child'

      @instanceParent = new @classes.parentClass()
      @instanceChild = new @classes.childClass()
      done()

    "Parent class has methods": (test) ->
      test.expect 2
      test.equal @instanceParent.sampleMethod(), @sampleText
      test.equal @instanceParent.overrideMe(), 'parent'
      test.done()

    "Child is intanceof Parent": (test) ->
      test.expect 1
      test.ok @instanceChild instanceof @classes.parentClass
      test.done()

    "$parent is reference to parent": (test) ->
      test.expect 1
      test.equals @instanceChild.$parent, @classes.parentClass
      test.done()

    "Child class inherites sampleMethods": (test) ->
      test.expect 1
      test.equal @instanceChild.sampleMethod(), @sampleText
      test.done()

    "Child class override overrideMe": (test)->
      test.expect 1
      test.equal @instanceChild.overrideMe(), 'child'
      test.done()