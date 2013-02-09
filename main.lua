-- PURPLE PARTY PANDA
require("danceBattle")
require("buttons")

function onButtonMenuTap(time, self)
  -- check self
  if self.id == "play" then
    --destroy the main menu
    Button.destroy(self)
    --and then show game
    buildDanceGui(0)
  elseif self.id == "options" then
    -- show options overlay
  elseif self.id == "levels" then
    -- show level overlay
  elseif self.id == "credits" then
    -- show credit overlay
  elseif self.id == "exit" then
    -- close app
  else
    print("it's another button")
  end

end

function getTestAnimation()
    local sprite = require("sprite")
    local frame1 = sprite.newSpriteSheet("images/bear_walk_down1.png", 120, 120)
    local frame2 = sprite.newSpriteSheet("images/bear_walk_down2.png", 120, 120)
    local frame3 = sprite.newSpriteSheet("images/bear_walk_down3.png", 120, 120)
    local frame4 = sprite.newSpriteSheet("images/bear_walk_down4.png", 120, 120)
    local frame5 = sprite.newSpriteSheet("images/bear_walk_down5.png", 120, 120)
    local frame6 = sprite.newSpriteSheet("images/bear_walk_down6.png", 120, 120)
    local frame7 = sprite.newSpriteSheet("images/bear_walk_down7.png", 120, 120)
    local frame8 = sprite.newSpriteSheet("images/bear_walk_down8.png", 120, 120)
	--local spriteSet = sprite.newSpriteSet(frame1, 1, 1)
	local spriteSet = sprite.newSpriteMultiSet( 
        {
            { sheet = frame1, frames = { 1 } },
            { sheet = frame2, frames = { 1 } },
            { sheet = frame3, frames = { 1 } },
            { sheet = frame4, frames = { 1 } },
            { sheet = frame5, frames = { 1 } },
            { sheet = frame6, frames = { 1 } },
            { sheet = frame7, frames = { 1 } },
            { sheet = frame8, frames = { 1 } },
        }
    )
	sprite.add(spriteSet, "bear_walk_down", 1, 8, 750, 0)
	spriteInstance = sprite.newSprite(spriteSet)
	spriteInstance:prepare("bear_walk_down")
	return spriteInstance
end

function init()
  display.setStatusBar(display.HiddenStatusBar)
  print(display.contentWidth .. "x" .. display.contentHeight)
  local bg = display.newImage ("images/outside.jpg");
  local origwidth = bg.width
  local origheight = bg.height
  if display.contentHeight > 800 then
    bg.height = display.contentHeight
	bg.width = bg.height / origheight * origwidth
  elseif display.contentHeight < 640 then
    bg.height = display.contentHeight / 640 * 800
	bg.width = bg.height / origheight * origwidth
  end
  print(bg.width .. "x" .. bg.height)
  bg.x = display.contentWidth / 2
  bg.y = display.contentHeight / 2
  buttonPlay = Button.create("play", {200,200}, {display.contentWidth / 2,display.contentHeight / 2}, "images/button_a.png", "images/button_a_over.png", onButtonMenuTap)
  
  --require "movieclip"
  --local myAnim = movieclip.newAnim( { "images/bear_walk_down1.png","images/bear_walk_down2.png","images/bear_walk_down3.png","images/bear_walk_down4.png","images/bear_walk_down5.png","images/bear_walk_down6.png","images/bear_walk_down7.png","images/bear_walk_down8.png" } )
  --myAnim.x = display.contentWidth / 2
  --myAnim.y = display.contentHeight / 2
  --myAnim:play()
  local animation = getTestAnimation()
  animation.x = display.contentWidth / 2
  animation.y = display.contentHeight / 2
  animation:play()
end

init()