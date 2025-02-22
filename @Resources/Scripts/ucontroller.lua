--[[ Summarize : 
    Tries to open the user data file (user.json).
        If the file does not exist, it triggers the FetchUserInfoData measure to fetch the user info.
        If the file exists, it reads and parses the user data.
            If the parsed data contains errors, wait for an external refresh, this may typically occurs when the APIKey is either not set or incorrect
            Tries to open the profile picture file (profile.png).
                If the profile picture file does not exist:
                Checks if the ProfilePictureURL variable is empty.
                    If empty, it writes the country code and profile picture URL to the skin variables and refreshes the skin.
                    If not empty, it triggers the FetchUserProfilePicture measure.
                If the profile picture file exists, it triggers the measures to fetch global and country leaderboard data, updates the skin, and closes the profile picture file.
    ]]
function Initialize()
    -- external Lua scripts
    Wutils = dofile(SKIN:GetVariable('@')..'Scripts\\wutils.lua')
    JSON = dofile(SKIN:GetVariable('@')..'Scripts\\externals\\JSON.lua')

    CurrentPath = SKIN:GetVariable('CURRENTPATH')
    UserDatas, GlobalLeaderboard, CountryLeaderboard  = nil, nil, nil

    -- Try to open the user data file
    local fp = io.open(CurrentPath..'\\..\\data\\user\\user.json', "r")
    if fp == nil then -- If the file doesn't exist, fetch the user info data
        SKIN:Bang("!CommandMeasure", "FetchUserInfoData", "Run")
    else
        -- Parse the user data from the file
        UserDatas = JSON:decode(fp:read("*all"))
        
        if UserDatas == {} or UserDatas == nil or UserDatas['errors'] ~= nil then  -- Check for errors in the fetched data
            io.close(fp)
            return
        end
        
        -- Try to open the profile picture file
        local fp2 = io.open(CurrentPath..'\\..\\data\\user\\profile.png', "rb")
        if fp2 == nil then
            -- If profile picture URL is empty in rainmeter(or var doesn't exists), write it and refresh
            if SKIN:GetVariable("ProfilePictureURL", "") == "" then
                SKIN:Bang("!WriteKeyValue", "Variables", "UserCoutryCode", UserDatas['data']['city']['country_code'], "#@#Include\\UserSkinVars.inc")
                SKIN:Bang("!WriteKeyValue", "Variables", "ProfilePictureURL", UserDatas['data']['photo'], "#@#Include\\UserSkinVars.inc")
                SKIN:Bang("!Refresh")
            else -- now the profile picture URL exists, then it  
                SKIN:Bang("!CommandMeasure", "FetchUserProfilePicture", "Run")
            end 
        else 
            -- Fetch leaderboard data (global and country) and update the skin 
            SKIN:Bang("!CommandMeasure", "FetchGlobalLeaderboard", "Run")
            SKIN:Bang("!CommandMeasure", "FetchCountryLeaderboard", "Run")
            SKIN:Bang("!Update")
            io.close(fp2)
        end
        io.close(fp)
    end
end

-- Process the global leaderboard rank(should normally be called as Finished action of FetchGlobalLeaderboard measure)
function ProcessGlobalLeaderboardRank()
    GlobalLeaderboard = JSON:decode(SKIN:GetMeasure('FetchGlobalLeaderboard'):GetStringValue())
end

-- Process the country leaderboard rank(should normally be called as Finished action of FetchCountryLeaderboard measure)
function ProcessCountryLeaderboardRank()
    CountryLeaderboard = JSON:decode(SKIN:GetMeasure('FetchCountryLeaderboard'):GetStringValue())
end

function GetFullname()
    local status, result = pcall( function ()
        return UserDatas['data']['full_name']
    end)

    if status then
        return result
    else
        return ""
    end
end

function GetUsername()
    local status, result = pcall( function ()
        return UserDatas['data']['username']
    end)

    if status then
        return result
    else
        return ""
    end
end

function GetEmail()
    local status, result = pcall( function ()
        return UserDatas['data']['email']
    end)

    if status then
        return result
    else
        return ""
    end
end

function GetCity()
    local status, result = pcall( function ()
        return UserDatas['data']['city']['title']
    end)

    if status then
        return result
    else
        return ""
    end
end

function GetGlobalLeaderboardRank()
    local status, result = pcall(function()
        return Wutils.OrdinalSuffix(tonumber(GlobalLeaderboard['current_user']['rank']))
    end)

    if status then
        return result
    else
        return "-ˣˣ"
    end
end

function GetCountryLeaderboardRank()
    local status, result = pcall(function()
        return Wutils.OrdinalSuffix(tonumber(CountryLeaderboard['current_user']['rank']))
    end)

    if status then
        return result
    else
        return "-ˣˣ"
    end
end

function GetCurrentStreak()
    local status, result = pcall(function()
        local username = GetUsername()
        for _, user_data in ipairs(CountryLeaderboard['data']) do
            if user_data['user']['username'] == username then
                local total = user_data['running_total']['human_readable_total']
                return string.gsub(string.gsub(total, " hrs", "h"), " mins", "m")
            end
        end

        return "xh xxm"
    end)

    if status then
        return result
    else
        return "xh xxm"
    end
end