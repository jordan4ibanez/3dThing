function movement(delta)
	local moveSpeed = delta
	local rotSpeed  = delta

	if love.keyboard.isDown("escape") then
		love.event.quit()
	end
	if love.keyboard.isDown("a") then
		translate(moveSpeed, 0, 0)
	end
	if love.keyboard.isDown("d") then
		translate(-moveSpeed, 0, 0)
	end
	
	if love.keyboard.isDown("w") then
		translate(0, 0, moveSpeed)
	end
	if love.keyboard.isDown("s") then
		translate(0, 0, -moveSpeed)
	end
	if love.keyboard.isDown(" ") then
		translate(0, -moveSpeed, 0)
	end
	if love.keyboard.isDown("lshift") then
		translate(0, moveSpeed, 0)
	end
	
	if love.keyboard.isDown("q") then
		rotateY(rotSpeed)
	end
	if love.keyboard.isDown("e") then
		rotateY(-rotSpeed)
	end

end
