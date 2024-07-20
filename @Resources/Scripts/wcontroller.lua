function Initialize()
    -- include externals libraries
    Wmath = dofile(SKIN:GetVariable('@')..'Scripts\\wmath.lua')
    Wutils = dofile(SKIN:GetVariable('@')..'Scripts\\wutils.lua')
    Wakatime = dofile(SKIN:GetVariable('@')..'Scripts\\wakatime.lua')
    JSON = dofile(SKIN:GetVariable('@')..'Scripts\\externals\\JSON.lua')

    AccessWeeklyStats = 3
    UpdateDisabled = false
    CurrentPath = SKIN:GetVariable('CURRENTPATH')
end

function Update()
    if UpdateDisabled then
        return
    end

    if AccessWeeklyStats ~= 0 then
        AccessWeeklyStats = AccessWeeklyStats - 1
    else
        UpdateDisabled = true
        SKIN:Bang('!SetOption', 'weeklyStat', 'UpdateDivider', '#GlobalUpdateDivider#')

        SKIN:Bang('!SetOption', 'FetchDayOneData', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'FetchDayTwoData', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'FetchDayThreeData', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'FetchDayFourData', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'FetchDayFiveData', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'FetchDaySixData', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'FetchDaySevenData', 'UpdateDivider', '#GlobalUpdateDivider#')

        SKIN:Bang('!SetOption', 'DayOneDate', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'DayTwoDate', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'DayThreeDate', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'DayFourDate', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'DayFiveDate', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'DaySixDate', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'DaySevenDate', 'UpdateDivider', '#GlobalUpdateDivider#')

        SKIN:Bang('!SetOption', 'DayOneLongDate', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'DayTwoLongDate', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'DayThreeLongDate', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'DayFourLongDate', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'DayFiveLongDate', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'DaySixLongDate', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'DaySevenLongDate', 'UpdateDivider', '#GlobalUpdateDivider#')

        SKIN:Bang('!SetOption', 'DayOneInfoLegend', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'DayTwoInfoLegend', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'DayThreeInfoLegend', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'DayFourInfoLegend', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'DayFiveInfoLegend', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'DaySixInfoLegend', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'DaySevenInfoLegend', 'UpdateDivider', '#GlobalUpdateDivider#')

        SKIN:Bang('!SetOption', 'DayOneInfoLegendContent', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'DayTwoInfoLegendContent', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'DayThreeInfoLegendContent', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'DayFourInfoLegendContent', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'DayFiveInfoLegendContent', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'DaySixInfoLegendContent', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'DaySevenInfoLegendContent', 'UpdateDivider', '#GlobalUpdateDivider#')

        SKIN:Bang('!SetOption', 'DayOneInfoBarGradient', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'DayTwoInfoBarGradient', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'DayThreeInfoBarGradient', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'DayFourInfoBarGradient', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'DayFiveInfoBarGradient', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'DaySixInfoBarGradient', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'DaySevenInfoBarGradient', 'UpdateDivider', '#GlobalUpdateDivider#')

        SKIN:Bang('!SetOption', 'DayOneBar', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'DayTwoBar', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'DayThreeBar', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'DayFourBar', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'DayFiveBar', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'DaySixBar', 'UpdateDivider', '#GlobalUpdateDivider#')
        SKIN:Bang('!SetOption', 'DaySevenBar', 'UpdateDivider', '#GlobalUpdateDivider#')
    end
end

function GetURL(baseURL, APIKey, offset)
    local today = os.time()
    local fetch_day = tostring(os.date("%Y-%m-%d", today - (offset*24*60*60)))

    return baseURL.."?api_key="..APIKey.."&date="..fetch_day
end

function GetQuotedURL(baseURL, APIKey, offset)
    return '"'..GetURL(baseURL, APIKey, offset)..'"'
end

function LoadProjectsColors()
    local data = {}
    local pcifs = io.open(CurrentPath.."..\\data\\weekly\\projects_colors.json", "r") -- project colors input file stream
    if pcifs ~= nil then
        data = pcifs:read("*all")
        io.close(pcifs)
        return JSON:decode(data)
    end

    return {}
end

function GetWeeklyResults(...)
    local status, result = pcall(function ()
        local projects = {} -- for accessing all projects during the elapsed week
        local best_day = .0 -- for computing the highest week duration
    
        -- fetch and save previous week data from today (7 days offset)
        local last_week_data = {}
    
        for offset, day_data in ipairs(arg) do
            local data = Wakatime.DayResume(day_data, offset - 1, JSON, Wutils)
            last_week_data[offset] = data
    
            -- accessing projects and duration
            local day_duration = 0
            for project, duration in pairs(data['projects']) do
                projects[project] = true
                day_duration = day_duration + duration
            end
    
            if day_duration > best_day then
                best_day = day_duration
            end
        end
    
        last_week_data['best_day'] = best_day
        last_week_data['projects'] = projects
        local encoded = JSON:encode_pretty(last_week_data, nil, {pretty = true, align_keys = false,
                                  array_newline = true, indent = ""})
    
        return encoded
    end)

    if status then
        return result
    else
        return "{}"
    end
end

function UpdateProjectsColors(projects)
    local lpc_data = LoadProjectsColors() -- loaded last saved projects colors data

    -- load already assigned colors
    local ass_colors = {}
    for _, color in pairs(lpc_data) do
        local is_new = true
        for i = 1, #ass_colors, 1 do
            if color == ass_colors[i] then
                is_new = false
                break
            end
        end

        if is_new then
            table.insert(ass_colors, color)
        end
    end

    -- add new projects colors
    for project, _ in pairs(projects) do
        local is_new = true
        for fproject, _ in pairs(lpc_data) do
            if project == fproject then
                is_new = false
                break
            end
        end

        if is_new then -- if new project found, assign a new color 
            local to_insert = Wutils.RandomColor(ass_colors)
            lpc_data[project] = to_insert
            table.insert(ass_colors, to_insert)
        end
    end

    local enc = JSON:encode_pretty(lpc_data, nil, {pretty = true, align_keys = false, 
                                                   array_newline = true, indent = "    "})

    -- save it 
    local pcofs = io.open(CurrentPath.."..\\data\\weekly\\projects_colors.json", "w+") -- project colors output file stream
    if pcofs ~= nil then
        pcofs:write(enc)
        io.close(pcofs)
    end

    return enc
end

function GetBarHeight(day, max_bar_height, weekly_data)
    if type(weekly_data) == "number" or weekly_data == "0" then
        return "0"
    end

    local status, result = pcall(function ()
        local enc_weekly_data = JSON:decode(weekly_data)
        if tonumber(enc_weekly_data['best_day']) == 0 then
            return "0"
        end
    
        local result = (tonumber(enc_weekly_data[tostring(day)]['total_duration']) / tonumber(enc_weekly_data['best_day'])) * tonumber(max_bar_height)
        return tostring(result)
    end)

    if status then
        return result
    else
        return "0"
    end
end

function GetDate(day, weekly_data)
    if type(weekly_data) == "number" or weekly_data == "0" then
        return "xxx xth"
    end

    local status, result = pcall(function ()
        local enc_weekly_data = JSON:decode(weekly_data)
        local result = enc_weekly_data[tostring(day)]['print_date']
        return result
    end)

    if status then
        return result
    else
        return "xxx th"
    end
end

function GetLongDate(day, weekly_data)
    if type(weekly_data) == "number" or weekly_data == "0" then
        return "xxx xth xxxx"
    end

    local status, result = pcall(function ()
        local enc_weekly_data = JSON:decode(weekly_data)
        local result = enc_weekly_data[tostring(day)]['print_date_year']
        return result
    end)

    if status then
        return result
    else
        return "xxx xth xxxx"
    end
end

function GetCurvePath(x0, y0, x1, y1, x2, y2, x3, y3, x4, y4, x5, y5, x6, y6)
    local xc1p1, yc1p1, xc1p2, yc1p2, c1t1, c1t2 = Wmath.BezierInterpolation(tonumber(x0), tonumber(y0), tonumber(x1), tonumber(y1), tonumber(x2), tonumber(y2), tonumber(x3), tonumber(y3))
    local xc2p1, yc2p1, xc2p2, yc2p2, c2t1, c2t2 = Wmath.BezierInterpolation(tonumber(x3), tonumber(y3), tonumber(x4), tonumber(y4), tonumber(x5), tonumber(y5), tonumber(x6), tonumber(y6))

    local curvature1 = Wmath.CubicBezierCurvature(x0, y0, xc1p1, yc1p1, xc1p2, yc1p2, x3, y3, c1t2)
    local curvature2 = Wmath.CubicBezierCurvature(x3, y3, xc2p1, yc2p1, xc2p2, yc2p2, x6, y6, c2t1)

    -- force C1-continuity of the bézier curve by modifying control point offset the most 'curvy' 
    if (curvature1 > curvature2) then -- modify the second control point of the first curve
        return  x0..','..y0..' | CurveTo '..x3..','..y3..','..xc1p1..','..yc1p1..','..xc1p2..','..yc1p2..' | CurveTo '..x6..','..y6..','..xc2p1..','..yc2p1..','..xc2p2..','..yc2p2
    else -- modify the first control point of the second curve
        return  x0..','..y0..' | CurveTo '..x3..','..y3..','..xc1p1..','..yc1p1..','..xc1p2..','..yc1p2..' | CurveTo '..x6..','..y6..','..xc2p1..','..yc2p1..','..xc2p2..','..yc2p2
    end
end

function GetInfoBarGradientColor(day, weekly_data)
    if type(weekly_data) == "number" or weekly_data == "0" then
        return "180 | 0,0,255,0 ; 0.0 | 255,0,0,0 ; 1.0"
    end

    local status, result = pcall(function ()
        local enc_weekly_data = JSON:decode(weekly_data)
        if tonumber(enc_weekly_data['total_duration']) == 0 then
            return "180 | 0,0,255,0 ; 0.0 | 255,0,0,0 ; 1.0"
        end
    
        local result = "180 | "
        local projects = enc_weekly_data[tostring(day)]['projects']
        -- update projects colors 
        UpdateProjectsColors(projects)
    
        local projects_colors = LoadProjectsColors()
        local total_duration = enc_weekly_data[tostring(day)]['total_duration']
    
        local percent = .0
        for project, color in pairs(projects_colors) do
            if projects[project] ~= nil then
                result = result..color.." ; "..percent.." | "
                percent = percent + (projects[project]/total_duration)
                result = result..color.." ; "..percent.." | "
            end
        end
    
        return result
    end)

    if status then
        return result
    else
        return "180 | 0,0,255,0 ; 0.0 | 255,0,0,0 ; 1.0"
    end
end

function GetLegend(day, weekly_data, measure_name)
    if type(weekly_data) == "number" or weekly_data == "0" then
        return ""
    end

    local status, result = pcall(function ()
        local enc_weekly_data = JSON:decode(weekly_data)
        local projects = enc_weekly_data[tostring(day)]['projects']
        UpdateProjectsColors(projects)
        local projects_colors = LoadProjectsColors()
    
        local legend_str="\n"
        for project, _ in pairs(projects) do
            legend_str = legend_str..'[\\x26AB]\n\n'
        end
    
        local iter = 1
        for project, color in pairs(projects_colors) do
            if projects[project] ~= nil then
                if iter == 1 then
                    SKIN:Bang('!SetOption', measure_name, 'InlinePattern', '^\n[\\x26AB]')
                    SKIN:Bang('!SetOption', measure_name, 'InlineSetting', 'Color | '..color)
                elseif iter == 2 then
                    SKIN:Bang('!SetOption', measure_name, 'InlinePattern'..iter, '\n[\\x26AB]\\K\n\n[\\x26AB]')
                    SKIN:Bang('!SetOption', measure_name, 'InlineSetting'..iter, 'Color | '..color)
                elseif iter == 3 then
                    SKIN:Bang('!SetOption', measure_name, 'InlinePattern'..iter, '\n[\\x26AB]\\K\n\n[\\x26AB]\\K\n\n[\\x26AB]')
                    SKIN:Bang('!SetOption', measure_name, 'InlineSetting'..iter, 'Color | '..color)
                end
    
                iter = iter + 1
            end
        end
    
        return legend_str
    end)

    if status then
        return result
    else
        return ''
    end
end

function SpaceAfter(str, chr, count)
    local len = string.len(str)
    if len < count then
        for i = len, count, 1 do
            str = str..chr
        end
    end

    return str
end

function GetLegendContent(day, weekly_data)
    if type(weekly_data) == "number" or weekly_data == "0" then
        return ""
    end

    local status, result = pcall(function ()
        local enc_weekly_data = JSON:decode(weekly_data)
        local projects = enc_weekly_data[tostring(day)]['print_projects']
    
        local legend_str="\n"
        for project, print_time in pairs(projects) do
            legend_str = legend_str.." "..project..' : '..print_time..'\n\n'
        end
    
        return legend_str
    end)

    if status then
        return result
    else 
        return ""
    end
end