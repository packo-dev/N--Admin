-- Système de téléportation
-- Créé par discord : nano.pasa

-- Téléportation vers le waypoint
function TeleportToWaypoint()
    local waypoint = GetFirstBlipInfoId(8)
    
    if not DoesBlipExist(waypoint) then
        ShowNotification("~r~Aucun waypoint placé")
        return
    end
    
    local coords = GetBlipInfoIdCoord(waypoint)
    local playerPed = PlayerPedId()
    
    -- Trouver la coordonnée Z
    local found = false
    local zCoord = 0.0
    local maxZ = 1000.0
    
    for z = 0, maxZ, 10 do
        RequestCollisionAtCoord(coords.x, coords.y, z)
        Citizen.Wait(10)
        
        local foundGround, groundZ = GetGroundZFor_3dCoord(coords.x, coords.y, z, false)
        
        if foundGround then
            zCoord = groundZ
            found = true
            break
        end
    end
    
    if not found then
        zCoord = coords.z
    end
    
    SetEntityCoords(playerPed, coords.x, coords.y, zCoord, false, false, false, true)
    
    ShowNotification("~g~Téléporté au waypoint")
end

-- Téléportation vers un véhicule
function TeleportToVehicle(vehicle)
    if DoesEntityExist(vehicle) then
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(vehicle)
        
        SetEntityCoords(playerPed, coords.x, coords.y, coords.z, false, false, false, true)
        
        ShowNotification("~g~Téléporté au véhicule")
    else
        ShowNotification("~r~Véhicule introuvable")
    end
end

-- Téléportation dans le véhicule le plus proche
function TeleportToNearestVehicle()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    
    local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 100.0, 0, 70)
    
    if DoesEntityExist(vehicle) then
        local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
        
        -- Trouver un siège libre
        for i = -1, maxSeats do
            if IsVehicleSeatFree(vehicle, i) then
                SetPedIntoVehicle(playerPed, vehicle, i)
                ShowNotification("~g~Téléporté dans le véhicule")
                return
            end
        end
        
        ShowNotification("~r~Aucun siège libre")
    else
        ShowNotification("~r~Aucun véhicule à proximité")
    end
end

-- Sauvegarder et charger des positions
local savedPositions = {}

function SavePosition(name)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local heading = GetEntityHeading(playerPed)
    
    savedPositions[name] = {
        x = coords.x,
        y = coords.y,
        z = coords.z,
        heading = heading
    }
    
    ShowNotification(string.format("~g~Position '%s' sauvegardée", name))
end

function LoadPosition(name)
    if savedPositions[name] then
        local pos = savedPositions[name]
        local playerPed = PlayerPedId()
        
        SetEntityCoords(playerPed, pos.x, pos.y, pos.z, false, false, false, true)
        SetEntityHeading(playerPed, pos.heading)
        
        ShowNotification(string.format("~g~Position '%s' chargée", name))
    else
        ShowNotification(string.format("~r~Position '%s' introuvable", name))
    end
end

function DeletePosition(name)
    if savedPositions[name] then
        savedPositions[name] = nil
        ShowNotification(string.format("~g~Position '%s' supprimée", name))
    else
        ShowNotification(string.format("~r~Position '%s' introuvable", name))
    end
end

function GetSavedPositions()
    return savedPositions
end

-- Exports
exports('TeleportToWaypoint', TeleportToWaypoint)
exports('SavePosition', SavePosition)
exports('LoadPosition', LoadPosition)
exports('DeletePosition', DeletePosition)
exports('GetSavedPositions', GetSavedPositions)

