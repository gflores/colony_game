require(["utils"], (utils) ->
    Meteor.setTimeout (() ->
#        x = 0
#        caseState.collection.remove({})
        # console.log("START")
        # for y in [0..100]
        #     for x in [0..20]
        #         caseState.collection.insert({x: x, y: y, caseType: "bio"})
        # console.log("FINISH")

        while (true)
            console.log("coucou")
            # caseState.collection.insert({x: x, y: 1, caseType: "bio"})
            # x++
            utils.Wait(1000)
    )
)