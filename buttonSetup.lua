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
  local buttona = Button.create("a", buttonSize(), buttonPos(0,0), "images/LH.png", "images/LH_over.png", comboAppend)
  local buttonb = Button.create("b", buttonSize(), buttonPos(0,1), "images/LM.png", "images/LM_over.png", comboAppend)
  local buttonc = Button.create("c", buttonSize(), buttonPos(0,2), "images/LL.png", "images/LL_over.png", comboAppend)
  local buttond = Button.create("d", buttonSize(), buttonPos(1,0), "images/RH.png", "images/RH_over.png", comboAppend)
  local buttone = Button.create("e", buttonSize(), buttonPos(1,1), "images/RM.png", "images/RM_over.png", comboAppend)
  local buttonf = Button.create("f", buttonSize(), buttonPos(1,2), "images/RL.png", "images/RL_over.png", comboAppend)

  animator:registerBtn(buttona,BEATTYPE_LOW)
  animator:registerBtn(buttonb,BEATTYPE_LOW)
  animator:registerBtn(buttonc,BEATTYPE_LOW)
  animator:registerBtn(buttond,BEATTYPE_HIGH)
  animator:registerBtn(buttone,BEATTYPE_HIGH)
  animator:registerBtn(buttonf,BEATTYPE_HIGH)

  return true
end