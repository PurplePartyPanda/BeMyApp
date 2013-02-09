Button = {button = nil, callBack=nil}
Button.__index = Button

-- creates a button
--   x: horizontal index, 0=left, 1=right
--   y: vertical index, 0=top, 1=middel, 2=bottom
--   image: the button image (without touch effect)
--   hoverimage: the button image with press effect
--   callback: the function to call when the button is pressed
function Button.create(x, y, image, hoverimage, callback)
    local btn = {}            -- our new object
    setmetatable(btn,Button)  -- make Button handle lookup
    --self.__index = self
    
    local widget = require "widget"
    local buttonwidth = (display.contentWidth - display.contentHeight) / 2
    local buttonheight = display.contentHeight / 3
    btn.button = widget.newButton{
        default = image,
        over = hoverimage,
        width = buttonwidth,
        height = buttonheight
    }
    btn.button.x = (display.contentWidth - buttonwidth) * x + buttonwidth / 2
    btn.button.y = buttonheight * y + buttonheight / 2
    btn.callBack = callback
    btn:init()
    return btn
end

function Button:init()
    self.button:addEventListener("touch", self)
end

function Button:touch(event)
    if event.xStart - event.x >= -32 and event.xStart - event.x <= 32 then
        if event.yStart - event.y >= -32 and event.yStart - event.y <= 32 then
            if event.phase == "release" then
			    self.callBack(event.time)
            end
        end
    end
end
