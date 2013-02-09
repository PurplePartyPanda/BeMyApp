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
  -- add listener of the 6 buttons
  -- add listener of tilting phone
  buttonPlay = Button.create("play", 0, 0, "images/button_a.png", "images/button_a_over.png", onButtonMenuTap)
  buttonPlay.button.x = display.contentWidth / 2
  buttonPlay.button.y = display.contentHeight / 2
end

init()