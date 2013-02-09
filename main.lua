-- PURPLE PARTY PANDA
require("danceBattle")
require("buttons")

function onButtonMenuTap(time, self)
  -- check self
  if self.id == "play" then
    --destroy the main menu
    Button.destroy(self)
    --and then show game
    buildDanceGui(0)
  elseif self.id == "options" then
    -- show options overlay
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

function init()
  display.setStatusBar(display.HiddenStatusBar)
  print(display.contentWidth .. "x" .. display.contentHeight)
  local bg = display.newImage ("images/outside.jpg");
  local origwidth = bg.width
  local origheight = bg.height
  if display.contentHeight > 800 then
    bg.height = display.contentHeight
	bg.width = bg.height / origheight * origwidth
  elseif display.contentHeight < 640 then
    bg.height = display.contentHeight / 640 * 800
	bg.width = bg.height / origheight * origwidth
  end
  print(bg.width .. "x" .. bg.height)
  bg.x = display.contentWidth / 2
  bg.y = display.contentHeight / 2
  buttonPlay = Button.create("play", 0, 0, "images/button_a.png", "images/button_a_over.png", onButtonMenuTap)
  buttonPlay.button.x = display.contentWidth / 2
  buttonPlay.button.y = display.contentHeight / 2
end

init()