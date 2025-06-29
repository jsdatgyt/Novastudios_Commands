RegisterNetEvent("spawnCar")
AddEventHandler("spawnCar", function(model)
    local playerPed = PlayerPedId()
    local vehicleHash = GetHashKey(model)
    RequestModel(vehicleHash)
    while not HasModelLoaded(vehicleHash) do
        Citizen.Wait(0)
    end
    local coords = GetEntityCoords(playerPed)
    local vehicle = CreateVehicle(vehicleHash, coords.x, coords.y, coords.z, GetEntityHeading(playerPed), true, false)
    SetPedIntoVehicle(playerPed, vehicle, -1)
    SetModelAsNoLongerNeeded(vehicleHash)
end)

RegisterNetEvent("fixVehicle")
AddEventHandler("fixVehicle", function()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    if vehicle and vehicle ~= 0 then
        SetVehicleFixed(vehicle)
        SetVehicleDeformationFixed(vehicle)
        SetVehicleUndriveable(vehicle, false)
        SetVehicleEngineOn(vehicle, true, true)
    else
        TriggerEvent("chat:addMessage", { args = {"^1[ERROR]", "You must be in a vehicle to fix it."} })
    end
end)

RegisterNetEvent("revivePlayer")
AddEventHandler("revivePlayer", function()
    local playerPed = PlayerPedId()
    if IsPedDeadOrDying(playerPed, 1) then
        NetworkResurrectLocalPlayer(GetEntityCoords(playerPed), true, true, false)
        ClearPedBloodDamage(playerPed)
        TriggerEvent("chat:addMessage", { args = {"^2[SYSTEM]", "You have been revived."} })
    end
end)

RegisterNetEvent("deleteVehicle")
AddEventHandler("deleteVehicle", function()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    if vehicle and vehicle ~= 0 then
        SetEntityAsMissionEntity(vehicle, true, true)
        DeleteVehicle(vehicle)
    else
        TriggerEvent("chat:addMessage", { args = {"^1[ERROR]", "You must be in a vehicle to delete it."} })
    end
end)

RegisterNetEvent("healPlayer")
AddEventHandler("healPlayer", function()
    local playerPed = PlayerPedId()
    SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
    ClearPedBloodDamage(playerPed)
    ResetPedVisibleDamage(playerPed)
    TriggerEvent("chat:addMessage", { args = {"^2[SYSTEM]", "You have been healed."} })
end)

RegisterNetEvent("clearPlayerChat")
AddEventHandler("clearPlayerChat", function()
    TriggerEvent("chat:clear")
end)

RegisterNetEvent("killPlayer")
AddEventHandler("killPlayer", function()
    local playerPed = PlayerPedId()
    SetEntityHealth(playerPed, 0)
end)

RegisterNetEvent("getCoords")
AddEventHandler("getCoords", function()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    TriggerEvent("chat:addMessage", { args = {"^2[COORDS]", string.format("X: %.2f, Y: %.2f, Z: %.2f", coords.x, coords.y, coords.z)} })
end)

RegisterNetEvent("showMeText")
AddEventHandler("showMeText", function(sourceId, msg)
    local srcPed = GetPlayerFromServerId(sourceId)
    if srcPed ~= -1 then
        local ped = GetPlayerPed(srcPed)
        local coords = GetEntityCoords(ped)
        -- Simple chat message for now; you can implement 3D text here
        TriggerEvent("chat:addMessage", { args = { "^6* " .. msg } })
    end
end)

RegisterNetEvent("showDoText")
AddEventHandler("showDoText", function(sourceId, msg)
    local srcPed = GetPlayerFromServerId(sourceId)
    if srcPed ~= -1 then
        local ped = GetPlayerPed(srcPed)
        local coords = GetEntityCoords(ped)
        TriggerEvent("chat:addMessage", { args = { "^5* " .. msg } })
    end
end)

RegisterNetEvent("showTweet")
AddEventHandler("showTweet", function(name, msg)
    TriggerEvent("chat:addMessage", {
        args = { "^5[TWITTER] ^3@" .. name, msg }
    })
end)

RegisterNetEvent("showOOC")
AddEventHandler("showOOC", function(name, msg)
    TriggerEvent("chat:addMessage", {
        args = { "^8[OOC] " .. name, msg }
    })
end)
