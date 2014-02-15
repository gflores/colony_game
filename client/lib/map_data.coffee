define("mapData", ["screenField"], (screenField) ->
    class MapData
        InitAll: () ->
            @stage = new Kinetic.Stage({
                container: 'container',
                width: screenField.Get().dimension.x,
                height: screenField.Get().dimension.y
            })
        BuildMap: () ->
            @layerBaseCase = new Kinetic.Layer()
            @layerBioCase = new Kinetic.Layer()
            @baseCases = []
            @bioCases = []
            for y in [0..screenField.Get().size.y - 1]
                for x in [0..screenField.Get().size.x - 1]
                    CreateCase = (rect, casesArray, layer) ->
                        casesArray.push(rect)
                        layer.add(rect)

                    baseRect = new Kinetic.Rect({
                        x: x * screenField.Get().GetCaseSizeX(),
                        y: y * screenField.Get().GetCaseSizeY(),
                        width: screenField.Get().GetCaseSizeX(),
                        height: screenField.Get().GetCaseSizeY(),
                        fill: 'grey',
                        stroke: 'black',
                        strokeWidth: 1
                    })
                    CreateCase(baseRect, @baseCases, @layerBaseCase)
                    bioRect = new Kinetic.Rect({
                        x: x * screenField.Get().GetCaseSizeX(),
                        y: y * screenField.Get().GetCaseSizeY(),
                        width: screenField.Get().GetCaseSizeX(),
                        height: screenField.Get().GetCaseSizeY(),
                        fill: 'red',
                        stroke: 'black',
                        strokeWidth: 1
                    })
                    bioRect.hide()
                    CreateCase(bioRect, @bioCases, @layerBioCase)
            @stage.add(@layerBaseCase)
            @stage.add(@layerBioCase)
        DrawBioCase: (x, y) ->
            @bioCases[y * screenField.Get().size.x + x].show()
            @layerBioCase.batchDraw()
        HideBioCase: (x, y) ->
            @bioCases[y * screenField.Get().size.x + x].hide()
            @layerBioCase.batchDraw()


    return {current: new MapData()}
)
