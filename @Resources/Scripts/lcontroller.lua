function Initialize()
    -- include externals libraries
    Wutils = dofile(SKIN:GetVariable('@')..'Scripts\\wutils.lua')
    JSON = dofile(SKIN:GetVariable('@')..'Scripts\\externals\\JSON.lua')

    -- Get the current path from the Rainmeter variable
    CurrentPath = SKIN:GetVariable('CURRENTPATH')
end

-- Build circular chart diagram for last seven days progralling languages repartition
function BuildLanguagesChart()
    local last_datas = JSON:decode(SKIN:GetMeasure('FetchLastSevenDaysDatas'):GetStringValue())
    last_datas = last_datas["data"]
    local languages = last_datas['languages']
    local max_languages = tonumber(SKIN:GetVariable("MaxLanguages"))

    local new_start = 270
    for i, language in ipairs(languages) do
        if i > max_languages then
            break
        end
        
        local name = language['name']
        local percent = language['percent']
        local color = "#Color"..Wutils.NormalizeColorName(name).."#"

        -- build disk regions
        SKIN:Bang("!SetOption", "DiskRegion"..i, "StartAngle", math.rad(new_start))
        SKIN:Bang("!SetOption", "DiskRegion"..i, "RotationAngle", math.rad(360*percent/100))
        SKIN:Bang("!SetOption", "DiskRegion"..i, "LineColor", color)
        new_start = (new_start + 360*percent/100)%360

        --build legends  
        SKIN:Bang("!SetOption", "Legend"..i, "Text", "● "..name.." ("..percent.."%)")
        SKIN:Bang("!SetOption", "Legend"..i, "FontColor", "255,255,255")
        SKIN:Bang("!SetOption", "Legend"..i, "InlineSetting", "Size | (21.6*#Scale#)")
        SKIN:Bang("!SetOption", "Legend"..i, "InlinePattern", "^●")
        SKIN:Bang("!SetOption", "Legend"..i, "InlineSetting2", "Color | "..color)
        SKIN:Bang("!SetOption", "Legend"..i, "InlinePattern2", "^●")
    end

    SKIN:Bang("!Redraw")
end