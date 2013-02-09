
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

function BeatAnimator:registerBtn(btn,type)
	btn.button.alpha=0.5
   table.insert(self.buttons,{btn=btn,type=type})
end

function BeatAnimator:start()
	print("----------------------- start ------------------------")
   self.startTime=system.getTimer()
   self.beatIdx=1
   self:update()
end

function BeatAnimator:update()
	log("update "..self.beatIdx.." out of "..#self.beatData)
	if self.beatIdx>#self.beatData then return end

	local curTime=system.getTimer()-self.startTime
	local fadeInTime=50
	local fadeOutTime=250
	local animOutTime, animInTime

	local curBeat,nextBeatTimeDiff


	while self.beatIdx<=#self.beatData do
		curBeat=self.beatData[self.beatIdx]
		nextBeatTimeDiff=curBeat.time-fadeInTime-curTime
		if nextBeatTimeDiff>30 then
			--run this function again after a delay
			local updateClosure=function() self:update() end
			timer.performWithDelay(nextBeatTimeDiff,updateClosure,1)
			break
		end

		for i,btn in ipairs(self.buttons) do
			if btn.type==curBeat.type then
				if curTime>curBeat.time then
					btn.btn.button.alpha=1.0
					animOutTime=curBeat.time+fadeOutTime-curTime
					transition.to(btn.btn.button,{time=animOutTime,alpha=0.5})
				else
					animInTime=curBeat.time-curTime
					animOutTime=fadeOutTime
					transition.to(btn.btn.button,{time=animInTime,alpha=1.0})
					transition.to(btn.btn.button,{delay=animInTime,time=animOutTime,alpha=0.5})
				end
			end
		end
		self.beatIdx=self.beatIdx+1
	end
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