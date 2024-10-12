local playerCommands = {
    show = function(commandName, playerid,  args, argc, silent)
        GenerateQuakeMenu(commandName, playerid)
    end,

    toggle = function(commandName, playerid,  args, argc, silent)
        local player = GetPlayer(playerid)
        if not player or not player:IsValid() then return end
        local cookieName = "qsounds."..args[2]
        local cookieValue = exports["cookies"]:GetPlayerCookie(playerid, cookieName)
        if cookieValue == nil or not cookieName then return end

        exports["cookies"]:SetPlayerCookie(playerid, cookieName, not cookieValue)
        GenerateQuakeMenu(commandName, playerid)
    end
}


local commandNames = config:Fetch('qsounds.command_aliases')
for i = 1,  #commandNames do
    commands:Register(commandNames[i], function(playerid, args, argc, silent, prefix)
        if playerid < 0 then return end

        if argc < 1 then
            playerCommands["show"](commandNames[i], playerid, args, argc, silent)
        end

        local option = args[1]

        if not playerCommands[option] then return end

        return playerCommands[option](commandNames[i], playerid, args, argc, silent)
    end)
end

