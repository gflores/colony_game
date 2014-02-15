define("world", ["stringHelper"], (stringHelper) ->
    usersData = {}
    squareCollections = {}
    squareCollectionNameCollection = new Meteor.Collection("square_collection_name")
    squareCollectionNameCollection._ensureIndex('name', {unique: 1});

    LoadAllSquareCollections = () ->
        for docName in squareCollectionNameCollection.find().fetch()
            if (squareCollections.hasOwnProperty(docName.name) == false)
                squareCollections[docName.name] = new Meteor.Collection(docName.name)

    DestroyAllSquareCollections = () ->
        for docName in squareCollectionNameCollection.find().fetch()
            squareCollectionNameCollection.remove({name: docName.name})
            squareCollections[docName.name].remove({})

    CreateSquareCollection = (x, y) ->
        name = stringHelper.WorldSquareCollectionName(stringHelper.Coord2ToString(x, y))
        if (squareCollectionNameCollection.findOne({name: name})?)
            return
        squareCollectionNameCollection.insert({name: name})
        if (squareCollections.hasOwnProperty(name) == false)
            squareCollections[name] = new Meteor.Collection(name)
        squareCollections[name].insert({_id: name, x: x, y: y, caseType: "bio"})

    DestroySquareCollection = (x, y) ->
        name = stringHelper.WorldSquareCollectionName(stringHelper.Coord2ToString(x, y))
        if (!squareCollectionNameCollection.findOne({name: name})?)
            return
        squareCollectionNameCollection.remove({name: name})
        squareCollections[name].remove({})

    LoadAllSquareCollections()
#    DestroyAllSquareCollections()
    console.log("starting creating square collection")
    for y in [0..30]
        for x in [0..30]
            CreateSquareCollection(x, y)
        console.log("y: #{y} start")
        # for i in [0..100]
        #     squareCollectionNameCollection.insert({name: "toto#{y}|#{i}"})
        # console.log("y: #{y} end")

    console.log("finished creating square collection")
    Meteor.methods({
        CreateSquareCollection: (x, y) ->
            CreateSquareCollection(x, y)
        DestroySquareCollection: (x, y) ->
            DestroySquareCollection(x, y)
        UpdateSquareCollection: (x, y, caseType) ->
            console.log("update started")
            name = stringHelper.WorldSquareCollectionName(stringHelper.Coord2ToString(x, y))
            squareCollections[name].update(name, $set:{caseType: caseType})
            console.log("update ended")
    })
    return {
        usersData: usersData
        squareCollections: squareCollections
    }
)