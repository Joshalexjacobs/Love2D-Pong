--game.lua

game = {} -- initialize the gamestate "game"

require "walls"
require "ball"
require "player"

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

  -- load Walls
  loadWalls()

  -- load players
  loadPlayers()

  -- load our ball
  loadBall()
end

function game:update(dt)
  -- update things
  updateWalls()
  updatePlayers(dt)
  local p1Score, p2Score = updateBall(dt)

  updateScore(p1Score, p2Score)
end

function game:draw()
  -- our middle line
  love.graphics.line(love.graphics.getWidth() / 2, 0, love.graphics.getWidth() / 2, love.graphics.getHeight())

  -- draw walls
  drawWalls()

  -- draw player paddles
  drawPlayers()

  -- draw ball
  drawBall()
end
