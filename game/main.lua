platform={}
player={}
platforms={}

function love.load()
    love.graphics.setBackgroundColor(0.8,0.8,0.8)
    -- height n width, it will make the platform as wide and tall as game window
    platform.width=love.graphics.getWidth()
    platform.height=love.graphics.getHeight()

    platform.x=0
    platform.y=platform.height/1.1

    player.x=love.graphics.getWidth()/2
	player.y=love.graphics.getHeight()/2

    player.img=love.graphics.newImage("omori.png")

    player.ground=player.y
    player.y_velocity=0
    player.jump_height=-500
    player.gravity=-1500

    player.speed=270

    platforms={
        {x = 100, y = 500, width = 200, height = 20},
        {x = 450, y = 400, width = 200, height = 20},
        {x = 300, y = 200, width = 200, height = 20}
    }
end

function love.update(dt) -- dt is delta time, this updates game 
    local scale=0.1
    if love.keyboard.isDown('d') then -- right movement
		if player.x<(love.graphics.getWidth()-player.img:getWidth()*scale) then
			player.x = player.x + (player.speed*dt)
        end
	elseif love.keyboard.isDown('a') then -- left movement
		if player.x>0 then
            player.x=player.x-(player.speed*dt)
        end
    end

    if love.keyboard.isDown('space') then -- jump check
        if player.y_velocity==0 then
            player.y_velocity=player.jump_height
        end
    end

    if player.y_velocity~=0 then -- check to see if player has jumped
        player.y=player.y+player.y_velocity*dt -- makes character jump
        player.y_velocity=player.y_velocity-player.gravity*dt -- applies gravity
    end

    -- collision
    if player.y>player.ground then
        player.y_velocity=0
        player.y=player.ground
    end
end

function love.draw()
    love.graphics.setColor(0,0,0) -- this is white. the scale is 0 - 1 not 0 - 255 (rgba)

    love.graphics.rectangle("fill",platform.x,platform.y,platform.width,platform.height)

    for _,p in ipairs(platforms) do
        love.graphics.rectangle("fill",p.x,p.y,p.width,p.height)
    end

    love.graphics.draw(player.img,player.x+7,player.y+201,0,0.05,0.05)
end
 