require("buttons")
require("buttonSetup")
require("beatData")
require("statusbar")
require("pandaPower")
comboRecord = {}
score = 0
scoreEarned = 0
health = 50
function onBeatTracker()
  local result = nil
  print(beatAnimator:currentBeat())
  if beatAnimator:currentBeat() ~= BEATTYPE_NONE then
    result = true
  else
    result = false
  end
  --if input == current beat
  return result
end
function onPitchTracker(input)
  local result = nil
  if input == beatAnimator:currentBeat() then
    result = true
  else
    result = false
  end
  return result
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
  if onBeatTracker() then -- if on beat
    scoreEarned = 3
    local inPitch = input.beatType
    if onPitchTracker(inPitch) then scoreEarned = scoreEarned + 5 end
    table.insert(comboRecord, 1, input.id)
    table.remove(comboRecord, 4)
    -- run tracker to check success of finishing a combo
    local isCombo = comboTracker()
    if isCombo then scoreEarned = scoreEarned + 10 end

    print("Earned: " .. scoreEarned .. " TOTAL:" .. score)
      --if success, recreate combo record
  else -- recreate combo record
    scoreEarned=-2
    comboRecord = nil
    comboRecord = {}
  end

    score = score + scoreEarned
    if score>100 then score=100 end
    if score<=0 then
      score=0
      pandaLoses()
    end
    setStatusValue(score*0.01)

  print(comboRecord[1], comboRecord[2], comboRecord[3], comboRecord[4])
end

function pandaLoses()
end

function startDance()
  -- the major logic of the game
  -- play music
  logText:toFront()
  score=50
  summonPanda(125)
  local audioChannel=audio.play(music)
  beatAnimator:start()
end

function buildDanceGui(level)
  print("Func: buildDanceGui")
  -- different level different environment
  -- build gui
  -- build characters
  -- readMusicData()
  
  beatPath=system.pathForFile( "music/dance2.csv", system.ResourceDirectory )
  beatData=readBeatData(beatPath)
  beatAnimator=BeatAnimator.create(beatData)
  music=audio.loadSound("music/dance2.mp3")
  buildButtons(beatAnimator)
  makeStatusBar()
  startDance()
  return true
end 


function danceDone()
  --destroy / clean up variables
  music:dispose()
  beatData=nil
end