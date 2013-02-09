

local textObject = display.newText(display.contentWidth .. "x" .. display.contentHeight, 160, 50, nil, 24 )
textObject:setTextColor( 255,255,255 )

function onButtonTap(time, self)
  -- check self
  if self.id == "a" then
    comboAppend(time, "a")
  elseif self.id == "b" then
    comboAppend(time, "b")
  elseif self.id == "c" then
    comboAppend(time, "c")
  elseif self.id == "d" then
    comboAppend(time, "d")
  elseif self.id == "e" then
    comboAppend(time, "e")
  elseif self.id == "f" then
    comboAppend(time, "f")
  else
    print("it's another button")
  end
end

function buildButtons()
  print("Func: buildButtons")
  local buttona = Button.create("a", 0, 0, "images/button_a.png", "images/button_a_over.png", onButtonTap)
  local buttonb = Button.create("b", 0, 1, "images/button_b.png", "images/button_b_over.png", onButtonTap)
  local buttonc = Button.create("c", 0, 2, "images/button_c.png", "images/button_c_over.png", onButtonTap)
  local buttond = Button.create("d", 1, 0, "images/button_d.png", "images/button_d_over.png", onButtonTap)
  local buttone = Button.create("e", 1, 1, "images/button_e.png", "images/button_e_over.png", onButtonTap)
  local buttonf = Button.create("f", 1, 2, "images/button_f.png", "images/button_f_over.png", onButtonTap)
  return true
end