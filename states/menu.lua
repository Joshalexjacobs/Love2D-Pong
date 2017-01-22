--menu.lua

menu = {} -- initialize the gamestate "menu"

local selector = {
  x = 0,
  y = 0, -- 150 or 200
  w = 0,
  h = 35,
  color = {255, 100, 100, 100},
  index = 1,
}

-- handles key press events
function menu:keypressed(key, code)
  if key == "escape" then
    love.event.quit() -- exit game if player hits the escape key
  elseif key == "space" then
    Gamestate.switch(game, selector.index) -- swtich to game screen (we'll make a selection and pass it as a parameter to game later)
  elseif key == "down" then
    if selector.index ~= 3 then
      selector.index = selector.index + 1
    else
      selector.index = 1
    end
  elseif key == "up" then
    if selector.index ~= 1 then
      selector.index = selector.index - 1
    else
      selector.index = 3
    end
  end
end

function menu:enter()
  selector.w = love.graphics.getWidth()
end

function menu:update(dt)
  selector.y = 150 + (selector.index * 50)
end

function menu:draw()
  -- draw title text
  love.graphics.setFont(bigFont)
  love.graphics.setColor({255, 255, 255, 25})
  love.graphics.printf("P O N G", 0, 60, windowWidth, "center")
  love.graphics.setColor({255, 255, 255, 50})
  love.graphics.printf("P O N G", 0, 45, windowWidth, "center")
  love.graphics.setColor({255, 255, 255, 100})
  love.graphics.printf("P O N G", 0, 30, windowWidth, "center")
  love.graphics.setColor({255, 255, 255, 255})
  love.graphics.printf("P Ö N G", 0, 15, windowWidth, "center")

  -- draw selector box
  love.graphics.setColor(selector.color)
  love.graphics.rectangle("fill", selector.x, selector.y, selector.w, selector.h)

  -- reset color and font size
  love.graphics.setColor({255, 255, 255, 255})
  love.graphics.setFont(medFont)

  -- draw game options
  love.graphics.printf("PLAYER VS AI", 0, 200, windowWidth, "center")
  love.graphics.printf("PLAYER VS PLAYER", 0, 250, windowWidth, "center")
  love.graphics.printf("AI VS AI", 0, 300, windowWidth, "center")
  love.graphics.printf("PRESS SPACE TO START", 0, 410, windowWidth, "center")
end
