-- ! eventname (workshop doesnt work)

AddEventHandler("OnPluginStart", function (event)
    config:Reload("qsounds")

    local soundsList = config:Fetch("qsounds.list")

    if not soundsList or type(soundsList) ~= "table" then
        return print("{darkred}Cannot parse list of sounds. Check your config.{default}")
    end

    for i =1 , #soundsList do
        precacher:PrecacheSound(soundsList[i])
    end
    print("Successfuly loaded {green}".. #soundsList .. "sounds{default}")

end)

AddEventHandler("OnAllPluginsLoaded", function (event)
    if GetPluginState("cookies") == PluginState_t.Stopped then return EventResult.Continue end

    for key, value in next, config:Fetch("qsounds.menu.options") do
        exports["cookies"]:RegisterCookie("qsounds.".. key, value)
    end
end)
