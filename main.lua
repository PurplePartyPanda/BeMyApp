-- PURPLE PARTY PANDA

require("buttons")

local textObject = display.newText(display.contentWidth .. "x" .. display.contentHeight, 160, 50, nil, 24 )
textObject:setTextColor( 255,255,255 )

function onButtonATap(event)
    print("button a")
end

function onButtonBTap(event)
    print("button b")
end

function onButtonCTap(event)
    print("button c")
end

function onButtonDTap(event)
    print("button d")
end

function onButtonETap(event)
    print("button e")
end

function onButtonFTap(event)
    print("button f")
end

function init()
  local buttona = createButton(0, 0, "images/button_a.png", "images/button_a_over.png", onButtonATap)
  local buttonb = createButton(0, 1, "images/button_b.png", "images/button_b_over.png", onButtonBTap)
  local buttonc = createButton(0, 2, "images/button_c.png", "images/button_c_over.png", onButtonCTap)
  local buttond = createButton(1, 0, "images/button_d.png", "images/button_d_over.png", onButtonDTap)
  local buttone = createButton(1, 1, "images/button_e.png", "images/button_e_over.png", onButtonETap)
  local buttonf = createButton(1, 2, "images/button_f.png", "images/button_f_over.png", onButtonFTap)
  -- print(display.contentWidth)
  -- print(display.contentHeight)
end

init()