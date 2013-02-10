function gottaDance()
    local sprite = require("sprite")
    local frame1 = sprite.newSpriteSheet("images/basic_move_01_1.png", 319, 510)
    local frame2 = sprite.newSpriteSheet("images/basic_move_01_2.png", 319, 510)
    local frame3 = sprite.newSpriteSheet("images/basic_move_01_3.png", 319, 510)
    local frame4 = sprite.newSpriteSheet("images/basic_move_01_4.png", 319, 510)
    local frame5 = sprite.newSpriteSheet("images/basic_move_01_5.png", 319, 510)
    local frame6 = sprite.newSpriteSheet("images/basic_move_01_6.png", 319, 510)
    local frame7 = sprite.newSpriteSheet("images/basic_move_01_7.png", 319, 510)
    local frame8 = sprite.newSpriteSheet("images/basic_move_01_8.png", 319, 510)
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

function summonPanda()
  local animation = gottaDance()
  animation.x = display.contentWidth / 2
  animation.y = display.contentHeight / 2
  animation:play()
end

