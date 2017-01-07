-- main.lua

Gamestate = require "lib/Gamestate"

require "states/game"

-- global copy function (we may or may not need this, although i use this function a lot in love)
function copy(obj, seen)
  if type(obj) ~= 'table' then return obj end
  if seen and seen[obj] then return seen[obj] end
  local s = seen or {}
  local res = setmetatable({}, getmetatable(obj))
  s[obj] = res
  for k, v in pairs(obj) do res[copy(k, s)] = copy(v, s) end
  return res
end

function love.load(arg)
  math.randomseed(os.time()) -- seed love.math.rand() using os time
  love.graphics.setDefaultFilter("nearest", "nearest") -- set nearest pixel distance

  -- 192x160 (closest atari2600 resolution i could find)
  love.window.setMode(576, 480, {resizable=false, vsync=true, msaa=0}) -- set the window mode



  Gamestate.registerEvents() -- prep Gamestate
  Gamestate.switch(game) -- swtich to game screen
end
