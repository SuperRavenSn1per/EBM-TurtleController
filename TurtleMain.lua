--Open Rednet
if not rednet.isOpen() then
    rednet.open("right")
end
--Get current turtle coordinates
local function getCoords()
    local f = fs.open("coords/x.loc", "r")
    local x = f.readAll()
    f.close()
    local f = fs.open("coords/y.loc", "r")
    local y = f.readAll()
    f.close()
    local f = fs.open("coords/z.loc", "r")
    local z = f.readAll()
    f.close()
    local f = fs.open("coords/r.loc", "r")
    local rot = f.readAll()
    f.close()
    return x,y,z,rot
end
--Update the coordinates of the turtle
local function updateCoords(uX,uY,uZ,uR)
    local f = fs.open("coords/x.loc", "w")
    f.write(uX)
    f.close()
    local f = fs.open("coords/y.loc", "w")
    f.write(uY)
    f.close()
    local f = fs.open("coords/z.loc", "w")
    f.write(uZ)
    f.close()
    local f = fs.open("coords/r.loc", "w")
    f.write(uR)
    f.close()
end
--Move the turtle one block forward
local function walk()
    local x,y,z,r = getCoords()
    turtle.forward()
    if tonumber(r) == 1 then
        updateCoords(x + 1, y, z, r)
    elseif tonumber(r) == 2 then
        updateCoords(x, y, z + 1, r)
    elseif tonumber(r) == 3 then
        updateCoords(x - 1, y, z, r)
    elseif tonumber(r) == 4 then 
        updateCoords(x, y, z - 1, r)
    end
end
--Rotate the turtle once
local function rotate()
    local x,y,z,r = getCoords()
    turtle.turnRight()
    if tonumber(r) < 4 then
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
    if tonumber(x) < dX then
        if tonumber(r) ~= 1 then
            if tonumber(r) == 4 then
                rotate()
            else
                repeat rotate() r = r+1 until r == 4 end
                rotate()
        end
    elseif tonumber(x) > dX then
        if tonumber(r) ~= 3 then
            if tonumber(r) == 4 then
                rotate()
                r = 1
                repeat rotate() r = r+1 until r == 3
            else
                repeat rotate() r = r+1 until r == 3 
            end
        end
    end
    repeat walk() xC = getCoords() until tonumber(xC) == dX
    
end
goTo(0,0,0)
