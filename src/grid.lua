local function bindToGrid(grid, pos)
    local row = math.ceil(
        math.min(
            math.max(
                pos[2] / grid.cellSize,
                1
            ),
            #grid
        )
    )
    local column = math.ceil(
        math.min(
            math.max(
                pos[1] / grid.cellSize,
                1
            ),
            #grid[1]
        )
    )

    return grid[row][column]
end

return {
    createGrid = function(windowDimensions, cellSize)
        local cellAmountX = windowDimensions[1] / cellSize
        local cellAmountY = windowDimensions[2] / cellSize

        local grid = {}
        grid.cellSize = cellSize

        for row = 1, cellAmountY do
            grid[row] = {}
            for column = 1, cellAmountX do
                local x = (column - 1) * cellSize
                local y = (row - 1) * cellSize
                -- basically 0 is dead 1 and 2 are different teams
                local state = 0
                grid[row][column] = {x, y, state}
            end
        end

        return grid
    end,

    drawGrid = function(grid, color, lineWidth)
        love.graphics.setColor(color)
        love.graphics.setLineWidth(lineWidth)

        for row = 1, #grid do
            for column = 1, #grid[row] do
                love.graphics.rectangle(
                    'line',
                    grid[row][column][1],
                    grid[row][column][2],
                    grid.cellSize, grid.cellSize
                )
            end
        end
    end,

    drawMouseSelection = function(grid, mousePos, color, lineWidth)
        love.graphics.setColor(color)
        love.graphics.setLineWidth(lineWidth)

        if mousePos then
            love.graphics.rectangle(
                'line',
                bindToGrid(grid, mousePos)[1],
                bindToGrid(grid, mousePos)[2],
                grid.cellSize, grid.cellSize
            )
        end
    end,

    drawCells = function(grid, team1Color, team2Color)
        for row = 1, #grid do
            for column = 1, #grid[row] do
                if grid[row][column][3] ~= 0 then
                    if grid[row][column][3] == 1 then
                        love.graphics.setColor(team1Color)
                    elseif grid[row][column][3] == 2 then
                        love.graphics.setColor(team2Color)
                    end
                    love.graphics.rectangle(
                        'fill',
                        grid[row][column][1],
                        grid[row][column][2],
                        grid.cellSize, grid.cellSize
                    )
                end
            end
        end
    end,
}