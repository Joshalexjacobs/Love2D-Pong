--walls.lua

local topWall = {
  type = "wall",
  name = "topWall",
  x = 0,
  y = 0,
  w = nil,
  h = 2,
  filter = function(item, other)

  end
}

local botWall = {
  type = "wall",
  name = "botWall",
  x = 0,
  y = nil,
  w = nil,
  h = 2,
  filter = function(item, other)

  end
}


function loadWalls()
  topWall.w, botWall.w, botWall.y = windowWidth, windowWidth, windowHeight - 2
  world:add(topWall, topWall.x, topWall.y, topWall.w, topWall.h)
  world:add(botWall, botWall.x, botWall.y, botWall.w, botWall.h)
end

function updateWalls()
  --topWall.x, topWall.y = world:move(topWall, topWall.x, topWall.y, topWall.filter)
  --botWall.x, botWall.y = world:move(botWall, botWall.x, botWall.y, botWall.filter)
end

function drawWalls()
  love.graphics.rectangle("fill", topWall.x, topWall.y, topWall.w, topWall.h)
  love.graphics.rectangle("fill", botWall.x, botWall.y, botWall.w, botWall.h)
end
