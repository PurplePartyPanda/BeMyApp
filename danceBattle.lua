require("buttons")
require("buttonSetup")
comboRecord = {}
bpm =  100
function comboAppend(input)
  table.insert(comboRecord, 1, input)
  print(comboRecord[1])
end

function comboTracker(input)
  -- keep track of button Sequence here
  -- print(comboRecord)
  -- set timer
  -- comboRecord.remove()
  -- table.insert(comboReord, 1, input)
  -- print(comboRecord)
end

function startDance()
  -- the major logic of the game
  -- play music
end

function buildDanceGui(level)
  print("Func: buildDanceGui")
  -- different level different environment
  -- build gui
  -- build characters
  -- readMusicData()
  buildButtons()
  return true
end 