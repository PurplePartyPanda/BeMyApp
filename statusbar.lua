statusBarHealth=0.5

function makeStatusBar()
	statusBarMain=display.newGroup()
	statusBarMain.x=display.contentWidth*0.8
	statusBarMain.y=display.contentHeight*0.2
	statusBarSub1=display.newImage( statusBarMain,"images/statusbar.png",0,0 )
	statusBarSub2=display.newImage( statusBarMain,"images/statusbar_over.png",0,0 )
	setStatusValue(0.5)
end

function setStatusValue(value)
	value=value/100.0
	statusBarHealth=math.min(value,1.0)
	statusBarSub2.yScale=value
	statusBarSub2.y=statusBarSub1.height*(0.98-value*0.5)
end