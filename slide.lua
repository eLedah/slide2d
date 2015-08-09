slide = {} 
for i = 1, 32, 1 do
	slide[i] = 0
end

addhook("move", "checkIfOnTile")
addhook("always", "slider")
addhook("startround", "resetSlide")
---------------Config---------------
-- Speed
speed = 10
-- Frame number
tileFrame = 34
------------------------------------

function checkIfOnTile(id, x, y, walk)
	if(tile(math.floor(x / 32), math.floor(y / 32), "frame") == tileFrame ) then
		slide[id] = 1;
	end
end

function slider()
	for i = 1, 32, 1 do
		if(slide[i] == 1) then 
			if(player(i, "exists")) then
				rot = player(i, "rot")
				newX = (player(i, "x") + math.cos(math.rad(rot)-math.pi/2) * speed) 
				newY = (player(i, "y") + math.sin(math.rad(rot)-math.pi/2) * speed) 
				if(tile(math.floor(newX / 32), math.floor(newY / 32), "walkable") and tile(math.floor(newX / 32), math.floor(newY / 32), "frame") == tileFrame) then
					parse('setpos '..i..' '..newX..' '..newY)
				else
					slide[i] = 0
				end
			end
		end
	end
end

function resetSlide()
	for i = 1, 32, 1 do
		slide[i] = 0
	end
end
