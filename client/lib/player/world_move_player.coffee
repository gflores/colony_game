require("worldMovePlayer")
define("worldMovePlayer", [], () ->
    collection = new Meteor.Collection(null)
    docId = collection.insert({
        position: {x: 0, y: 0}
        range: {x: 3, y: 3}
    })
    UpdateCollection = (modifier, option = null, callback = null) ->
        collection.update(docId, modifier, option, callback)

    MovePlayerToPoint = (point) ->
        Meteor.call("MovePlayerToPoint", point, (error, result) ->
            UpdateCollection({$set: {position: result.worldPosition, range: result.range}})
        )

    return {
        collection: collection
        UpdateCollection: UpdateCollection
        MovePlayerToPoint: MovePlayerToPoint
    }
)