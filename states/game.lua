--game.lua

game = {}

require "ball"

pOne = {
  x = 25,
  y = 50,
  w = 25,
  h = 75,
  dx = 0, -- probs wont be needed
  dy = 0,
  speed = 5,
  draw = function()
    love.graphics.rectangle("line", pOne.x, pOne.y, pOne.w, pOne.h)
  end,
}

pTwo = {

}

-- handles key press events
function game:keypressed(key, code)
  if key == "escape" then
    love.event.quit() -- exit game if player hits the escape key
  end
end

-- upon entering game.lua (similar to love.load())
function game:enter()
  -- set line width
  love.graphics.setLineWidth(0.5)

  loadBall()
end

function game:update(dt)
  -- update things
  updateBall(dt)
end

function game:draw()
  --love.graphics.printf("Welcome to Pong", 0, 0, love.graphics.getWidth(), "center")

  -- our middle line
  love.graphics.line(love.graphics.getWidth() / 2, 0, love.graphics.getWidth() / 2, love.graphics.getHeight())

  -- draw player paddles
  pOne.draw()
  --pTwo.draw()

  -- draw ball
  drawBall()
end
