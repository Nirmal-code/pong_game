window_width=1280
window_height=720
paddle_speed=400

function love.load()

	love.window.setMode(window_width, window_height, {
		fullscreen=false,
		resizable=false,
		vsync=true
	})

	playerone_score=0
	playertwo_score=0

	playerone_position=400
	playertwo_position=window_height-50

	ballx=window_width/2-2
	bally=window_height-200

	ballDx=math.random(2)==1 and 500 or -500
	ballDy=math.random(-400, 400)

	math.randomseed(os.time())

	gameState='play'

end

function love.draw()

	love.graphics.printf('Welcome to Pong!', 0, window_height/6, window_width, 'center')

	love.graphics.rectangle('fill', 10, playerone_position, 5, 50)
	love.graphics.rectangle("fill", window_width-10, playertwo_position, 5, 50)
	love.graphics.rectangle("fill", ballx, bally, 10, 10)

	love.graphics.rectangle('line', 0, window_height-320, window_width, 400)

	love.graphics.print(tostring(playerone_score), window_width/2-50, window_height/3)
	love.graphics.print(tostring(playertwo_score), window_width/2+30, window_height/3)

end

function love.update(dt)

	if love.keyboard.isDown("w") then
		playerone_position=math.max(400, playerone_position + -paddle_speed * dt)
	elseif love.keyboard.isDown("s") then
		playerone_position=math.min(window_height-50, playerone_position + paddle_speed * dt)
	end

	if love.keyboard.isDown("up") then
		playertwo_position=math.max(400, playertwo_position + -paddle_speed * dt)
	elseif love.keyboard.isDown("down") then
		playertwo_position=math.min(window_height-50, playertwo_position + paddle_speed * dt)
	end

	if gameState=='start' then
		ballx=ballx+ballDx*dt
		bally=bally+ballDy*dt
	end

	if (bally>=window_height) or (bally<=400) then
		ballDy=-1*ballDy
	end

	if ballx<=5 then
		if (playerone_position<=bally) and (bally<=playerone_position+50) then
			ballDx=-1*ballDx
		elseif ballx<-5 then
			ballx=window_width/2-2
			bally=window_height-200
			ballDx=0
			ballDy=0
			playertwo_score=playertwo_score+1
		end
	end

	if ballx>=(window_width-15) then
		if (playertwo_position<=bally) and (bally<=playertwo_position+50) then
			ballDx=-1*ballDx
		elseif ballx>window_width+5 then
			ballx=window_width/2-2
			bally=window_height-200
			ballDx=0
			ballDy=0
			playerone_score=playerone_score+1
		end
	end

end


function love.keypressed(key)
	if key=='escape' then

		love.event.quit()

	elseif key=='enter' or key=='return' then
		if gameState=='start' then
			gameState='play'
		else
			gameState='start'
			ballx=window_width/2-2
			bally=window_height-200
			ballDx=math.random(2)==1 and 500 or -500
			ballDy=math.random(-400, 400)
		end
	end
end



