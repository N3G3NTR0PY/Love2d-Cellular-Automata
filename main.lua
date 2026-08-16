local grid = require('src.grid')
local config = require('src.config')
local colors = require('src.colors')

local state = setmetatable({}, { __index = config })

function love.load()
    state.windowDimensions = {
        love.graphics.getWidth(),
        love.graphics.getHeight()
    }
    state.currentGrid = grid.createGrid(
        state.windowDimensions,
        state.cellSize
    )
end

function love.mousefocus(focus)
    if not focus then
        state.selectedCell = nil
    end
end

function love.mousemoved(x, y)
    state.mousePos = {x, y}
    state.selectedCell = grid.updateSelectedCell(
        state.currentGrid,
        state.mousePos
    )
end

function love.mousepressed(key, scancode, isrepeat)
    if key == state.placeKey and not isrepeat then
        
    end
end

function love.draw()
    love.graphics.clear(state.backgroundColor)
    grid.drawCells(
        state.currentGrid,
        state.player1Color,
        state.player2Color
    )
    grid.drawGrid(
        state.currentGrid,
        state.gridColor,
        state.gridLineWidth
    )
    grid.drawMouseSelection(
        state.currentGrid,
        state.selectedCell,
        state.gridActiveColor,
        state.gridLineWidth
    )
end

function love.update(dt)

end