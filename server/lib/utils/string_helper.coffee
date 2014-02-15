define("stringHelper", [], () ->
    Coord2ToString = (a, b) ->
        "#{a};#{b}"
    StringToCoord2 = (str) ->
        return str.split(";").map((x) -> parseInt(x))

    WorldSquareCollectionName = (str) ->
        "world_square|#{str}"

    return {
        Coord2ToString: Coord2ToString
        StringToCoord2: StringToCoord2
        WorldSquareCollectionName: WorldSquareCollectionName
    }
)