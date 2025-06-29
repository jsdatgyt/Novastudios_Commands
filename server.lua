local webhook = 'https://discord.com/api/webhooks/YOUR_WEBHOOK_URL_HERE'

function sendToDiscord(title, message, color)
    local embed = {{
        ["title"] = title,
        ["description"] = message,
        ["color"] = color or 16753920,
        ["footer"] = { ["text"] = "FiveM Logs" }
    }}

    PerformHttpRequest(webhook, function() end, 'POST', json.encode({
        username = 'Server Logger',
        embeds = embed
    }), { ['Content-Type'] = 'application/json' })
end

RegisterCommand("car", function(src, args)
    local model = args[1]
    if not model then return TriggerClientEvent("chat:addMessage", src, { args = {"^1[ERROR]", "Usage: /car [model]"} }) end
    TriggerClientEvent("spawnCar", src, model)
    sendToDiscord("Vehicle Spawned", ("**%s** spawned a `%s`"):format(GetPlayerName(src), model), 3145658)
end)

RegisterCommand("fix", function(src)
    TriggerClientEvent("fixVehicle", src)
    sendToDiscord("Vehicle Fixed", ("**%s** used /fix"):format(GetPlayerName(src)), 65280)
end)

RegisterCommand("revive", function(src)
    TriggerClientEvent("revivePlayer", src)
    sendToDiscord("Player Revived", ("**%s** used /revive"):format(GetPlayerName(src)), 16711935)
end)

RegisterCommand("dv", function(src)
    TriggerClientEvent("deleteVehicle", src)
    sendToDiscord("Vehicle Deleted", ("**%s** used /dv"):format(GetPlayerName(src)), 11141120)
end)

RegisterCommand("heal", function(src)
    TriggerClientEvent("healPlayer", src)
    sendToDiscord("Player Healed", ("**%s** used /heal"):format(GetPlayerName(src)), 255)
end)

RegisterCommand("clearchat", function(src)
    if IsPlayerAceAllowed(src, "command.clearchat") then
        TriggerClientEvent("clearPlayerChat", src)
        sendToDiscord("Chat Cleared", ("**%s** used /clearchat"):format(GetPlayerName(src)), 1234567)
    else
        TriggerClientEvent("chat:addMessage", src, { args = {"^1[ERROR]", "You are not allowed to use this command."} })
    end
end)

RegisterCommand("kill", function(src)
    TriggerClientEvent("killPlayer", src)
    sendToDiscord("Player Killed Self", ("**%s** used /kill"):format(GetPlayerName(src)), 16711680)
end)

RegisterCommand("coords", function(src)
    TriggerClientEvent("getCoords", src)
    sendToDiscord("Requested Coords", ("**%s** used /coords"):format(GetPlayerName(src)), 8421504)
end)

RegisterCommand("id", function(src)
    TriggerClientEvent("chat:addMessage", src, { args = {"^2[ID]", "Your ID is: " .. tostring(src)} })
end)

RegisterCommand("time", function(src)
    local hour = GetClockHours()
    local minute = GetClockMinutes()
    TriggerClientEvent("chat:addMessage", src, {
        args = {"^2[TIME]", string.format("In-game time is %02d:%02d", hour, minute)}
    })
end)

RegisterCommand("me", function(src, args)
    local text = table.concat(args, " ")
    if text ~= "" then
        TriggerClientEvent("showMeText", -1, src, text)
        sendToDiscord("/me Used", ("**%s**: %s"):format(GetPlayerName(src), text), 13500000)
    end
end)

RegisterCommand("do", function(src, args)
    local text = table.concat(args, " ")
    if text ~= "" then
        TriggerClientEvent("showDoText", -1, src, text)
        sendToDiscord("/do Used", ("**%s**: %s"):format(GetPlayerName(src), text), 65280)
    end
end)

RegisterCommand("tweet", function(src, args)
    local msg = table.concat(args, " ")
    if msg ~= "" then
        local name = GetPlayerName(src)
        TriggerClientEvent("showTweet", -1, name, msg)
        sendToDiscord("Tweet", ("**%s** tweeted: %s"):format(name, msg), 3447003)
    end
end)

RegisterCommand("ooc", function(src, args)
    local msg = table.concat(args, " ")
    if msg ~= "" then
        local name = GetPlayerName(src)
        TriggerClientEvent("showOOC", -1, name, msg)
        sendToDiscord("OOC", ("**%s** (OOC): %s"):format(name, msg), 10038562)
    end
end)
