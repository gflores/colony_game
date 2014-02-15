define("syncCollection", [], () ->
    GenerateHandlerForSync: (publisher, cursor, collectionName, observeChange = true)->
        callbacks = {
            added: (id, fields) ->
#                console.log("ADDED: #{id}")
                publisher.added(collectionName, id, fields)
            removed: (id) ->
#                console.log("REMOVED: #{id}")
                publisher.removed(collectionName, id)
        }
        if (observeChange)
            callbacks["changed"] = (id, fields) ->
#                console.log("CHANGED: #{id}")
                publisher.changed(collectionName, id, fields)
        cursor.observeChanges(callbacks)
)