function buildUppergap()
  local result = display.contentHeight * 60 / 640
  if display.contentHeight > 640 then
      result = 60
  end
  return result
end

uppergap = buildUppergap();

function buttonSize()
  size = nil
  if display.contentHeight > 800 or display.contentHeight < 640 then
    size = {(display.contentHeight - uppergap) / 3 * 1.3, (display.contentHeight - uppergap) / 3}
  else
    size = {250,192}
    print("forcesize")
  end
  return size
end
function buttonPos(x,y)
  pos = {(display.contentWidth - (display.contentHeight - uppergap) / 3 * 1.3) * x + (display.contentHeight - uppergap) / 3 * 1.3 / 2, (display.contentHeight - uppergap) / 3 * y + (display.contentHeight - uppergap) / 3 / 2 + uppergap}
  return pos
end
function buildButtons(animator)
  print("Func: buildButtons")
  local buttona = Button.create("a", buttonSize(), buttonPos(0,0), "images/LH.png", "images/LH_over.png", comboAppend,BEATTYPE_LOW)
  local buttonb = Button.create("b", buttonSize(), buttonPos(0,1), "images/LM.png", "images/LM_over.png", comboAppend,BEATTYPE_LOW)
  local buttonc = Button.create("c", buttonSize(), buttonPos(0,2), "images/LL.png", "images/LL_over.png", comboAppend,BEATTYPE_LOW)
  local buttond = Button.create("d", buttonSize(), buttonPos(1,0), "images/RH.png", "images/RH_over.png", comboAppend,BEATTYPE_HIGH)
  local buttone = Button.create("e", buttonSize(), buttonPos(1,1), "images/RM.png", "images/RM_over.png", comboAppend,BEATTYPE_HIGH)
  local buttonf = Button.create("f", buttonSize(), buttonPos(1,2), "images/RL.png", "images/RL_over.png", comboAppend,BEATTYPE_HIGH)

  animator:registerBtn(buttona)
  animator:registerBtn(buttonb)
  animator:registerBtn(buttonc)
  animator:registerBtn(buttond)
  animator:registerBtn(buttone)
  animator:registerBtn(buttonf)

  return true
end