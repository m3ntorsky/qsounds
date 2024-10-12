local RoundStats = {
    wasFirstblood = false,
    kills = {},
}

AddEventHandler("OnPlayerHurt", function(event)
    if config:Fetch("qsounds.enable_on_warmup") and GetCCSGameRules().WarmupPeriod then return EventResult.Continue end
    local attacker = GetPlayer(event:GetInt("attacker"))
    local victim = GetPlayer(event:GetInt("userid"))
    if not attacker or not attacker:IsValid() or not victim or not victim:IsValid() or not exports["cookies"]:GetPlayerCookie(attacker:GetSlot(), "qsounds.quake") then return EventResult.Continue end
    local hitgroup = event:GetInt("hitgroup")

    if attacker:GetSlot() == victim:GetSlot() then
        -- self hurt
        return EventResult.Continue
    end

    switch(hitgroup, {
        [HitGroup_t.HITGROUP_HEAD] = function()
            local eventSound = config:Fetch("qsounds.events.hithead")
            local cookieValue = exports["cookies"]:GetPlayerCookie(attacker:GetSlot(), "qsounds.hithead")
            if cookieValue and type(eventSound) == "table" then
                PlaySoundFromEvent(attacker, eventSound)
            end
        end,
        default = function()
            local eventSound = config:Fetch("qsounds.events.hit")
            local cookieValue = exports["cookies"]:GetPlayerCookie(attacker:GetSlot(), "qsounds.hit")
            if cookieValue and type(eventSound) == "table" then
                PlaySoundFromEvent(attacker, eventSound)
            end
        end,
    })
end)

AddEventHandler("OnRoundStart", function (event)
    if config:Fetch("qsounds.enable_on_warmup") and GetCCSGameRules().WarmupPeriod then return EventResult.Continue end

    if config:Fetch("qsounds.count_per_round") then
        RoundStats.wasFirstblood = false
        for i = 0, playermanager:GetPlayerCap() -1 do
            local player = GetPlayer(i)
            if not player or not player:IsValid() then goto continue end
            RoundStats.kills[i] = 0
            ::continue::       
        end
    end

    local soundEvent = config:Fetch("qsounds.events.game_event:OnRoundStart")
    if soundEvent then
        for i = 0, playermanager:GetPlayerCap() - 1 do
            local player = GetPlayer(i)
            if not player or not player:IsValid() or not exports["cookies"]:GetPlayerCookie(player:GetSlot(), "qsounds.quake") then goto continue end
            PlaySoundFromEvent(player, soundEvent)
            ::continue::
        end
    end
end)

AddEventHandler("OnPlayerSpawn", function(event)
    if config:Fetch("qsounds.enable_on_warmup") and GetCCSGameRules().WarmupPeriod then return EventResult.Continue end
    local playerid = event:GetInt("userid")
    local player = GetPlayer(playerid)
    if not player or not player:IsValid() then return EventResult.Continue end

    local soundEvent = config:Fetch("qsounds.events.game_event:OnPlayerSpawn")
    if soundEvent and exports["cookies"]:GetPlayerCookie(player:GetSlot(), "qsounds.quake") then
        PlaySoundFromEvent(player, soundEvent)
    end

    return EventResult.Continue
end)



AddEventHandler("OnPostPlayerDeath", function(event)
    if config:Fetch("qsounds.enable_on_warmup") and GetCCSGameRules().WarmupPeriod then return EventResult.Continue end
    local attacker = GetPlayer(event:GetInt("attacker"))
    local victim = GetPlayer(event:GetInt("userid"))
    if not attacker or not attacker:IsValid() or not victim or not victim:IsValid() or not exports["cookies"]:GetPlayerCookie(attacker:GetSlot(), "qsounds.quake") then return EventResult.Continue end
    if attacker:GetSlot() == victim:GetSlot() then return end

    local soundEvents = config:Fetch("qsounds.events")

    RoundStats.kills[attacker:GetSlot()] = (RoundStats.kills[attacker:GetSlot()] or 0) + 1

    local lastSoundEvent = nil

    local conditions = {
        {
            condition = function()
                if soundEvents["firstblood"] and not RoundStats.wasFirstblood then
                    RoundStats.wasFirstblood = true
                    return true, soundEvents["firstblood"], attacker
                end
                return false
            end
        },
        {
            condition = function()
                local soundName = "kill:" .. RoundStats.kills[attacker:GetSlot()]
                if RoundStats.wasFirstblood and RoundStats.kills[attacker:GetSlot()] > 0 and soundEvents[soundName] then
                    return true, soundEvents[soundName], attacker
                end
                return false
            end
        },
        {
            condition = function()
                if RoundStats.wasFirstblood and soundEvents["kills"] and not event:GetBool("headshot") then
                    return true, soundEvents["kills"], attacker
                end
                return false
            end
        },
        {
            condition = function()
                if RoundStats.wasFirstblood and soundEvents["kill:headshot"] and event:GetBool("headshot") then
                    return true, soundEvents["kill:headshot"], attacker
                end
                return false
            end
        },
    }

    for _, cond in next, conditions do
        local conditionResult, event, target = cond.condition()
        if conditionResult then
            lastSoundEvent = { event = event, target = target }
            break
        end
    end

    if lastSoundEvent then
        return PlaySoundFromEvent(lastSoundEvent.target, lastSoundEvent.event)
    end
end)

AddEventHandler("OnRoundEnd", function(event)
    if config:Fetch("qsounds.enable_on_warmup") and GetCCSGameRules().WarmupPeriod then return EventResult.Continue end
    local soundEvent = config:Fetch("qsounds.events.game_event:OnPlayerSpawn")
    if soundEvent then
        for i = 0, playermanager:GetPlayerCap() - 1 do
            local player = GetPlayer(i)
            if not player or not player:IsValid() or not exports["cookies"]:GetPlayerCookie(player:GetSlot(), "qsounds.quake") then goto continue end
            PlaySoundFromEvent(player, soundEvent)
            ::continue::
        end
    end
end)


AddEventHandler("OnRoundFreezeEnd", function(event --[[ Event ]])
    if config:Fetch("qsounds.enable_on_warmup") and GetCCSGameRules().WarmupPeriod then return EventResult.Continue end
    local soundEvent = config:Fetch("qsounds.events.game_event:OnRoundFreezeEnd")
    if soundEvent then
        for i = 0, playermanager:GetPlayerCap() - 1 do
            local player = GetPlayer(i)
            if not player or not player:IsValid() or not exports["cookies"]:GetPlayerCookie(player:GetSlot(), "qsounds.quake") then goto continue end
            PlaySoundFromEvent(player, soundEvent)
            ::continue::
        end
    end
    return EventResult.Continue
end)
