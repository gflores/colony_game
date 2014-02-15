define("utils", [], () ->
    return {
        Wait: (time) ->
            Async.runSync (done) ->
                Meteor.setTimeout (() ->
                    done(null, 0)
                ), time
        }
)