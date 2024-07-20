Wakatime = {}

function Wakatime.ProcessDayData(data, JSON)
    local lua_value = JSON:decode(data)

    if lua_value ~= nil then
        -- first build the results list
        local res_map = {}
        for i = 1, #lua_value.data, 1 do
            res_map[lua_value.data[i]['project']] = 0
        end

        -- then agregate durations
        for i = 1, #lua_value.data, 1 do
            res_map[lua_value.data[i]['project']] = res_map[lua_value.data[i]['project']] + lua_value.data[i]['duration']
        end

        return res_map

    else
        return {}
    end
end

function Wakatime.DayResume(dayData, offset, JSON, Wutils)
    -- get the day within we'll fetch the wakatime stats    
    local today = os.time()
    local fetch_day = tostring(os.date("%Y-%m-%d", today - (offset*24*60*60)))

    --prcess fetched datas
    local processed_data = Wakatime.ProcessDayData(dayData, JSON)

    -- create printable version of processed data
    local projects_count = 0
    local printable_data = {}
    for project, duration in pairs(processed_data) do
        local hours = math.floor(duration / 3600)
        local minutes = math.floor((duration - (hours*3600)) / 60)
        printable_data[project] = hours.."h "..minutes.." min"

        projects_count = projects_count + 1
    end

    local data = {}
    data['projects'] = processed_data
    data['print_projects'] = printable_data

    -- add number of projects
    data['projects_count'] = projects_count

    -- add total duration to output
    local total_duration = 0
    for _, duration in pairs(processed_data) do
        total_duration = total_duration + duration
    end
    local total_hours = math.floor(total_duration/3600)
    local total_minutes = math.floor((total_duration - (total_hours*3600)) / 60)
    data['total_duration'] = total_duration
    data['print_total_duration'] = total_hours .. "h " .. total_minutes .. " min"

    -- add dates to output
    data['date'] = fetch_day
    data['print_date'] = Wutils.FormatDate(tonumber(string.sub(fetch_day, -2)), tonumber(string.sub(fetch_day, 6, 7)))
    data['print_date_year'] = Wutils.FormatLongDate(tonumber(string.sub(fetch_day, -2)), tonumber(string.sub(fetch_day, 6, 7))) .." "..string.sub(fetch_day, 1, 4)

    return data
end


return Wakatime