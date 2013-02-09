-- PURPLE PARTY PANDA
<<<<<<< HEAD

require("buttons")
require("guisetup")

function init()
  buildDanceGui(0)
  -- print(display.contentWidth)
  -- print(display.contentHeight)
=======
-- NOTE!!!!
-- in LUA, 
-- the variable's default scope seems to be global
-- to delete a golbal variable, assign nil to it
-- in LUA, arrays starts from index 1 instead of 0
require("danceBattle")

function init()
  -- add listener of the 6 buttons
  -- add listener of tilting phone
  buildDanceGui(0)
>>>>>>> modulaizing danceBattle GUI
end

init()