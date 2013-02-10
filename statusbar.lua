
function makeStatusBar()
	statusBarMain=display.newGroup()
	statusBarMain.x=display.contentWidth*0.8
	statusBarMain.y=display.contentHeight*0.02
	statusBarSub1=display.newImage( statusBarMain,"images/statusbar.png",0,0 )
	statusBarSub2=display.newImage( statusBarMain,"images/statusbar_over.png",0,0 )
	setStatusValue(0.5)
end

function setStatusValue(value)
	value=math.min(value,1.0)
	statusBarSub2.yScale=value*0.98+0.001
	statusBarSub2.y=statusBarSub1.height*(0.98-value*0.5)
end