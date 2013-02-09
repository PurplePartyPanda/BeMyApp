require("buttons")
require("buttonSetup")
comboRecord = {}

function comboAppend(input)
  --comparet to the music data for beat
  if true then -- if on beat
    table.insert(comboRecord, 1, input)
    table.remove(comboRecord, 4)
    -- run tracker to check success of finishing a combo
    local isCombo = comboTracker()
      --if success, recreate combo record
  else -- recreate combo record
    comboRecord = nil
    comboRecord = {}
  end
  print(comboRecord[1], comboRecord[2], comboRecord[3], comboRecord[4])
end



function comboTracker()
  -- keep track of button Sequence here
  local result = nil
  if comboRecord[3] == "c" and  
    comboRecord[2] == "b" and  
    comboRecord[1] == "a" then
    print("comobo tracker: cba")
    result =  true
  elseif comboRecord[3] == "f" and  
    comboRecord[2] == "e" and  
    comboRecord[1] == "d" then
    print("comobo tracker: fed")
    result = true
  else
    result = false
  end
  -- do combo
  return result
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