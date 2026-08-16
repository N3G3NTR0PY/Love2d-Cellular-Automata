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

local players = 2
local turn = 1
function love.mousepressed(x, y, button, istouch, presses)
    if button ~= state.placeKey then return end
    if grid.spawnCell(
        state.selectedCell,
        turn
    )
    then
        turn = (turn % players) + 1
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