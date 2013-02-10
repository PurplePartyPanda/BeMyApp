-- PURPLE PARTY PANDA
require("onScreenLog")
require("danceBattle")
require("buttons")

bg = nil
buttonsMain = {}

function buttonsDestroyer()
  --destroy the current button set
  for i=1, table.getn(buttonsMain) do
      Button.destroy(buttonsMain[i])
    end
    buttonsMain = nil
    buttonsMain = {}
end
function onButtonLevelsTap(time, self)
  -- check self
  buttonsDestroyer()
  buildDanceGui(self.id)
end
function onButtonBackTap(time, self)
  -- show main menu
  buttonsDestroyer()
  buildMain()
end
function onButtonMenuTap(time, self)
  -- check self
  if self.id == "levels" then
    buttonsDestroyer()
    buildLevels()
  elseif self.id == "options" then
    buttonsDestroyer()
    buildOptions()
    --and show back button
  elseif self.id == "trophies" then
    buttonsDestroyer()
    buildTrophies()
    --and show back button
  elseif self.id == "credits" then
    buttonsDestroyer()
    buildCredits()
    --and show back button
  elseif self.id == "exit" then
    -- close app
  else
    print("it's another button")
  end

end



function setBG()
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
  bg = display.newImage ("images/outside.jpg");
  setBG()
  buttonsMain[1] = Button.create("levels", {400,200}, {display.contentWidth / 3,display.contentHeight / 3}, "images/button_a.png", "images/button_a_over.png", onButtonMenuTap)
  buttonsMain[2] = Button.create("options", {200,200}, {display.contentWidth / 1.5,display.contentHeight / 3}, "images/button_b.png", "images/button_b_over.png", onButtonMenuTap)
  buttonsMain[3] = Button.create("trophies", {200,200}, {display.contentWidth / 3,display.contentHeight / 1.5}, "images/button_c.png", "images/button_c_over.png", onButtonMenuTap)
  buttonsMain[4] = Button.create("credits", {200,200}, {display.contentWidth / 2,display.contentHeight / 1.5}, "images/button_d.png", "images/button_d_over.png", onButtonMenuTap)
  buttonsMain[5] = Button.create("exit", {200,200}, {display.contentWidth / 1.5,display.contentHeight / 1.5}, "images/button_e.png", "images/button_e_over.png", onButtonMenuTap)
end
function buildLevels()
  bg = display.newImage ("images/levels.jpg");
  setBG()
  buttonsMain[1] = Button.create(0, {200,200}, {display.contentWidth / 2,display.contentHeight / 2}, "images/button_a.png", "images/button_a_over.png", onButtonLevelsTap)
  buttonsMain[2] = Button.create("back", {200,200},  {display.contentWidth -100,display.contentHeight -100}, "images/button_b.png", "images/button_b_over.png", onButtonBackTap)
  --and then show game
end
function buildOptions()
  bg = display.newImage ("images/options.jpg");
  setBG()
end
function buildTrophies()
  bg = display.newImage ("images/trophies.jpg");
  setBG()
end
function buildCredits()
  bg = display.newImage ("images/credits.jpg");
  setBG()
end

function init()
  system.activate("multitouch")
  display.setStatusBar(display.HiddenStatusBar)
  initLog()
  print(display.contentWidth .. "x" .. display.contentHeight)
  buildMain()
  --buttonBack = Button.create("back",)
end

init()