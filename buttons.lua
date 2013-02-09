Button = {id = "", button = nil, callBack=nil}
Button.__index = Button

-- creates a button
--   x: horizontal index, 0=left, 1=right
--   y: vertical index, 0=top, 1=middel, 2=bottom
--   image: the button image (without touch effect)
--   hoverimage: the button image with press effect
--   callback: the function to call when the button is pressed


function Button.create(name, size, pos, image, hoverimage, callback)
    local btn = {}            -- our new object
    setmetatable(btn,Button)  -- make Button handle lookup
    --self.__index = self
    btn.id = name
    local widget = require "widget"
	print("uppergap: " .. uppergap)

    btn.button = widget.newButton{
        default = image,
        over = hoverimage,
        width = size[1],
        height = size[2]
    }
    btn.button.x = pos[1]
    btn.button.y = pos[2]
    btn.callBack = callback
    btn:init()
    return btn
end
function Button.destroy(btn)
    -- remove widget first (widgets must be removed manually to avoid memleak)
    display.remove(btn.button)
    btn.button = nil
    btn = nil
    return true
end
function Button:init()
    self.button:addEventListener("touch", self)
end

function Button:touch(event)
    --if event.xStart - event.x >= -32 and event.xStart - event.x <= 32 then
    --    if event.yStart - event.y >= -32 and event.yStart - event.y <= 32 then
            if event.phase == "press" then
			    self.callBack(event.time, self)
            end
    --    end
    --end
end


