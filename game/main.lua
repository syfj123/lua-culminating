---@diagnostic disable: lowercase-global
platform={}
player={}
platforms={}
coins={}

function resetGame()
    -- resets all values back to start state
    collected_val=0
    timer=0
    timer_started=false
    game_finished=false

    player.x=love.graphics.getWidth()/2
    player.y=love.graphics.getHeight()/1.1
    player.y_velocity=0

    spawnCoin()
end

function spawnCoin()
    -- creates a single coin on a random platform
    local i=love.math.random(1,#platforms)

    coins={
        {
            x=platforms[i].x+love.math.random(0,platforms[i].width),
            y=platforms[i].y-20,
            collected=false,
            img=coin_img
        }
    }
end

function love.load()
    love.graphics.setBackgroundColor(0.8,0.8,0.8)

    -- screen floor platform setup
    platform.width=love.graphics.getWidth()
    platform.height=love.graphics.getHeight()
    platform.x=0
    platform.y=platform.height/1.1

    -- player setup
    player.img=love.graphics.newImage("omori.png")
    player.x=love.graphics.getWidth()/2
    player.y=love.graphics.getHeight()/1.1

    player.ground=platform.y-player.img:getHeight()*0.05
    player.y_velocity=0
    player.jump_height=-600
    player.gravity=1500
    player.speed=270

    playerWidth=player.img:getWidth()*0.05
    playerHeight=player.img:getHeight()*0.05

    -- platforms above ground
    platforms={
        {x=100,y=400,width=200,height=20},
        {x=450,y=500,width=200,height=20},
        {x=300,y=280,width=200,height=20},
        {x=150,y=200,width=200,height=20},
        {x=500,y=120,width=200,height=20}
    }

    -- coin system
    collected_val=0
    target_coins=10
    coin_img=love.graphics.newImage("coin.png")
    spawnCoin()

    -- timer system
    timer=0
    timer_started=false
    game_finished=false
end

function love.update(dt)
    -- restart game on win
    if game_finished then
        if love.keyboard.isDown('r') then
            resetGame()
        end
        return
    end

    -- start timer on first movement
    if not timer_started then
        if love.keyboard.isDown('a') or love.keyboard.isDown('d') or love.keyboard.isDown('space') then
            timer_started=true
        end
    end

    -- update timer
    if timer_started and not game_finished then
        timer=timer+dt
    end

    local scale=0.1

    -- left and right movement
    if love.keyboard.isDown('d') then
        if player.x<(love.graphics.getWidth()-player.img:getWidth()*scale) then
            player.x=player.x+(player.speed*dt)
        end
	elseif love.keyboard.isDown('a') then
        if player.x>0 then
            player.x=player.x-(player.speed*dt)
        end
    end

    -- jump trigger
    if love.keyboard.isDown('space') then
        if player.y_velocity==0 then
            player.y_velocity=player.jump_height
        end
    end

    -- apply gravity and movement
    player.y=player.y+player.y_velocity*dt
    player.y_velocity=player.y_velocity+player.gravity*dt

    -- platform collision check
    for _,p in ipairs(platforms) do
        if player.x+playerWidth>p.x and
        player.x<p.x+p.width and
        player.y+playerHeight>p.y and
        player.y+playerHeight<p.y+p.height and
        player.y_velocity>0 then

            player.y=p.y-playerHeight
            player.y_velocity=0
        end
    end

    -- ground collision
    if player.y>player.ground then
        player.y_velocity=0
        player.y=player.ground
    end

    -- coin collection check
    local coin=coins[1]
    if coin and not coin.collected then
        local dx=(player.x+playerWidth/2)-coin.x
        local dy=(player.y+playerHeight/2)-coin.y

        if math.sqrt(dx*dx+dy*dy)<25 then
            coin.collected=true
            collected_val=collected_val+1

            -- spawn next coin until target reached
            if collected_val<target_coins then
                spawnCoin()
            end

            -- finish game when target reached
            if collected_val==target_coins then
                game_finished=true
            end
        end
    end
end

function love.draw()
    -- floor platform
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("fill",platform.x,platform.y,platform.width,platform.height)

    -- draw platforms
    for _,p in ipairs(platforms) do
        love.graphics.rectangle("fill",p.x,p.y,p.width,p.height)
    end

    -- draw coin
    love.graphics.setColor(1,1,1)
    for _,coin in ipairs(coins) do
        if not coin.collected then
            love.graphics.draw(coin.img,coin.x-10,coin.y-15,0,0.025,0.025)
        end
    end

    -- draw player
    love.graphics.setColor(0,0,0)
    love.graphics.draw(player.img,player.x,player.y,0,0.05,0.05)

    -- UI text
    love.graphics.print("coins: "..collected_val.."/"..target_coins,10,10)
    love.graphics.print("time: "..string.format("%.2f",timer),10,30)

    if game_finished then
        love.graphics.print("you win! press r to restart",love.graphics.getWidth()/2-120,love.graphics.getHeight()/1.5)
    end
end