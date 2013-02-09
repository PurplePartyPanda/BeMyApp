-- PURPLE PARTY PANDA
-- NOTE!!!!
-- in LUA, 
-- the variable's default scope seems to be global
-- to delete a golbal variable, assign nil to it
-- in LUA, arrays starts from index 1 instead of 0

 comboRecord = {}

function onTouch(event)
  print(event.x,event.y)
end

function comboTracker(input)
  -- keep track of button Sequence here
  -- print(comboRecord)
  -- set timer
  -- comboRecord.remove()
  -- table.insert(comboReord, 1, input)
  -- print(comboRecord)
end

function comboAppend(input)
  table.insert(comboReord, 1, input)
end

function buildDanceGui(level)
  -- different level different environment
  -- build gui
  -- build characters
  -- build buttons
  return true
end 

function startDance()
  -- the major logic of the game
  -- play music
end

function init()
  Runtime:addEventListener('touch',onTouch)
  -- add listener of the 6 buttons
  -- add listener of tilting phone
  buildDanceGui(0)
  startDance();
end

init()