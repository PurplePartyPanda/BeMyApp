require("buttons")
require("buttonSetup")
require("beatData")
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
    local inPitch = nil
    if input.id == "a" or input.id == "d" then
      inPitch = BEATTYPE_HIGH
    elseif input.id == "b" or input.id == "e" then
      inPitch = BEATTYPE_MID
    elseif input.id == "c" or input.id == "f" then
      inPitch = BEATTYPE_LOW
    else 
      error("input button error")
    end
    if onPitchTracker(inPitch) then scoreEarned = scoreEarned + 5 end
    table.insert(comboRecord, 1, input.id)
    table.remove(comboRecord, 4)
    -- run tracker to check success of finishing a combo
    local isCombo = comboTracker()
    if isCombo then scoreEarned = scoreEarned + 10 end
    score = score + scoreEarned
    print("Earned: " .. scoreEarned .. " TOTAL:" .. score)
    scoreEarned = 0
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
  
  beatPath=system.pathForFile( "music/dance2.csv", system.ResourceDirectory )
  beatData=readBeatData(beatPath)
  beatAnimator=BeatAnimator.create(beatData)
  music=audio.loadSound("music/dance2.mp3")
  buildButtons(beatAnimator)
  startDance()
  return true
end 


function danceDone()
  --destroy / clean up variables
  music:dispose()
  beatData=nil
end