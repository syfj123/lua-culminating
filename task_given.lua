local ints={1,9,13,2,6,45,-10}

local highest=0
local second_highest=0

for i,v in ipairs(ints) do
    if v>highest then
        second_highest=highest
        highest=v
    elseif v>second_highest and v~=highest then
        second_highest=v
    end
end

print("highest: " .. highest..", second highest: "..second_highest)