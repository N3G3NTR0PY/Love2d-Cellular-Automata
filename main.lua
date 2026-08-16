local grid = require('src.grid')
local config = require('src.config')
local colors = require('src.colors')

local state = {}

function love.load()
    state.windowDimensions = {
        love.graphics.getWidth(),
        love.graphics.getHeight()
    }
    state.currentGrid = grid.createGrid(
        state.windowDimensions,
        config.cellSize
    )
end

function love.mousemoved(x, y)
    state.mousePos = {x, y}
end

function love.draw()
    love.graphics.clear(colors.background)
    grid.drawCells(
        state.currentGrid,
        colors.player_one,
        colors.player_two
    )
    grid.drawGrid(
        state.currentGrid,
        colors.grid_line,
        5
    )
    grid.drawMouseSelection(
        state.currentGrid,
        state.mousePos,
        colors.grid_active,
        5
    )
end