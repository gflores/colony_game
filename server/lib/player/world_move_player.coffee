require("worldMovePlayer")
define("worldMovePlayer", ["world", "stringHelper", "sharedStringHelper"],  (world, stringHelper, sharedStringHelper) ->
    CreateData = () ->
        position = {x: 3, y: 3}
        range = {x: 3, y: 3}
        viewportCollection = new Meteor.Collection(null)
        return {
            position: position
            range: range
            viewportCollection: viewportCollection
        }
    SetupViewport = (viewportCollection, watchedSquareHandles, publisher) ->
        UpdateWatchedSquares = (viewportFields) ->
            for key, value of viewportFields
                if value == true
                    handle = world.squareCollections[stringHelper.WorldSquareCollectionName(key)].find().observeChanges(
                        added: (squareId, squareFields) ->
                            publisher.added(sharedStringHelper.ClientWorldSquareCollectionName(), squareId, squareFields)
                        removed: (squareId) ->
                            publisher.removed(sharedStringHelper.ClientWorldSquareCollectionName(), squareId)
                        changed: (squareId, squareFields) ->
                            publisher.changed(sharedStringHelper.ClientWorldSquareCollectionName(), squareId, squareFields)
                    )
                    watchedSquareHandles[stringHelper.WorldSquareCollectionName(key)] = handle
                else
                    watchedSquareHandles[stringHelper.WorldSquareCollectionName(key)].stop()
                    delete watchedSquareHandles[stringHelper.WorldSquareCollectionName(key)]
        viewportHandle = viewportCollection.find().observeChanges(
            added: (id, fields) ->
                UpdateWatchedSquares(fields)
            changed: (id, fields) ->
                UpdateWatchedSquares(fields)
            removed: (id) ->
                for key, value of watchedSquareHandles
                    value.stop()
                    delete watchedSquareHandles[key]
        )
        return {
            viewportHandle: viewportHandle
        }

    Meteor.publish(sharedStringHelper.WorldSquarePublicationName(), () ->
        if (this.userId == null)
            console.log("HAVE TO BE LOGGED MAN...")
            return
        console.log("Start publishing !")
        if (world.usersData.hasOwnProperty(this.userId) == false)
            world.usersData[this.userId] = {}
        data = CreateData()
        UpdateViewport(data.viewportCollection, data.position, data.range)

        # viewportDoc = {}
        # for y in [0..5]    
        #     for x in [0..5]
        #         viewportDoc[stringHelper.Coord2ToString(x, y)] = true
        # data.viewportCollection.insert(viewportDoc)

        world.usersData[this.userId].viewportCollection = data.viewportCollection
        world.usersData[this.userId].position = data.position
        world.usersData[this.userId].range = data.range
        watchedSquareHandles = {}
        setupData = SetupViewport(data.viewportCollection, watchedSquareHandles, this)
        this.ready()
        console.log("finished publishing !")

        this.onStop(() ->
            console.log("have been stopped !!")
            data.viewportCollection.remove({})
            setupData.viewportHandle.stop()
        )
    )

    UpdateViewport = (viewportCollection, pos, range) ->
        viewportDoc = {}
        for y in [(pos.y - range.y)..(pos.y + range.y)]
            for x in [(pos.x - range.x)..(pos.x + range.x)]
                viewportDoc[stringHelper.Coord2ToString(x, y)] = true
        viewportCollection.insert(viewportDoc)


    Meteor.methods({
        MovePlayerToPoint: (destinationPoint) ->
            data = world.usersData[this.userId]
            data.position = destinationPoint
            UpdateViewport(data.viewportCollection, data.position, data.range)
            return {
                worldPosition: data.position
                range: data.range
            }

        ChangeViewScope: (direction) ->
            CreateSquareCollection(x, y)
    })

    return {
        CreateData: CreateData
        SetupViewport: SetupViewport
    }
)