-- Script made by Oysi
-- Modified by Jordan4Ibanez

require "movement"
require "generate"
require "render"
require "helpers"

function love.load()
	setupwindow()
end

function love.draw()
	renderscene()
end


function love.update(delta)
	movement(delta)
end
