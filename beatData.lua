
function readBeatData(filename)
	--local dataStr=readFromFile("dance2.csv","C:/Users/sam/Documents/GitHub/BeMyApp/musicanalyzer/")
	local dataStr=readLocalFile(filename)
	local dataArr={}
	local arr1=split(dataStr,"\n")
	local arr2
	local dataObj
	for idx,item1 in ipairs(arr1) do
		arr2=split(item1,",")
		dataObj={}
		dataObj.time=tonumber(arr2[1])
		dataObj.type=arr2[3]
		table.insert(dataArr,dataObj);
	end
	return dataArr
end

function readLocalFile(filename)
    local f = assert(io.open(filename, "r"))
    local data = f:read("*all")
    f:close()
    return data
end

function readFromFile( filename)
	local path = system.pathForFile( filename, system.ResourceDirectory )
	local file = io.open( path, "r" )
	local data = file:read( "*a" )
	io.close( file )
	return data
end

function split(s,char)
	local subarr={}
	local startIdx=0
	local spos,epos=s:find(char)
	while spos~=nil do
		table.insert(subarr,s:sub(startIdx,spos-1))
		startIdx=epos+1
		spos,epos=s:find(char,epos+1)
	end
	table.insert(subarr,s:sub(startIdx,s:len()))
	return subarr
end



BEATTYPE_LOW="b"
BEATTYPE_MID="m"
BEATTYPE_HIGH="t"
BEATTYPE_NONE="none"

BeatAnimator = {}
BeatAnimator.__index = BeatAnimator

function BeatAnimator.create(beatData)
   local obj = {}             -- our new object
   setmetatable(obj,BeatAnimator)  -- make BeatAnimator handle lookup
   obj.beatData=beatData
   obj.beatIdx=1
   obj.buttons={}
   return obj
end

function BeatAnimator:registerBtn(btn)
   table.insert(self.buttons,{btn=btn,type=btn.beatType})
   btn.button.alpha=0.5
end

function BeatAnimator:start()
	print("----------------------- start ------------------------")
	self.startTime=system.getTimer()
	self.beatIdx=1
	self.eventIdx=1

	self.eventList={}
	for idx,beat in ipairs(self.beatData) do
		table.insert(self.eventList,{time=beat.time-200,animType="fadein",beatType=beat.type,finalTime=beat.time})
		table.insert(self.eventList,{time=beat.time,animType="fadeout",beatType=beat.type,finalTime=beat.time+400})
		table.insert(self.eventList,{time=beat.time-1000,animType="makeball",beatType=beat.type,finalTime=beat.time})
	end
	table.sort(self.eventList,function(a,b) return a.time<b.time end)

	local updateClosure=function() self:update() end
	Runtime:addEventListener( "enterFrame", updateClosure )
	self:update()
end

function BeatAnimator:update()
	local curTime=system.getTimer()-self.startTime

	while self.beatIdx<=#self.beatData and curTime>self.beatData[self.beatIdx].time do
		self.beatIdx=self.beatIdx+1
	end

	local curbtn
	while self.eventIdx<=#self.eventList and curTime>self.eventList[self.eventIdx].time do
		event=self.eventList[self.eventIdx]
		if event.animType=="makeball" then
			local targetDir
			if event.beatType==BEATTYPE_LOW then targetDir=-1
			else targetDir=1 end
			--local ball=display.newCircle(450+targetX*400,500,6)
			local ball=display.newImage("images/ball.png",display.contentWidth*(0.5+targetDir*0.4),display.contentHeight)
			transition.to(ball,{x=display.contentWidth*(0.5+targetDir*0.1),y=display.contentHeight*0.25,time=event.finalTime-curTime,onComplete=function(target) self:removeBall(target) end})
		elseif event.animType=="fadein" then
			for i,btn in ipairs(self.buttons) do
				if btn.type==event.beatType then
					transition.to(btn.btn.button,{alpha=1.0,time=event.finalTime-curTime})
				end
			end
		elseif event.animType=="fadeout" then
			for i,btn in ipairs(self.buttons) do
				if btn.type==event.beatType then
					transition.to(btn.btn.button,{alpha=0.5,time=event.finalTime-curTime})
				end
			end
		end
		self.eventIdx=self.eventIdx+1
	end
end


function BeatAnimator:removeBall(target)
	display.remove(target)
end


function  BeatAnimator:currentBeat()
	local MAX_TIMEDIFF=200

	local curTime=system.getTimer()-self.startTime
	local beatSrchIdx=self.beatIdx
	while self:isCloserTo(curTime,beatSrchIdx-1,beatSrchIdx) do
		beatSrchIdx=beatSrchIdx-1
	end
	while self:isCloserTo(curTime,beatSrchIdx+1,beatSrchIdx) do
		beatSrchIdx=beatSrchIdx+1
	end

	local curBeat=self.beatData[beatSrchIdx]
	local timediff=math.abs(curTime-curBeat.time)
	if timediff>MAX_TIMEDIFF then return BEATTYPE_NONE
	else return curBeat.type end

end

function BeatAnimator:isCloserTo(t,idx1,idx2)
	if idx1<1 or idx1>#self.beatData then return false end
	if idx2<1 or idx2>#self.beatData then return true end
	t1=self.beatData[idx1].time
	t2=self.beatData[idx2].time
	return math.abs(t-t1)<math.abs(t-t2)
end



--acc = BeatAnimator.create(beatData)