require("caseState")
define("caseState", ["mapData", "caseType", "sharedStringHelper"], (mapData, caseType, sharedStringHelper) ->
    CaseState = new Meteor.Collection(sharedStringHelper.WorldSquarePublicationName())
    Meteor.loginVisitor()
    Meteor.subscribe(sharedStringHelper.ClientWorldSquareCollectionName())

    ComputeBioCase = (kase) ->
        console.log("suce")
        if (kase.caseType == caseType.Bio)
            mapData.current.DrawBioCase(kase.x, kase.y)
        else
            mapData.current.HideBioCase(kase.x, kase.y)

    CaseState.find().observe({
        added: (doc) ->
            ComputeBioCase(doc)
        removed: (doc) ->
            if (doc.caseType == caseType.Bio)
                mapData.current.HideBioCase(doc.x, doc.y)
        changed: (doc, oldDoc) ->
            if (doc.caseType != oldDoc.caseType)
                ComputeBioCase(doc)
    })

#     ComputeBioCases = (caseMap) ->
#         for key, value of caseMap.cases
#             [x, y] = key.split("|").map((x) -> parseInt(x))
# #            console.log("x: #{x}, y: #{y}, value: #{value}")
#             if (value.caseType == caseType.Bio)
#                 mapData.current.DrawBioCase(x, y)
#             else
#                 mapData.current.HideBioCase(x, y)
#         mapData.current.layerBioCase.batchDraw()

#     CaseState.find().observe({
#         added: (doc) ->
#             console.log("added!")
#             ComputeBioCases(doc)
#         changed: (doc, oldDoc) ->
#             ComputeBioCases(doc)
#     })
    return {
        collection: CaseState
    }
)