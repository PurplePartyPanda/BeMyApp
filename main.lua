-- PURPLE PARTY PANDA
require("onScreenLog")
require("danceBattle")
require("buttons")

bg = nil
buttonsMain = {}
imgSet = {}
progress = 0
function buttonsDestroyer()
  --destroy the current button set
  for i=1, table.getn(buttonsMain) do
      Button.destroy(buttonsMain[i])
    end
    buttonsMain = nil
    buttonsMain = {}
end
function buildBackButton()
  table.insert(buttonsMain, Button.create("back", {150,100},  {75,display.contentHeight -50}, "images/back.png", "images/back.png", onButtonBackTap))
end
function buildNextButton(callback)
  table.insert(buttonsMain, Button.create("next", {150,100},  {display.contentWidth-75,display.contentHeight -50}, "images/next.png", "images/next.png", callback))
end

function onButtonLevelsTap(time, self) --self must deliver level numer
  buttonsDestroyer()
  setBG("images/disco_bg.png")
  buildDanceGui(self.id)
end
function onButtonBackTap(time, self) -- show main menu
  buttonsDestroyer()
  buildMain()
end
function showComic(num)
  buttonsDestroyer()
  if num==0 then
    setBG("images/comic_0.png")
    imgSet[1] =  display.newImage ("images/bouncer_BRAD.png");
    imgSet[1].x = display.contentWidth -200
    imgSet[1].y = display.contentHeight
    imgSet[2] =  display.newImage ("images/cross_03.png");
    imgSet[2].x = display.contentWidth / 4
    imgSet[2].y = display.contentHeight / 1.2
    progress = progress + 1
    
    buildNextButton(buildLevels)
    buildBackButton()
  else
    buildLevels()
  end
end

function onButtonMenuTap(time, self)
  -- check self
  if self.id == "play" then
    if progress == 0 then
      showComic(0)
    else
      buildLevels()
    end
  elseif self.id == "options" then
    buttonsDestroyer()
    buildOptions()
  elseif self.id == "trophies" then
    buttonsDestroyer()
    buildTrophies()
  elseif self.id == "credits" then
    buttonsDestroyer()
    buildCredits()
  elseif self.id == "exit" then
    -- close app
  else
    print("it's another button")
  end
end


function setBG(newImg) --take string of new bg img and auto resize
  bg = display.newImage (newImg);
  local origwidth = bg.width
  local origheight = bg.height
  if display.contentHeight > 800 then
    bg.height = display.contentHeight
  bg.width = bg.height / origheight * origwidth
  elseif display.contentHeight < 640 then
    bg.height = display.contentHeight / 640 * 800
    bg.width = bg.height / origheight * origwidth
  end
  bg.x = display.contentWidth / 2
  bg.y = display.contentHeight / 2
end

function buildMain()
  setBG("images/outside.png")
  local title =  display.newImage ("images/title.png");
  title.x = display.contentWidth /2
  title.y = display.contentHeight / 4
  buttonsMain[1] = Button.create("play", {440,150}, {display.contentWidth / 2 - 100 ,display.contentHeight / 1.8}, "images/menu_01.png", "images/menu_01_over.png", onButtonMenuTap)
  buttonsMain[2] = Button.create("options", {150,150}, {display.contentWidth / 2 + 230,display.contentHeight / 1.8}, "images/menu_02.png", "images/menu_02_over.png", onButtonMenuTap)
  buttonsMain[3] = Button.create("trophies", {262,150}, {display.contentWidth / 2 -190,display.contentHeight /1.2}, "images/menu_03.png", "images/menu_03_over.png", onButtonMenuTap)
  buttonsMain[4] = Button.create("credits", {150,150}, {display.contentWidth / 2 + 45 ,display.contentHeight /1.2}, "images/menu_04.png", "images/menu_04_over.png", onButtonMenuTap)
  buttonsMain[5] = Button.create("exit", {150,150}, {display.contentWidth / 2 + 230,display.contentHeight /1.2}, "images/menu_05.png", "images/menu_05_over.png", onButtonMenuTap)
end
function buildLevels()
  setBG("images/levels.jpg")
  buttonsMain[1] = Button.create(0, {200,200}, {display.contentWidth / 2 - 210 ,display.contentHeight / 2 - 80}, "images/button_a.png", "images/button_a_over.png", onButtonLevelsTap)
  buttonsMain[2] = Button.create(1, {200,200}, {display.contentWidth / 2,display.contentHeight / 2 - 80}, "images/button_b.png", "images/button_b_over.png", onButtonLevelsTap)
  buttonsMain[3] = Button.create(2, {200,200}, {display.contentWidth / 2 + 210 ,display.contentHeight / 2 - 80}, "images/button_c.png", "images/button_c_over.png", onButtonLevelsTap)
  buttonsMain[4] = Button.create(3, {200,200}, {display.contentWidth / 2 - 210,display.contentHeight / 2 + 130}, "images/button_d.png", "images/button_d_over.png", onButtonLevelsTap)
  buttonsMain[5] = Button.create(4, {200,200}, {display.contentWidth / 2,display.contentHeight / 2 + 130}, "images/button_e.png", "images/button_e_over.png", onButtonLevelsTap)
  buttonsMain[6] = Button.create(5, {200,200}, {display.contentWidth / 2 + 210,display.contentHeight / 2 + 130}, "images/button_f.png", "images/button_c_over.png", onButtonLevelsTap)
  buildBackButton()
  --and then show game
end
function buildOptions()
  setBG("images/options.jpg")
  buildBackButton()
end
function buildTrophies()
  setBG"images/trophies.jpg"
  buildBackButton()
end
function buildCredits()
  setBG("images/credits.jpg")
  buildBackButton()
end

function init()
  system.activate("multitouch")
  display.setStatusBar(display.HiddenStatusBar)
  --initLog()
  print(display.contentWidth .. "x" .. display.contentHeight)
  buildMain()
end

init() --start the purple party power!!!