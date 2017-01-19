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
  up = "w",
  down = "s",
  filter = function(item, other)
    if other.type == "wall" then
      return 'slide'
    end
  end
}

local pTwo = {
  type = "player",
  ai = true,
  x = 576 - 50,
  y = 200,
  w = 25,
  h = 75,
  dx = 0, -- probs wont be needed
  dy = 0,
  speed = 30,
  up = "up",
  down = "down",
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

local function paddleAI(player, dt) -- for now lets assume its the paddle on the right
  if ball.dx > 0 then -- if ball is moving towards paddle
    -- follow the ball, until it turns around or passes the player
    if ball.y < player.y + (player.h / 2) + 10 then -- up
      if player.dy > 0 then player.dy = 0 end
      player.dy = player.dy - player.speed * dt
    elseif ball.y > player.y - (player.h / 2) then -- down
      if player.dy < 0 then player.dy = 0 end
      player.dy = player.dy + player.speed * dt
    else
      if player.dy > 0 then
        player.dy = math.max((player.dy - 100 * dt), 0)
      elseif player.dy < 0 then
        player.dy = math.min((player.dy + 100 * dt), 0)
      end
    end
  end

end

local function updatePlayer(player, dt)
  -- handle player movement
  if love.keyboard.isDown(player.up) and player.y > 0 then
    if player.dy > 0 then player.dy = 0 end -- for quick turning around
    player.dy = player.dy - player.speed * dt
  elseif love.keyboard.isDown(player.down) and player.y + player.h < windowHeight then
    if player.dy < 0 then player.dy = 0 end
    player.dy = player.dy + player.speed * dt
  else -- paddle deceleration
    if player.dy > 0 then
      player.dy = math.max((player.dy - 100 * dt), 0)
    elseif player.dy < 0 then
      player.dy = math.min((player.dy + 100 * dt), 0)
    end
  end
end

function updatePlayers(dt)
  local cols, len = 0, 0

  if pOne.ai == false then
    updatePlayer(pOne, dt)
  end

  if pTwo.ai == false then
    updatePlayer(pTwo, dt)
  else
    paddleAI(pTwo, dt)
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
