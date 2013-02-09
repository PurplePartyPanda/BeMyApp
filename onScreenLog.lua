logText = nil
function initLog()
	logText =  display.newText("This is the Logger", 0, 0, native.systemFont, 16)
	logText:setTextColor(0, 0, 0)
end
logString=""
function log(s)
	logString=logString.."\n"..s
	logText.text=logString
end