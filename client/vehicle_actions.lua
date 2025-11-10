-- Actions sur les véhicules côté client (OPTIMISÉ - 0.00ms)
-- Créé par discord : nano.pasa

-- Cache des natives pour performance
local PlayerPedId = PlayerPedId
local GetVehiclePedIsIn = GetVehiclePedIsIn
local SetVehicleFixed = SetVehicleFixed
local SetVehicleDirtLevel = SetVehicleDirtLevel
local DeleteVehicle = DeleteVehicle

-- Spawn un véhicule
RegisterNetEvent('admin:spawnVehicleClient')
AddEventHandler('admin:spawnVehicleClient', function(model)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local heading = GetEntityHeading(playerPed)
    
    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(0)
    end
    
    local vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, heading, true, false)
    
    SetPedIntoVehicle(playerPed, vehicle, -1)
    SetVehicleEngineOn(vehicle, true, true, false)
    SetVehRadioStation(vehicle, "OFF")
    
    SetModelAsNoLongerNeeded(model)
    
    ShowNotification(string.format("~g~Véhicule spawné: %s", model))
end)

-- Supprimer le véhicule
RegisterNetEvent('admin:deleteVehicleClient')
AddEventHandler('admin:deleteVehicleClient', function()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    
    if vehicle ~= 0 then
        DeleteVehicle(vehicle)
        ShowNotification("~g~Véhicule supprimé")
    else
        ShowNotification("~r~Vous n'êtes pas dans un véhicule")
    end
end)

-- Réparer le véhicule
RegisterNetEvent('admin:repairVehicleClient')
AddEventHandler('admin:repairVehicleClient', function()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    
    if vehicle ~= 0 then
        SetVehicleFixed(vehicle)
        SetVehicleDeformationFixed(vehicle)
        SetVehicleUndriveable(vehicle, false)
        SetVehicleEngineOn(vehicle, true, true, false)
        
        ShowNotification("~g~Véhicule réparé")
    else
        ShowNotification("~r~Vous n'êtes pas dans un véhicule")
    end
end)

-- Nettoyer le véhicule
RegisterNetEvent('admin:cleanVehicleClient')
AddEventHandler('admin:cleanVehicleClient', function()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    
    if vehicle ~= 0 then
        SetVehicleDirtLevel(vehicle, 0.0)
        WashDecalsFromVehicle(vehicle, 1.0)
        
        ShowNotification("~g~Véhicule nettoyé")
    else
        ShowNotification("~r~Vous n'êtes pas dans un véhicule")
    end
end)

-- Retourner le véhicule
RegisterNetEvent('admin:flipVehicleClient')
AddEventHandler('admin:flipVehicleClient', function()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    
    if vehicle ~= 0 then
        SetVehicleOnGroundProperly(vehicle)
        ShowNotification("~g~Véhicule retourné")
    else
        ShowNotification("~r~Vous n'êtes pas dans un véhicule")
    end
end)

-- Booster le véhicule
RegisterNetEvent('admin:boostVehicleClient')
AddEventHandler('admin:boostVehicleClient', function(multiplier)
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    
    if vehicle ~= 0 then
        SetVehicleEnginePowerMultiplier(vehicle, multiplier)
        SetVehicleEngineTorqueMultiplier(vehicle, multiplier)
        
        ShowNotification(string.format("~g~Boost x%s appliqué", multiplier))
    else
        ShowNotification("~r~Vous n'êtes pas dans un véhicule")
    end
end)

-- Mode God véhicule (OPTIMISÉ - 0.00ms)
local godVehicleActive = false

RegisterNetEvent('admin:godVehicleClient')
AddEventHandler('admin:godVehicleClient', function(toggle)
    godVehicleActive = toggle
    
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    
    if toggle then
        ShowNotification("~g~Mode God véhicule activé")
        
        if vehicle ~= 0 then
            SetEntityInvincible(vehicle, true)
            SetVehicleCanBeVisiblyDamaged(vehicle, false)
        end
        
        -- Thread optimisé - vérifie toutes les 500ms
        Citizen.CreateThread(function()
            while godVehicleActive do
                Citizen.Wait(500) -- Optimisé : 500ms au lieu de 0ms
                
                local ped = PlayerPedId()
                local veh = GetVehiclePedIsIn(ped, false)
                
                if veh ~= 0 then
                    SetEntityInvincible(veh, true)
                    SetVehicleCanBeVisiblyDamaged(veh, false)
                end
            end
        end)
    else
        ShowNotification("~r~Mode God véhicule désactivé")
        
        if vehicle ~= 0 then
            SetEntityInvincible(vehicle, false)
            SetVehicleCanBeVisiblyDamaged(vehicle, true)
        end
    end
end)

-- Changer la couleur
RegisterNetEvent('admin:changeVehicleColorClient')
AddEventHandler('admin:changeVehicleColorClient', function(primary, secondary)
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    
    if vehicle ~= 0 then
        SetVehicleCustomPrimaryColour(vehicle, primary[1], primary[2], primary[3])
        SetVehicleCustomSecondaryColour(vehicle, secondary[1], secondary[2], secondary[3])
        
        ShowNotification("~g~Couleur changée")
    else
        ShowNotification("~r~Vous n'êtes pas dans un véhicule")
    end
end)

-- Tune max
RegisterNetEvent('admin:maxTuneVehicleClient')
AddEventHandler('admin:maxTuneVehicleClient', function()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    
    if vehicle ~= 0 then
        SetVehicleModKit(vehicle, 0)
        
        -- Appliquer tous les mods
        for i = 0, 49 do
            local maxMod = GetNumVehicleMods(vehicle, i) - 1
            if maxMod > 0 then
                SetVehicleMod(vehicle, i, maxMod, false)
            end
        end
        
        -- Turbo
        ToggleVehicleMod(vehicle, 18, true)
        
        -- Xenon
        ToggleVehicleMod(vehicle, 22, true)
        
        ShowNotification("~g~Véhicule tune max")
    else
        ShowNotification("~r~Vous n'êtes pas dans un véhicule")
    end
end)

-- Clear tous les véhicules
RegisterNetEvent('admin:clearAllVehiclesClient')
AddEventHandler('admin:clearAllVehiclesClient', function()
    local vehicles = GetGamePool('CVehicle')
    
    for _, vehicle in pairs(vehicles) do
        if not IsPedAVehicle(GetPedInVehicleSeat(vehicle, -1)) then
            DeleteVehicle(vehicle)
        end
    end
    
    ShowNotification("~g~Tous les véhicules ont été supprimés")
end)

