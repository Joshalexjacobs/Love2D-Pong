-- player.lua

local pOne = {
  type = "player",
  ai = false, -- is this player computer controlled?
  x = 25,
  y = 200,
  w = 25,
  h = 75,
  dx = 0, -- probs wont be needed
  dy = 0,
  speed = 30,
  filter = function(item, other)
    if other.type == "wall" then
      return 'slide'
    end
  end
}

local pTwo = {
  type = "player",
  ai = false,
  x = 576 - 50,
  y = 200,
  w = 25,
  h = 75,
  dx = 0, -- probs wont be needed
  dy = 0,
  speed = 30,
  filter = function(item, other)
    if other.type == "wall" then
      return 'slide'
    end
  end
}

function loadPlayers()
  world:add(pOne, pOne.x, pOne.y, pOne.w, pOne.h)
  world:add(pTwo, pTwo.x, pTwo.y, pTwo.w, pTwo.h)
end

function updatePlayers(dt)
  local cols, len = 0, 0


  if pOne.ai == false then
    -- handle player one movement
    if love.keyboard.isDown("w") and pOne.y > 0 then
      if pOne.dy > 0 then pOne.dy = 0 end -- for quick turning around
      pOne.dy = pOne.dy - pOne.speed * dt
    elseif love.keyboard.isDown("s") and pOne.y + pOne.h < windowHeight then
      if pOne.dy < 0 then pOne.dy = 0 end
      pOne.dy = pOne.dy + pOne.speed * dt
    else -- paddle deceleration
      if pOne.dy > 0 then
        pOne.dy = math.max((pOne.dy - 100 * dt), 0)
      elseif pOne.dy < 0 then
        pOne.dy = math.min((pOne.dy + 100 * dt), 0)
      end
    end
  end

  if pOne.ai == false then
    -- handle player two movement
    if love.keyboard.isDown("up") and pTwo.y > 0 then
      if pTwo.dy > 0 then pTwo.dy = 0 end -- for quick turning around
      pTwo.dy = pTwo.dy - pTwo.speed * dt
    elseif love.keyboard.isDown("down") and pTwo.y + pTwo.h < windowHeight then
      if pTwo.dy < 0 then pTwo.dy = 0 end
      pTwo.dy = pTwo.dy + pTwo.speed * dt
    else
      if pTwo.dy > 0 then
        pTwo.dy = math.max((pTwo.dy - 50 * dt), 0)
      elseif pTwo.dy < 0 then
        pTwo.dy = math.min((pTwo.dy + 50 * dt), 0)
      end
    end
  end

  -- update player positions
  pOne.x, pOne.y, cols, len = world:move(pOne, pOne.x + pOne.dx, pOne.y + pOne.dy, pOne.filter)

  for i = 1, len do
    if cols[i].other.type == "wall" then
      pOne.dy = 0
    end
  end

  cols, len = 0, 0
  pTwo.x, pTwo.y, cols, len = world:move(pTwo, pTwo.x + pTwo.dx, pTwo.y + pTwo.dy, pTwo.filter)

  for i = 1, len do
    if cols[i].other.type == "wall" then
      pTwo.dy = 0
    end
  end
end

function drawPlayers()
  -- draw player one
  love.graphics.rectangle("line", pOne.x, pOne.y, pOne.w, pOne.h)

  -- draw player two
  love.graphics.rectangle("line", pTwo.x, pTwo.y, pTwo.w, pTwo.h)
end
