require(["mapData"], (mapData) ->
    
    Meteor.startup(() ->
        mapData.current.InitAll()
        mapData.current.BuildMap();
    )
)

@DebugMode = () ->
    @mapData = require("mapData")
    @caseState = require("caseState")
#    @mapRequest = require("mapRequester")
    @screenField = require("screenField")
    @caseType = require("caseType")