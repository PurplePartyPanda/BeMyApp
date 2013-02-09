statusBarHealth=50

function makeStatusBar()
	statusBarMain=display.newGroup()
	statusBarMain.x=300
	statusBarMain.y=20
	statusBarSub1=display.newRoundedRect( statusBarMain,0,0,30,100, 8 )
	statusBarSub1:setStrokeColor(0,0,0)
	statusBarSub1:setFillColor(255,0,0)
	statusBarSub2=display.newRoundedRect( statusBarMain,0,0,30,100,8 )
	statusBarSub2:setFillColor(0,180,0)
	setStatusValue(50)
end

function setStatusValue(value)
	statusBarHealth=value
	statusBarSub2.height=value
	statusBarSub2.y=100-value
end