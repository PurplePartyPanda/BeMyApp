sprite=require("sprite")

PartyPanda = {}
PartyPanda.__index = PartyPanda

function PartyPanda.create(bpm)
   local obj = {}             -- our new object
   setmetatable(obj,PartyPanda)  -- make BeatAnimator handle lookup
   obj.bpm=bpm
   obj.timePerBeat=60/bpm*1000
   return obj
end

-- function PartyPanda:makeSpriteSet(setName,w,h,numBeats,isRepeating,imgArr)
--     local frame
--     local frameList={}
--     for idx,imgFile in ipairs(imgArr)
--         frame=sprite.newSpriteSheet(imgFile, w, h)
--         table.insert(self.spriteSheets,frame)
--         table.insert(frameList,{sheet=frame,frames={1}})
--     end
--     local spriteSet=sprite.newSpriteMultiSet(frameList)
--     local numLoops
--     if isRepeating then numLoops=0 else numLoops=1 end
--     sprite.add(spriteSet,setName,1,#imgArr,self.timePerBeat*numBeats,numLoops)
--     return spriteSet
-- end

-- function PartyPanda:makeSpriteSetFromFileSeq(setName,w,h,numBeats,isRepeating,imgPrefix,numImages)
--     local imgArr={}
--     for idx=1,numImages do
--         table.insert(imgArr,imgPrefix..tostring(idx)..".png")
--     end
--     return self:makeSpriteSet(setName,w,h,numBeats,isRepeating,imgArr)
-- end


-- function PartyPanda:preload()
--     local defaultSpriteSet
--     defaultSpriteSet=self:makeSpriteSet("bear_walk_down",319,510,2,true,{
--         "images/basic_move_01_3.png",
--         "images/basic_move_01_2.png",
--         "images/basic_move_01_7.png",
--         "images/basic_move_01_4.png"
--         })

--     self:makeSpriteSetFromFileSeq("bear_cross",319,510,2,true,"images/cross_0",8)

--     local animation
--     animation = sprite.newSprite(defaultSpriteSet)
--     animation:prepare("bear_walk_down")
--     animation.x = display.contentWidth / 2
--     animation.y = display.contentHeight / 2
--     self.pandaSprite=animation
-- end

function PartyPanda:prepareToParty()
    local sheet=graphics.newImageSheet( "images/spritesheet.png", {width=320,height=500,numFrames=16} )
    local sequenceData={
        {name="defaultDance", frames={3,2,7,4}, time=self.timePerBeat*2, loopCount=0},
        {name="fancyDance", start=1, count=8, time=self.timePerBeat*2, loopCount=1},
        {name="cross", start=9, count=8, time=self.timePerBeat*2, loopCount=1}
    }
    self.pandaSprite=display.newSprite( sheet, sequenceData )
    self.pandaSprite.x=display.contentWidth*0.5
    self.pandaSprite.y=display.contentHeight*0.5
end

function PartyPanda:startDancing()
    self.pandaSprite:setSequence("defaultDance")
    self.pandaSprite:play()
end

function PartyPanda:gottaMove(moveName)
    self.pandaSprite:setSequence(moveName)
    local closure=function(event) if (event.phase=="ended") then self:onMoveEnded() end end
    self.pandaSprite:addEventListener( "sprite", closure)
    self.pandaSprite:play()
end

function PartyPanda:onMoveEnded()
    self.pandaSprite:setSequence("defaultDance")
    self.pandaSprite:play()
end

function summonPanda(bpm)
    return PartyPanda.create(bpm)
end
