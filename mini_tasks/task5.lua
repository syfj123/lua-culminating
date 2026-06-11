-- list/array manip

-- create array/list

local example_array={"uno","dos","tres","quatros"}

for i,v in ipairs(example_array) do
    print(i,v) -- showing the index value of each value in the list/array
end

local inventory={}

inventory[1]="boots"
inventory[2]="cowabunga"
inventory[3]="food"

print(inventory[2].."\n")

for _,value in ipairs(inventory) do
    print(value)
end

print() -- new line

table.remove(inventory,3)

for _,value in ipairs(inventory) do
    print(value)
end