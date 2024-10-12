GenerateQuakeMenu = function(commandName, playerid)
    local player = GetPlayer(playerid)
    if not player or not player:IsValid() then return end
    local menu = config:Fetch("qsounds.menu")

    local options = {}

    for key, value in next, menu.options do
        if value then
            local playerCookie = exports["cookies"]:GetPlayerCookie(playerid, "qsounds.".. key) or nil
            local command = "sw_" .. commandName .. " toggle " .. key
            local display = switch(playerCookie, {
                [true] = FetchTranslation("qsounds.menu.option."..key, playerid).. ": " .. FetchTranslation("qsounds.menu.on", playerid),
                default = FetchTranslation("qsounds.menu.option." .. key, playerid) .. ": " .. FetchTranslation("qsounds.menu.off", playerid)
            })
            table.insert(options, { display , command})
        end 
    end

    local menuId = commandName.."_"..os.clock()

    menus:RegisterTemporary(menuId, tostring(FetchTranslation("qsounds.menu.title", playerid)), menu.color, options)
    player:HideMenu()
    player:ShowMenu(menuId)
end