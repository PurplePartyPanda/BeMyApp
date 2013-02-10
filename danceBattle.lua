require("buttons")
require("buttonSetup")
require("beatData")
require("statusbar")
require("pandaPower")
comboRecord = {}
score = 0
scoreEarned = 0
health = 50

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
    local inPitch = input.beatType
    --note! currentBeat function can only be called once per button press
    local currentPitch=beatAnimator:currentBeat()
  if currentPitch~=BEATTYPE_NONE then -- if on beat
    scoreEarned = 2

    if inPitch==currentPitch then
      scoreEarned = scoreEarned + 5
    end

    partyPanda:gottaMove("cross")

    table.insert(comboRecord, 1, input.id)
    table.remove(comboRecord, 4)
    -- run tracker to check success of finishing a combo
    local isCombo = comboTracker()
    if isCombo then scoreEarned = scoreEarned + 10 end

    print("Earned: " .. scoreEarned .. " TOTAL:" .. score)
      --if success, recreate combo record
  else -- recreate combo record
    scoreEarned=-3
    comboRecord = nil
    comboRecord = {}
  end

    updateScore(scoreEarned)

  print(comboRecord[1], comboRecord[2], comboRecord[3], comboRecord[4])
end

function updateScore(scoreEarned)
  score=score+scoreEarned
    if score>100 then score=100 end
    if score<=0 then
      score=0
      onGameDone()
    end
    setStatusValue(score*0.01)
end

function pandaLoses()
  resultImage=display.newImage("images/lose_img.png",0.2*display.contentWidth,0.2*display.contentHeight)
end

function pandaWins()
  resultImage=display.newImage("images/win_img.png",0.4*display.contentWidth,0.4*display.contentHeight)
end

function startDance()
  -- the major logic of the game
  -- play music
  logText:toFront()
  score=50
  partyPanda:startDancing()
  local audioChannel=audio.play(music,{onComplete=onGameDone})
  beatAnimator:start()
  scoreDrainTimer=timer.performWithDelay(400,onDrainScore,0)
end

function onDrainScore()
  updateScore(-1)
  end

function onGameDone()
  timer.cancel(scoreDrainTimer)
  beatAnimator:reset()
  if score<30 then pandaLoses()
  else pandaWins() end
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
  beatAnimator:reset()

  partyPanda=PartyPanda.create(125)
  partyPanda:prepareToParty()

  startDance()
  return true
end 


function danceDone()
  --destroy / clean up variables
  music:dispose()
  beatData=nil
end