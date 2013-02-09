-- PURPLE PARTY PANDA


function onTouch(event)
  print(event.x,event.y)
end


function init()
  Runtime:addEventListener('touch',onTouch)
end

init()