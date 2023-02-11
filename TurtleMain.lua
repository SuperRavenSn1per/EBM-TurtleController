--Open Rednet
if not rednet.isOpen() then
    rednet.open("right")
end
--Get current turtle coordinates
local function getCoord(coord)
    local f = fs.open("coords/"..coord..".loc", "r")
    local x = f.readAll()
    f.close()
    return tonumber(coord)
end
--Update the coordinates of the turtle
local function updateCoord(coord, change)
    local f = fs.open("coords/"..coord..".loc", "w")
    f.write(change)
    f.close()
end
--Move the turtle one block forward
local function walk()
    local x,y,z,r = getCoord("x"),getCoord("y"),getCoord("z"),getCoord("r")
    turtle.forward()
    if r == 1 then
        updateCoords(x + 1, y, z, r)
    elseif r == 2 then
        updateCoords(x, y, z + 1, r)
    elseif r == 3 then
        updateCoords(x - 1, y, z, r)
    elseif r == 4 then 
        updateCoords(x, y, z - 1, r)
    end
end
--Rotate the turtle once
local function rotate()
    local x,y,z,r = getCoord("x"),getCoord("y"),getCoord("z"),getCoord("r")
    turtle.turnRight()
    if r < 4 then
        updateCoords(x, y, z, r + 1)
    else
        updateCoords(x, y, z, 1)
    end
end
--Mine 3 blocks
local function path()
    turtle.dig()
    turtle.digUp()
    turtle.digDown()
end
--Goes to selected coordinates, X first then Z
local function goTo(dX, dY, dZ)
    local x, y, z, r = getCoords()
    if x < dX then
        if r ~= 1 then
            if r == 4 then
                rotate()
            else
                repeat rotate() r = r+1 until r == 4 end
                rotate()
        end
    elseif x > dX then
        if r ~= 3 then
            if r == 4 then
                rotate()
                r = 1
                repeat rotate() r = r+1 until r == 3
            else
                repeat rotate() r = r+1 until r == 3 
            end
        end
    end
    repeat walk() xC = getCoord("x") until Xc == dX
    
end
goTo(0,0,0)
