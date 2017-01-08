-- player.lua

pOne = {
  type = "player",
  x = 25,
  y = 50,
  w = 25,
  h = 75,
  dx = 0, -- probs wont be needed
  dy = 0,
  speed = 30,
  filter = function(item, other)
  end
}

pTwo = {
  type = "player",
  x = 576 - 50,
  y = 50,
  w = 25,
  h = 75,
  dx = 0, -- probs wont be needed
  dy = 0,
  speed = 30,
  filter = function(item, other)
  end  
}

function loadPlayers()
  world:add(pOne, pOne.x, pOne.y, pOne.w, pOne.h)
  world:add(pTwo, pTwo.x, pTwo.y, pTwo.w, pTwo.h)
end

function updatePlayers(dt)
  local cols, len = 0, 0

  -- handle player one movement
  if love.keyboard.isDown("w") and pOne.y > 0 then
    pOne.dy = pOne.dy - pOne.speed * dt
  elseif love.keyboard.isDown("s") and pOne.y + pOne.h < windowHeight then
    pOne.dy = pOne.dy + pOne.speed * dt
  else
    pOne.dy = 0 -- will add deceleration later
  end

  -- handle player two movement
  if love.keyboard.isDown("up") and pTwo.y > 0 then
    pTwo.dy = pTwo.dy - pTwo.speed * dt
  elseif love.keyboard.isDown("down") and pTwo.y + pTwo.h < windowHeight then
    pTwo.dy = pTwo.dy + pTwo.speed * dt
  else
    pTwo.dy = 0
  end

  -- update player positions
  pOne.x, pOne.y, cols, len = world:move(pOne, pOne.x + pOne.dx, pOne.y + pOne.dy, pOne.filter)

  cols, len = 0, 0
  pTwo.x, pTwo.y, cols, len = world:move(pTwo, pTwo.x + pTwo.dx, pTwo.y + pTwo.dy, pTwo.filter)
end

function drawPlayers()
  -- draw player one
  love.graphics.rectangle("line", pOne.x, pOne.y, pOne.w, pOne.h)

  -- draw player two
  love.graphics.rectangle("line", pTwo.x, pTwo.y, pTwo.w, pTwo.h)
end
