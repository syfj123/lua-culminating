-- functions

-- function max(num1,num2)
--     if num1>num2 then
--         result=num1
--     else
--         result=num2
--     end
    
--     return result

-- end

-- print(max(3,100))


-- temp converter

function temp_convert(num,from,to)
    from=string.upper(from)
    to=string.upper(to)

    if from==to then return num end

    local celsius
    if from=="C" then
        celsius=num
    elseif from=="K" then
        celsius=num-273.15
    elseif from=="F" then
        celsius=(num-32)*(5/9)
    else
        error("invalid input unit, use 'K','C' or 'F'")
    end

    local result
    if to=="C" then
        result=celsius
    elseif to=="K" then
        result=celsius+273.15
    elseif to=="F" then
        result=(celsius*9/5)+32
    else 
        error("invalid output unit, use 'K','C' or 'F'")
    end

    return math.floor(result * 100 + 0.5) / 100

end

print("what value of temp do u want to convert")

local val=tonumber(io.read())

print("what is the starting unit of this temperature")

local start_u=io.read()

print("what is output unit that u want to convert to")

local end_u=io.read()

converted_temp=temp_convert(val,start_u,end_u)

print("your converted temperature is: "..converted_temp..end_u)