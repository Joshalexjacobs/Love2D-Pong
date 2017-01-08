--walls.lua

local topWall = {
  type = "wall",
  x = 0,
  y = 0,
  w = windowWidth,
  h = 2,
}

local botWall = {
  type = "wall",
  x = 0,
  y = windowHeight,
  w = windowWidth,
  h = 2,
}


function loadWalls()
  topWall.w, botWall.w, botWall.y = windowWidth, windowWidth, windowHeight - 2
  world:add(topWall, topWall.x, topWall.y, topWall.w, topWall.h)
  world:add(botWall, botWall.x, botWall.y, botWall.w, botWall.h)
end

function drawWalls()
  love.graphics.rectangle("fill", topWall.x, topWall.y, topWall.w, topWall.h)
  love.graphics.rectangle("fill", botWall.x, botWall.y, botWall.w, botWall.h)
end
