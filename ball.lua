--ball.lua

ball = {
  type = "ball",
  x = 0,
  y = 0,
  dx = 0,
  dy = 0,
  w = 5.5, -- 5
  h = 5.5, -- 5
  scored = false,
  angle = math.pi, -- will be randomly generated at the start of each round
  minSpeed = 200, -- 200
  speed = 200, -- current speed -- 200
  maxSpeed = 645,
  filter = function(item, other)
    if other.type == "player" or other.type == "wall" then
      return 'bounce'
    end
  end,
  timers = {},
  p1Score = false,
  p2Score = false,
}

local function setAngle()
  ball.angle = (math.pi/180) * love.math.random(1, 360)
end

function loadBall()
  -- place ball in the middle of our playing field
  ball.x, ball.y = windowWidth / 2, windowHeight / 2
  setAngle() -- set ball's starting angle

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
    ball.speed = ball.speed + (ball.speed * 0.075)
  end
end

function updateBall(dt)
  local cols, len = 0, 0
  ball.p1Score, ball.p2Score = false, false

  -- update ball's dx and dy variables using it's speed and trajectory
  if checkTimer("scored", ball.timers) == false then
    ball.dx = (ball.speed * dt) * math.sin(ball.angle)
    ball.dy = (ball.speed * dt) * math.cos(ball.angle)
  end

  if ball.y < 0 or ball.y > love.graphics.getHeight() then
    ball.angle = (math.pi/180) * love.math.random(1, 360)
    ball.x, ball.y = windowWidth / 2, windowHeight / 2
    ball.speed = ball.minSpeed
    ball.dx, ball.dy = 0, 0
  end

  -- reset ball if it leaves the screen on the left or right
  if checkTimer("scored", ball.timers) == false then
    if ball.x > windowWidth then
      setAngle()
      ball.x, ball.y = windowWidth / 2, windowHeight / 2
      ball.speed = 0
      ball.dx, ball.dy = 0, 0
      ball.p1Score = true
      addTimer(0.3, "scored", ball.timers)
      world:remove(ball) -- fixes a bug so the goal doesn't count twice
    elseif ball.x - ball.w < 0 then
      setAngle()
      ball.x, ball.y = windowWidth / 2, windowHeight / 2
      ball.speed = 0
      ball.dx, ball.dy = 0, 0
      ball.p2Score = true
      addTimer(0.3, "scored", ball.timers)
      world:remove(ball)
    end
  end

  if checkTimer("scored", ball.timers) == false then
    ball.x, ball.y, cols, len = world:move(ball, ball.x + ball.dx, ball.y + ball.dy, ball.filter)

    for i = 1, len do
      if cols[i].other.type == "wall" or cols[i].other.type == "player" then
        bounceBall(cols[i].itemRect, cols[i].otherRect)
      end
    end
  end

  if updateTimer(dt, "scored", ball.timers) == true then
    deleteTimer("scored", ball.timers)
    ball.speed = ball.minSpeed
    world:add(ball, ball.x, ball.y, ball.w, ball.h) -- readd the ball to world
  end

  return ball.p1Score, ball.p2Score
end

function drawBall()
  love.graphics.rectangle("fill", ball.x, ball.y, ball.w, ball.h)
end
