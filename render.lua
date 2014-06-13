posx,posy,posz = 20,20,0

function setupwindow()
	width, height = 1100,700
	love.window.setMode( width, height )
end

math.randomseed( os.time()) 

scene = {}

--Generate random polygons (Garbage)
for i = 1,1 do

	local x =  math.random()*2-1
	local y =  math.random()*2-1
	local z = -math.random()*2
	
	--Random quardinates based off of the center of the polygon
	scene[i] = {
	
		polynumber = i,
	
		x = x,
		y = y,
		z = z,
		
		x1 = x + -1,
		y1 = y + -1,
		z1 = z + 1,
		
		x2 = x + -1,
		y2 = y + 1,
		z2 = z + 1,
				
		x3 = x + 1,
		y3 = y + 1,
		z3 = z + 1,
				
		x4 = x + 1,
		y4 = y + -1,
		z4 = z + 1,
		
		color = {math.random(255),math.random(255),math.random(255)},
		
	}
end

--Take all of the generated poly's quardinates and convert them into usable data
function renderscene()
	
	--Add all the polygons to a rendering table to sort rendering order
	local rendertable = {}
	for i = 1,tablelength(scene) do
		local vertex = scene[i]
		rendertable[i] = {}
		rendertable[i].polygon = vertex.polynumber
		rendertable[i].value = (vertex.z1+vertex.z2+vertex.z3+vertex.z4)/4
	end
	
	--sort table with help from hjpotter92
	table.sort(rendertable, function(a,b) return a.value < b.value end)
	
	--render table based on distance from camera
	for _,polygon in pairs(rendertable) do
		
		local o = polygon.polygon
		
		local vertex = scene[o]

		--do this here so it doesn't waste any cpu if the object is behind you
		
		local x1 = vertex.x1 / -vertex.z1
		local y1 = vertex.y1 /  vertex.z1
		
		x1 = 400 + (x1 * 400)
		y1 = 300 + (y1 * 400) 
		
		
		local x2 = vertex.x2 / -vertex.z2
		local y2 = vertex.y2 /  vertex.z2
		
		x2 = 400 + (x2 * 400)
		y2 = 300 + (y2 * 400)
		
		local x3 = vertex.x3 / -vertex.z3
		local y3 = vertex.y3 /  vertex.z3
		
		x3 = 400 + (x3 * 400)
		y3 = 300 + (y3 * 400)

		
		local x4 = vertex.x4 / -vertex.z4
		local y4 = vertex.y4 /  vertex.z4
		
		x4 = 400 + (x4 * 400)
		y4 = 300 + (y4 * 400)
		
		
		--make it so that polys do not glitch, can only display one side as side effect
		local avez = ((vertex.z1+vertex.z2+vertex.z3+vertex.z4)/4)
		
		if avez > 0 then
			print("fail1")
			return
		end
		
		print(x2)
		if (x4 < 0) and (x1 > x3 or x2 > x4) then
			
			print("x1:"..x1.." x2:"..x2.." x3:"..x3.." x4:"..x4)
			print("fail2")
			return
		elseif (x2 > width) and (x3 < x1 or x4 < x2) then
	
			print("x1:"..x1.." x2:"..x2.." x3:"..x3.." x4:"..x4)
			print("fail3")
			return
		end
		
		if (x1 - x2) < (-width) then
			print("fail3")
			return
		end

		love.graphics.setColor(vertex.color)
		
		love.graphics.polygon("fill", x1, y1, x2, y2, x3, y3, x4, y4)

	end

end

function translate(x, y, z)
	for _,vertex in pairs(scene) do

		vertex.x1 = vertex.x1 + x
		vertex.y1 = vertex.y1 + y
		vertex.z1 = vertex.z1 + z
		
		vertex.x2 = vertex.x2 + x
		vertex.y2 = vertex.y2 + y
		vertex.z2 = vertex.z2 + z
		
		vertex.x3 = vertex.x3 + x
		vertex.y3 = vertex.y3 + y
		vertex.z3 = vertex.z3 + z
		
		vertex.x4 = vertex.x4 + x
		vertex.y4 = vertex.y4 + y
		vertex.z4 = vertex.z4 + z
		
		
	end
end

function rotateY(r)
	local cosR = math.cos(r)
	local sinR = math.sin(r)
	for _, vertex in pairs(scene) do
	
		local x1 = vertex.x1
		local z1 = vertex.z1
		
		vertex.x1 = x1*cosR + z1*-sinR
		vertex.z1 = x1*sinR + z1*cosR
			
		local x2 = vertex.x2
		local z2 = vertex.z2
		
		vertex.x2 = x2*cosR + z2*-sinR
		vertex.z2 = x2*sinR + z2*cosR
			
		local x3 = vertex.x3
		local z3 = vertex.z3
		
		vertex.x3 = x3*cosR + z3*-sinR
		vertex.z3= x3*sinR + z3*cosR
		
			
		local x4 = vertex.x4
		local z4 = vertex.z4
		
		vertex.x4 = x4*cosR + z4*-sinR
		vertex.z4 = x4*sinR + z4*cosR
	
	end
end
