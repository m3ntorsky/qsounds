
PlaySoundFromEvent = function(player, soundEvent)
    if not soundEvent or type(soundEvent) ~= "table" then return end
    if not soundEvent.type then return end
    if not player or not player:IsValid() then return end
    switch(soundEvent.type, {
        ["sound"] = function() player:ExecuteCommand("play ".. soundEvent.path) end,
        ["soundevent"] = function() CBaseEntity(player:CCSPlayerController():ToPtr()):EmitSound(soundEvent.name, 100, 1.0) end
    })
end

--- Simulates a 'switch' statement, allowing for both strings and numbers.
--- Supports an optional default case.
--- @param value any The value to be matched against. Can be a number or a string.
--- @param cases table A table of cases to compare against. The keys represent the possible values of 'value',
---                    and the values are functions to execute or direct values to return.
---                    An optional 'default' key will be used if 'value' doesn't match any other key.
--- @return any Returns the result of the matched case, or the default if no match is found.
switch = function(value, cases)
    local case = cases[value]
    if case then
        if type(case) == "function" then
            return case()
        else
            return case
        end
    elseif cases.default then
        if type(cases.default) == "function" then
            return cases.default()
        else
            return cases.default
        end
    end
end
