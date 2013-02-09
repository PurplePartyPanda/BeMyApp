
-- creates a button
--   x: horizontal index, 0=left, 1=right
--   y: vertical index, 0=top, 1=middel, 2=bottom
--   image: the button image (without touch effect)
--   hoverimage: the button image with press effect
--   callback: the function to call when the button is pressed
function createButton(x, y, image, hoverimage, callback)
    local widget = require "widget"
    local buttonwidth = (display.contentWidth - display.contentHeight) / 2
    local buttonheight = display.contentHeight / 3
    local button = widget.newButton{
        default = image,
        over = hoverimage,
        width = buttonwidth,
        height = buttonheight
    }
    button.x = (display.contentWidth - buttonwidth) * x + buttonwidth / 2
    button.y = buttonheight * y + buttonheight / 2
    button:addEventListener("tap", callback)
	return button
end