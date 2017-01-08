--menu.lua

menu = {} -- initialize the gamestate "menu"

-- handles key press events
function menu:keypressed(key, code)
  if key == "escape" then
    love.event.quit() -- exit game if player hits the escape key
  elseif key == "space" then
    Gamestate.switch(game) -- swtich to game screen (we'll make a selection and pass it as a parameter to game later)
  end
end

function menu:enter()
  -- load
end

function menu:update(dt)
  -- update?
end

function menu:draw()
  love.graphics.setFont(bigFont)
  love.graphics.setColor({255, 255, 255, 25})
  love.graphics.printf("P O N G", 0, 60, windowWidth, "center")
  love.graphics.setColor({255, 255, 255, 50})
  love.graphics.printf("P O N G", 0, 45, windowWidth, "center")
  love.graphics.setColor({255, 255, 255, 100})
  love.graphics.printf("P O N G", 0, 30, windowWidth, "center")
  love.graphics.setColor({255, 255, 255, 255})
  love.graphics.printf("P Ö N G", 0, 15, windowWidth, "center")

  love.graphics.setColor({255, 255, 255, 255})
  love.graphics.setFont(medFont)

  love.graphics.printf("PLAYER VS AI", 0, 200, windowWidth, "center")
  love.graphics.printf("PLAYER VS PLAYER", 0, 250, windowWidth, "center")
  love.graphics.printf("AI VS AI", 0, 300, windowWidth, "center")
  love.graphics.printf("PRESS SPACE TO START", 0, 410, windowWidth, "center")
end
