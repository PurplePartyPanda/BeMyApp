function buildUppergap()
  local result = display.contentHeight * 60 / 640
  if display.contentHeight > 640 then
      result = 60
  end
  return result
end

uppergap = buildUppergap();

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
function buttonSize()
  size = {(display.contentHeight - uppergap) / 3 * 1.3, (display.contentHeight - uppergap) / 3}
  return size
end
function buttonPos(x,y)
  pos = {(display.contentWidth - (display.contentHeight - uppergap) / 3 * 1.3) * x + (display.contentHeight - uppergap) / 3 * 1.3 / 2, (display.contentHeight - uppergap) / 3 * y + (display.contentHeight - uppergap) / 3 / 2 + uppergap}
  return pos
end
function buildButtons(animator)
  print("Func: buildButtons")
  local buttona = Button.create("a", buttonSize(), buttonPos(0,0), "images/button_a.png", "images/button_a_over.png", onButtonTap)
  local buttonb = Button.create("b", buttonSize(), buttonPos(0,1), "images/button_b.png", "images/button_b_over.png", onButtonTap)
  local buttonc = Button.create("c", buttonSize(), buttonPos(0,2), "images/button_c.png", "images/button_c_over.png", onButtonTap)
  local buttond = Button.create("d", buttonSize(), buttonPos(1,0), "images/button_d.png", "images/button_d_over.png", onButtonTap)
  local buttone = Button.create("e", buttonSize(), buttonPos(1,1), "images/button_e.png", "images/button_e_over.png", onButtonTap)
  local buttonf = Button.create("f", buttonSize(), buttonPos(1,2), "images/button_f.png", "images/button_f_over.png", onButtonTap)

  animator:registerBtn(buttona,"t")
  animator:registerBtn(buttonb,"m")
  animator:registerBtn(buttonc,"b")

  return true
end