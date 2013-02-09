require("buttons")
require("buttonSetup")
require("beatData")
comboRecord = {}
score = 0
health = 50

function onBeatTracker(time)
  --if input == current beat
  return true
end
function onPitchTracker(input)
  --if input == current pitch
  return true
end
function comboTracker()
  -- keep track of button Sequence here
  local result = nil
  if comboRecord[3] == "c" and  
    comboRecord[2] == "b" and  
    comboRecord[1] == "a" then
    print("comobo tracker: cba")
    -- do combo
    result =  true
  elseif comboRecord[3] == "f" and  
    comboRecord[2] == "e" and  
    comboRecord[1] == "d" then
    print("comobo tracker: fed")
    -- do combo
    result = true
  else
    result = false
  end
  return result
end

function comboAppend(time, input)
  --comparet to the music data for beat
  if onBeatTracker(time) then -- if on beat
    local scoreEarned = 10
    if onPitchTracker(input) then scoreEarned = scoreEarned + 10 end
    table.insert(comboRecord, 1, input)
    table.remove(comboRecord, 4)
    -- run tracker to check success of finishing a combo
    local isCombo = comboTracker()
    if isCombo then scoreEarned = scoreEarned + 10 end
    score = score + scoreEarned
    print(scoreEarned .. " " .. score)
      --if success, recreate combo record
  else -- recreate combo record
    comboRecord = nil
    comboRecord = {}
  end
  print(comboRecord[1], comboRecord[2], comboRecord[3], comboRecord[4])
end



function startDance()
  -- the major logic of the game
  -- play music
  local audioChannel=audio.play(music)
  beatAnimator:start()
end

function buildDanceGui(level)
  print("Func: buildDanceGui")
  -- different level different environment
  -- build gui
  -- build characters
  -- readMusicData()
  local path="C:/Users/sam/Documents/GitHub/BeMyApp/"
  beatData=readBeatData(path.."music/dance2.csv")
  beatAnimator=BeatAnimator.create(beatData)
  music=audio.loadSound(path.."music/dance2.mpe")
  buildButtons(beatAnimator)

  startDance()
  return true
end 


function danceDone()
  --destroy / clean up variables
  music:dispose()
  beatData=nil
end