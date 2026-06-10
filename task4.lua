-- string manipulation

--slicing

local example="hello"

local example_sliced=string.sub(example,1,3) -- parameters are (string,start index,stop index)

print(example_sliced)

--concat

local example_concat1=io.read("hello ")