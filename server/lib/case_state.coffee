# define("caseState", ["syncCollection", "caseType"], (syncCollection, caseType) ->
#     CaseState = new Meteor.Collection(null)
#     #CECI PREND PAS MAL DE CPU !!
#     includeFields = {}
#     currentPublish = null
#     currentHandle = null
#     Meteor.publish("case_state", (fields) ->
#         console.log("starting publish");
#         currentPublish = this
#         handle = syncCollection.GenerateHandlerForSync(this, CaseState.find({}, {fields: fields}), "case_state")
#         this.ready()
#         this.onStop(() ->
# #            currentHandle.stop()
# #            handle.stop()
#             console.log("have been stopped !!")
#         )
#     )
#     Meteor.methods({
#         StopPublish: () ->
#             currentPublish.stop()
#         SetFields: (f) ->
#             includeFields = f
#         TestCase: () ->
#             CaseState.remove({})
#             console.log("START")
#             for y in [0..100]
#                 for x in [0..20]
#                     CaseState.insert({_id: "#{x}|#{y}", x: x, y: y, caseType: "bio"})
#             console.log("FINISH")

#         InitCases: (sizeX, sizeY) ->
#             CaseState.remove({})
#             console.log("START")
#             caseMap = {cases: {}}
#             for y in [0..sizeY-1]
#                 for x in [0..sizeX-1]
#                     caseMap.cases["#{x}|#{y}"] = {caseType: caseType.Bio}
#             #         CaseState.insert({_id: "#{x}|#{y}", x: x, y: y, caseType: caseType.Bio})
#             #         CaseState.insert({x: x, y: y, caseType: caseType.Bio})
#             CaseState.insert(caseMap)
#             console.log("FINISH")

#         AddBioCase: (x, y) ->
#             CaseState.update({x: x, y: y}, {$set: {caseType: caseType.Bio}})
#         RemoveBioCase: (x, y) ->
#             CaseState.update({x: x, y: y}, {$set: {caseType: caseType.Empty}})

#         TestSetAll: (sizeX, sizeY, type) ->
#             console.log("START")
#             caseMap = CaseState.findOne()
#             for y in [0..sizeY-1]
#                 for x in [0..sizeX-1]
#                     caseMap.cases["#{x}|#{y}"].caseType = type
# #                    CaseState.update({x: x, y: y}, {$set: {caseType: type}})
#             CaseState.update(caseMap._id, caseMap)
#             console.log("FINISH")
#     })
#     return {
#         collection: CaseState
#     }
# )