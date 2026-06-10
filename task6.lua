-- functions

function max(num1,num2)
    if num1>num2 then
        result=num1
    else
        result=num2
    end
    
    return result

end

print(max(3,100))


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
        error("invalid source unit, use "K","C" or "F")
    end

    local resulting
    if to=="C"
        result=celsius
    elseif to==
end
temp_convert()