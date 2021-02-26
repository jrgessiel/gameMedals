require("class/collision")

function love.load()
    math.randomseed(os.time())
  
  player = {}
  player.x = 50
  player.y = 300
  player.w = 85
  player.h = 100
  player.direction = "up"
  player.direction = "down"
  player.direction = "left"
  player.direction = "right"
  
  medals = {}
  
  score = 0
  
  sounds = {}
  sounds.medal = love.audio.newSource("assets/sounds/medal.ogg", "static")
  
  fonts = {}
  fonts.large = love.graphics.newFont("assets/fonts/Gamer.ttf", 36)
  
  images = {}
  images.background = love.graphics.newImage("assets/images/background/ground.png")
  images.medal = love.graphics.newImage("assets/images/medal/2.png")
  images.player_up = love.graphics.newImage("assets/images/player/player_up.png")
  images.player_down = love.graphics.newImage("assets/images/player/player_down.png")
  images.player_left = love.graphics.newImage("assets/images/player/player_left.png")
  images.player_right = love.graphics.newImage("assets/images/player/player_right.png")
  
end

function love.update(dt)
  if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
  player.y = player.y - 4
  player.direction = "up"
  
  elseif love.keyboard.isDown("s") or love.keyboard.isDown("down") then
  player.y = player.y + 4
  player.direction = "down"
  
  elseif love.keyboard.isDown("a") or love.keyboard.isDown("left") then
  player.x = player.x - 4
  player.direction = "left"

  elseif love.keyboard.isDown("d") or love.keyboard.isDown("right") then
  player.x = player.x + 4
  player.direction = "right"
  
end

  for i=#medals, 1, -1 do
    local medal = medals[i]
    if AABB(player.x, player.y, player.w, player.h, medal.x, medal.y, medal.w, medal.h) then
      table.remove(medals, i)
      score = score + 1
      sounds.medal:play()
    end
  end
  
  if math.random() < 0.01 then
    local medal = {}
    medal.w = 56
    medal.h = 56
    medal.x = math.random(0, 800 - medal.w)
    medal.y = math.random(0, 600 - medal.h)
    table.insert(medals, medal)
  end
end

function love.draw()
  for x=0, love.graphics.getWidth(), images.background:getWidth() do
    for y=0, love.graphics.getHeight(), images.background:getHeight() do
    love.graphics.draw(images.background, x, y)
    end
  end
  
  local img = images.player_down
  if player.direction == "up" then
    img = images.player_up
  elseif player.direction == "down" then
    img = images.player_down
  elseif player.direction == "left" then
    img = images.player_left
  elseif player.direction == "right" then
    img = images.player_right
  end

  love.graphics.draw(img, player.x, player.y)
  
  for i=1, #medals, 1 do
    local medal = medals[i]
    love.graphics.draw(images.medal, medal.x, medal.y)
  end
  love.graphics.setFont(fonts.large)
  love.graphics.print("Score: "..score, 10, 10)
end