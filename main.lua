-- PURPLE PARTY PANDA
require("onScreenLog")
require("danceBattle")
require("buttons")

bg = nil

function onButtonMenuTap(time, self)
  -- check self
  if self.id == "play" then
    --destroy the main menu
    Button.destroy(self)
    --and then show game
    buildDanceGui(0)
  elseif self.id == "options" then
    -- show options overlay
    bg = display.newImage ("images/options.jpg");
  elseif self.id == "levels" then
    -- show level overlay
  elseif self.id == "credits" then
    -- show credit overlay
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
  local buttonPlay = Button.create("play", {400,200}, {display.contentWidth / 3,display.contentHeight / 3}, "images/button_a.png", "images/button_a_over.png", onButtonMenuTap)
  local buttonLevels = Button.create("levels", {200,200}, {display.contentWidth / 1.5,display.contentHeight / 3}, "images/button_b.png", "images/button_b_over.png", onButtonMenuTap)
  local buttonOptions = Button.create("options", {200,200}, {display.contentWidth / 3,display.contentHeight / 1.5}, "images/button_c.png", "images/button_c_over.png", onButtonMenuTap)
  local buttonCredits = Button.create("creits", {200,200}, {display.contentWidth / 2,display.contentHeight / 1.5}, "images/button_d.png", "images/button_d_over.png", onButtonMenuTap)
  local buttonExit = Button.create("exit", {200,200}, {display.contentWidth / 1.5,display.contentHeight / 1.5}, "images/button_e.png", "images/button_e_over.png", onButtonMenuTap)
end
function buildOption()
end
function buildCredit()
end
function init()
  display.setStatusBar(display.HiddenStatusBar)
  initLog()
  print(display.contentWidth .. "x" .. display.contentHeight)
  buildMain()
  --buttonBack = Button.create("back",)
end

init()