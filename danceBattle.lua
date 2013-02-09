require("buttons")

comboRecord = {}
local textObject = display.newText(display.contentWidth .. "x" .. display.contentHeight, 160, 50, nil, 24 )
textObject:setTextColor( 255,255,255 )

function comboAppend(input)
  table.insert(comboRecord, 1, input)
end

function comboTracker(input)
  -- keep track of button Sequence here
  -- print(comboRecord)
  -- set timer
  -- comboRecord.remove()
  -- table.insert(comboReord, 1, input)
  -- print(comboRecord)
end



function onButtonATap(time)
    textObject.text = "button a"
end

function onButtonBTap(time)
    textObject.text = "button b"
end

function onButtonCTap(time)
    textObject.text = "button c"
end

function onButtonDTap(time)
    textObject.text = "button d"
end

function onButtonETap(time)
    textObject.text = "button e"
end

function onButtonFTap(time)
    textObject.text = "button f"
end

function buildButtons()
	print("Func: buildButtons")
	local buttona = Button.create(0, 0, "images/button_a.png", "images/button_a_over.png", onButtonATap)
  local buttonb = Button.create(0, 1, "images/button_b.png", "images/button_b_over.png", onButtonBTap)
  local buttonc = Button.create(0, 2, "images/button_c.png", "images/button_c_over.png", onButtonCTap)
  local buttond = Button.create(1, 0, "images/button_d.png", "images/button_d_over.png", onButtonDTap)
  local buttone = Button.create(1, 1, "images/button_e.png", "images/button_e_over.png", onButtonETap)
  local buttonf = Button.create(1, 2, "images/button_f.png", "images/button_f_over.png", onButtonFTap)
  -- print(display.contentWidth)
  -- print(display.contentHeight)
end

function startDance()
  -- the major logic of the game
  -- play music
end

function buildDanceGui(level)
  print("Func: buildDanceGui")
  -- different level different environment
  -- build gui
  -- build characters
  buildButtons()
  return true
end 