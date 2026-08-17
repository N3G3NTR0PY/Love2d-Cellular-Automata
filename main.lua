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

local paused = true
function love.keypressed(key)
    if key == state.pauseKey then
        paused = not paused
    end
end

local turn = 1
function love.mousepressed(x, y, button, istouch, presses)
    if button ~= state.placeKey or not paused then return end
    if grid.spawnCell(
        state.selectedCell,
        turn
    )
    then
        turn = (turn % 2) + 1
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

local updateTimer = 0
function love.update(dt)
    updateTimer = updateTimer + dt
    if not paused and updateTimer >= state.updateInterval then
        grid.updateGrid(state.currentGrid)
        updateTimer = 0
    end
end