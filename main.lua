-- PURPLE PARTY PANDA
require("danceBattle")
require("buttons")

function onButtonPlayTap(time, self)
    Button.destroy(self)
    buildDanceGui(0)
end

function init()
  -- add listener of the 6 buttons
  -- add listener of tilting phone
  buttonPlay = Button.create("play", 0, 0, "images/button_a.png", "images/button_a_over.png", onButtonPlayTap)
  buttonPlay.button.x = display.contentWidth / 2
  buttonPlay.button.y = display.contentHeight / 2
end

init()