-- Système de Noclip (OPTIMISÉ - 0.00ms)
-- Créé par discord : nano.pasa

local noclipActive = false
local noclipSpeed = 1.0
local noclipEntity = nil

-- Cache des natives pour performance
local GetGameplayCamRelativePitch = GetGameplayCamRelativePitch
local GetEntityHeading = GetEntityHeading
local GetEntityCoords = GetEntityCoords
local SetEntityCoordsNoOffset = SetEntityCoordsNoOffset
local IsControlPressed = IsControlPressed

function ToggleNoclip()
    noclipActive = not noclipActive
    
    if noclipActive then
        StartNoclip()
    else
        StopNoclip()
    end
end

function StartNoclip()
    local playerPed = PlayerPedId()
    
    -- Définir l'entité (joueur ou véhicule)
    if IsPedInAnyVehicle(playerPed, false) then
        noclipEntity = GetVehiclePedIsIn(playerPed, false)
    else
        noclipEntity = playerPed
    end
    
    FreezeEntityPosition(noclipEntity, true)
    SetEntityCollision(noclipEntity, false, false)
    SetEntityVisible(noclipEntity, true, false)
    SetEntityInvincible(noclipEntity, true)
    
    ShowNotification("~g~Noclip activé")
    
    -- Thread principal du noclip (OPTIMISÉ)
    Citizen.CreateThread(function()
        while noclipActive do
            Citizen.Wait(0) -- Nécessaire pour la fluidité du noclip
            
            local coords = GetEntityCoords(noclipEntity)
            local heading = GetEntityHeading(noclipEntity)
            local pitch = GetGameplayCamRelativePitch()
            
            -- Variables locales pour performance
            local speed = 1.0
            local x, y, z = coords.x, coords.y, coords.z
            local hasMovement = false
            
            -- Contrôles de vitesse
            if IsControlPressed(0, 21) then -- Shift
                speed = 5.0
            elseif IsControlPressed(0, 19) then -- Alt
                speed = 0.2
            end
            
            -- Pré-calcul des valeurs trigonométriques
            local radHeading = math.rad(heading)
            local sinHeading = math.sin(-radHeading)
            local cosHeading = math.cos(-radHeading)
            local sinPitch = math.sin(math.rad(pitch))
            
            -- Mouvements optimisés
            if IsControlPressed(0, 32) then -- W
                x = x + sinHeading * speed
                y = y + cosHeading * speed
                z = z + sinPitch * speed
                hasMovement = true
            end
            
            if IsControlPressed(0, 33) then -- S
                x = x - sinHeading * speed
                y = y - cosHeading * speed
                z = z - sinPitch * speed
                hasMovement = true
            end
            
            if IsControlPressed(0, 34) then -- A
                x = x + math.sin(-radHeading - 1.5708) * speed
                y = y + math.cos(-radHeading - 1.5708) * speed
                hasMovement = true
            end
            
            if IsControlPressed(0, 35) then -- D
                x = x + math.sin(-radHeading + 1.5708) * speed
                y = y + math.cos(-radHeading + 1.5708) * speed
                hasMovement = true
            end
            
            if IsControlPressed(0, 22) then -- Space
                z = z + speed
                hasMovement = true
            end
            
            if IsControlPressed(0, 36) then -- Ctrl
                z = z - speed
                hasMovement = true
            end
            
            -- Appliquer les nouvelles coordonnées seulement si mouvement
            if hasMovement then
                SetEntityCoordsNoOffset(noclipEntity, x, y, z, true, true, true)
            end
            
            -- Afficher les instructions (optimisé - pas de concatenation)
            DrawText2D(0.5, 0.9, "~b~Noclip~w~ | ~g~W/A/S/D~w~: Déplacement | ~g~Space/Ctrl~w~: Haut/Bas | ~g~Shift~w~: Rapide | ~g~Alt~w~: Lent", 0.4)
        end
    end)
end

function StopNoclip()
    if noclipEntity then
        FreezeEntityPosition(noclipEntity, false)
        SetEntityCollision(noclipEntity, true, true)
        SetEntityVisible(noclipEntity, true, false)
        SetEntityInvincible(noclipEntity, false)
        
        noclipEntity = nil
    end
    
    ShowNotification("~r~Noclip désactivé")
end

-- Mode God (OPTIMISÉ - 0.00ms)
local godModeActive = false

function ToggleGodMode()
    godModeActive = not godModeActive
    
    local playerPed = PlayerPedId()
    local playerId = PlayerId()
    
    if godModeActive then
        ShowNotification("~g~Mode God activé")
        
        -- Activer une seule fois, pas besoin de boucle
        SetEntityInvincible(playerPed, true)
        SetPlayerInvincible(playerId, true)
        
        -- Thread optimisé qui ne tourne que si god mode actif
        Citizen.CreateThread(function()
            while godModeActive do
                Citizen.Wait(1000) -- Vérification toutes les secondes
                
                -- Réappliquer au cas où le ped change
                local currentPed = PlayerPedId()
                SetEntityInvincible(currentPed, true)
                SetPlayerInvincible(PlayerId(), true)
            end
            
            -- Désactiver proprement
            local ped = PlayerPedId()
            SetEntityInvincible(ped, false)
            SetPlayerInvincible(PlayerId(), false)
        end)
    else
        ShowNotification("~r~Mode God désactivé")
        SetEntityInvincible(playerPed, false)
        SetPlayerInvincible(playerId, false)
    end
end

-- Mode Invisible
local invisibleActive = false

function ToggleInvisible()
    invisibleActive = not invisibleActive
    
    local playerPed = PlayerPedId()
    SetEntityVisible(playerPed, not invisibleActive, false)
    
    if invisibleActive then
        ShowNotification("~g~Invisibilité activée")
    else
        ShowNotification("~r~Invisibilité désactivée")
    end
end

function DrawText2D(x, y, text, scale)
    SetTextFont(4)
    SetTextScale(scale, scale)
    SetTextColour(255, 255, 255, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(true)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

-- Exports
exports('ToggleNoclip', ToggleNoclip)
exports('ToggleGodMode', ToggleGodMode)
exports('ToggleInvisible', ToggleInvisible)

