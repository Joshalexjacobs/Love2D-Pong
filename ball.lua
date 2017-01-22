--ball.lua

ball = {
  type = "ball",
  x = 0,
  y = 0,
  dx = 0,
  dy = 0,
  w = 5,
  h = 5,
  scored = false,
  angle = math.pi, -- will be randomly generated at the start of each round
  minSpeed = 200,
  speed = 200, -- current speed
  maxSpeed = 600,
  filter = function(item, other)
    if other.type == "player" or other.type == "wall" then
      return 'bounce'
    end
  end,
  timers = {}
}

function loadBall()
  -- place ball in the middle of our playing field
  ball.x, ball.y = windowWidth / 2, windowHeight / 2

  -- generate random angle on load and convert to rads
  ball.angle = (math.pi/180) * love.math.random(1, 360)

  -- add the ball to our world
  world:add(ball, ball.x, ball.y, ball.w, ball.h)
end

local function bounceBall(item, other)
  if item.y > other.y and item.y < other.y + other.h then -- vertical hit
    ball.angle = - ball.angle + (love.math.random(-7, 7) * 0.01)
  elseif item.x > other.x and item.x < other.x + other.w then -- horizontal hit
    ball.angle = - ball.angle + math.pi + (love.math.random(-7, 7) * 0.01)
  end

  if ball.speed <= ball.maxSpeed then
    ball.speed = ball.speed + (ball.speed * 0.05)
  end
end

function updateBall(dt)
  local cols, len = 0, 0
  local p1Score, p2Score = false, false

  -- update ball's dx and dy variables using it's speed and trajectory
  ball.dx = (ball.speed * dt) * math.sin(ball.angle)
  ball.dy = (ball.speed * dt) * math.cos(ball.angle)

  -- reset ball if it leaves the screen on the left or right
  if checkTimer("scored", ball.timers) == false then
    if ball.x > windowWidth then
      ball.angle = (math.pi/180) * love.math.random(1, 360)
      ball.x, ball.y = windowWidth / 2, windowHeight / 2
      ball.speed = ball.minSpeed
      ball.dx, ball.dy = 0, 0
      p1Score = true
      addTimer(0.3, "scored", ball.timers)
    elseif ball.x - ball.w < 0 then
      ball.angle = (math.pi/180) * love.math.random(1, 360)
      ball.x, ball.y = windowWidth / 2, windowHeight / 2
      ball.speed = ball.minSpeed
      ball.dx, ball.dy = 0, 0
      p2Score = true
      addTimer(0.3, "scored", ball.timers)
    end
  end

  if ball.y < 0 or ball.y > love.graphics.getHeight() then
    ball.angle = (math.pi/180) * love.math.random(1, 360)
    ball.x, ball.y = windowWidth / 2, windowHeight / 2
    ball.speed = ball.minSpeed
    ball.dx, ball.dy = 0, 0
  end

  ball.x, ball.y, cols, len = world:move(ball, ball.x + ball.dx, ball.y + ball.dy, ball.filter)

  for i = 1, len do
    if cols[i].other.type == "wall" or cols[i].other.type == "player" then
      bounceBall(cols[i].itemRect, cols[i].otherRect)
    end
  end

  if updateTimer(dt, "scored", ball.timers) then
    deleteTimer("scored", ball.timers)
  end

  return p1Score, p2Score
end

function drawBall()
  love.graphics.rectangle("fill", ball.x, ball.y, ball.w, ball.h)
end
