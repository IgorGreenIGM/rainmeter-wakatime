Wutils = {}

function Wutils.PrintDict(t, indent)
    -- Default indentation
    indent = indent or 0

    -- Check if input is a table
    if type(t) ~= "table" then
        print(string.rep(" ", indent) .. tostring(t))
        return
    end

    for k, v in pairs(t) do
        io.write(string.rep(" ", indent) .. tostring(k) .. ": ")

        if type(v) == "table" then
            print()
            Wutils.PrintDict(v, indent + 2)
        else
            print(tostring(v))
        end
    end
end


function Wutils.FormatDate(day, month)
    local fmonth = ""
    
    -- translate month
    local months = {
        "Jan", "Feb", "Mar", "Apr", "May", "Jun",
        "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    }
    
    fmonth = months[month]

    -- translate date
    local fdate = ""
    if day >= 10 and day <= 13 then
        fdate = day .. "th"
    else
        local last_digit = day % 10
        if last_digit == 1 then
            fdate = day .. "st"
        elseif last_digit == 2 then
            fdate = day .. "nd"
        elseif last_digit == 3 then
            fdate = day .. "rd"
        else
            fdate = day .. "th"
        end
    end

    return fmonth .. " " .. fdate
end

function Wutils.OrdinalSuffix(number)
    local suffix = "ᵗʰ"
    local last_digit = number % 10
    local last_two_digits = number % 100

    if last_digit == 1 and last_two_digits ~= 11 then
        suffix = "ˢᵗ"
    elseif last_digit == 2 and last_two_digits ~= 12 then
        suffix = "ⁿᵈ"
    elseif last_digit == 3 and last_two_digits ~= 13 then
        suffix = "ʳᵈ"
    end

    return tostring(number) .. suffix
end

function Wutils.FormatLongDate(day, month)
    local fmonth = ""
    
    -- translate month
    local months = {
        "January", "February", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December"
    }
    
    fmonth = months[month]

    -- translate date
    local fdate = ""
    if day >= 10 and day <= 13 then
        fdate = day .. "th"
    else
        local last_digit = day % 10
        if last_digit == 1 then
            fdate = day .. "st"
        elseif last_digit == 2 then
            fdate = day .. "nd"
        elseif last_digit == 3 then
            fdate = day .. "rd"
        else
            fdate = day .. "th"
        end
    end

    return fmonth .. " " .. fdate
end


function Wutils.RandomColor(exclude)
    local colors_table = {"F34B7D", "DA3434", "FFC107", "607D8B",
                          "2196F3", "795548", "00BCD4", "FF5722",
                          "673AB7", "4CAF50", "9E9E9E", "3F51B5",
                          "03A9F4", "8BC34A", "CDDC39", "FF9800",
                          "E91E63", "9C27B0", "F44336", "009688",
                          "FFEB3B", "02B046", "003FA2", "81BD41"}

    -- Create a new table with excluded colors removed
    local filtered_colors = {}
    for i = 1, #colors_table do
        local color = colors_table[i]
        local exclude_color = false
        if exclude then
            for j = 1, #exclude do
                if color == exclude[j] then
                    exclude_color = true
                    break
                end
            end
        end
        if not exclude_color then
            table.insert(filtered_colors, color)
        end
    end

    math.randomseed(os.time())
    if #filtered_colors == 0 then -- If no colors are left after exclusion, return random color
        return colors_table[math.random(#colors_table)]
    else -- Get a random color from the remaining colors
        return filtered_colors[math.random(#filtered_colors)]
    end
end

function Wutils.NormalizeColorName(color)
    local mtable = {
        ["("]="", ["'"]="", ["8"]="Eight", ["4"]="Four", [")"]="", ["."]="", ["-"]="",["5"]="Five",["1"]="One", 
        ["+"]="Plus", ["3"]="Three", ["#"]="Sharp", ["*"]="Star", ["0"]="Zero", ["2"]="Two", ["6"]="Six"
    }

    color = string.lower(color)
    color = string.upper(color:sub(1,1))..color:sub(2,#color)
    local translated = ""
    for c in color:gmatch"." do
        if mtable[c] ~= nil then
            translated = translated..mtable[c]
        else
            translated = translated..c
        end
    end

    return translated
end

return Wutils