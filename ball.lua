--ball.lua

ball = {
  x = 0,
  y = 0,
  dx = 0,
  dy = 0,
  r = 7.5,
  angle = math.pi, -- will be randomly generated at the start of each round
  speed = 500,
}

function loadBall()
  -- place ball in the middle of our playing field
  ball.x, ball.y = love.graphics.getWidth() / 2, love.graphics.getHeight() / 2
end

function updateBall(dt)
  -- update ball's dx and dy variables
  ball.dx = ball.speed * dt
  ball.dy = ball.speed * dt

  -- move our ball depending on it's current angle
  ball.x = ball.x + math.sin(ball.angle) * ball.dx
  ball.y = ball.y - math.cos(ball.angle) * ball.dy
end

function drawBall()
  love.graphics.circle("line", ball.x, ball.y, ball.r)
end
