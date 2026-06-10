-- string manipulation

--slicing

local example="hello"

local example_sliced=string.sub(example,1,3) -- parameters are (string,start index,stop index)

print(example_sliced)

--concat

print("Whats ur name?")
local name=io.read()
print("i am concatenating your name here: "..name.." and i will type some stuff here :)") -- .. is concatenator
