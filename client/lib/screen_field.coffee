define("screenField", [], () ->
    ScreenField = new Meteor.Collection(null)

    ScreenField.helpers({
        GetCaseSizeX: () ->
            this.dimension.x / this.size.x
        GetCaseSizeY: () ->
            this.dimension.y / this.size.y
    })
    ScreenField.insert({
        size: {x: 20, y: 20}
        dimension: {x: 500, y: 500}
    })
    return {
        Get: () ->
            ScreenField.findOne()
        collection: ScreenField
    }
)