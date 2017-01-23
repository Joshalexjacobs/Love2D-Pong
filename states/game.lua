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
function game:enter(menu, index)
  local pOneAI, pTwoAI = false, false
  if index == 1 then
    pTwoAI = true
  elseif index == 3 then
    pOneAI, pTwoAI = true, true
  --else -- pOneAI and pTwoAI remain false
    --print("Player VS Player")
  end

  -- set line width
  love.graphics.setLineWidth(0.5)

  -- load Walls
  loadWalls()

  -- load players
  loadPlayers(pOneAI, pTwoAI)

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

  -- draw fps
  love.graphics.print(tostring(love.timer.getFPS( )), 0.2, 0.2, 0, 0.75, 0.75) -- print fps in the top left corner of the screen
end
