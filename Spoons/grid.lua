local grid = {}

function grid.show() 
    hs.grid.show()
end

function grid.start() 
    hs.grid.setGrid(grid.cfg.gridSize)
    hs.grid.setMargins(grid.cfg.gridMargin)
end

function grid.stop() 
    if hs.grid then hs.grid:delete() end
end

return grid
