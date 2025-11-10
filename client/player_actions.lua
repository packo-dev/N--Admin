-- Actions sur les joueurs côté client (OPTIMISÉ - 0.00ms)
-- Créé par discord : nano.pasa

-- Cache des natives pour performance
local PlayerPedId = PlayerPedId
local SetEntityHealth = SetEntityHealth
local SetPedArmour = SetPedArmour
local ClearPedBloodDamage = ClearPedBloodDamage
local NetworkResurrectLocalPlayer = NetworkResurrectLocalPlayer

-- Freeze le joueur local
RegisterNetEvent('admin:freezeTarget')
AddEventHandler('admin:freezeTarget', function(freeze)
    local ped = PlayerPedId()
    FreezeEntityPosition(ped, freeze)
    
    if freeze then
        ShowNotification("~r~Vous avez été gelé par un admin")
    else
        ShowNotification("~g~Vous avez été dégelé")
    end
end)

-- Revive le joueur local
RegisterNetEvent('admin:reviveTarget')
AddEventHandler('admin:reviveTarget', function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    
    -- Réanimer le joueur
    NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, GetEntityHeading(ped), true, false)
    SetPlayerInvincible(PlayerId(), false)
    ClearPedBloodDamage(ped)
    
    -- Restaurer la santé
    SetEntityHealth(ped, GetEntityMaxHealth(ped))
    
    ShowNotification("~g~Vous avez été réanimé")
end)

-- Heal le joueur local
RegisterNetEvent('admin:healTarget')
AddEventHandler('admin:healTarget', function()
    local ped = PlayerPedId()
    
    SetEntityHealth(ped, GetEntityMaxHealth(ped))
    ClearPedBloodDamage(ped)
    
    ShowNotification("~g~Vous avez été soigné")
end)

-- Donner de l'armure
RegisterNetEvent('admin:giveArmorTarget')
AddEventHandler('admin:giveArmorTarget', function()
    local ped = PlayerPedId()
    SetPedArmour(ped, 100)
    
    ShowNotification("~g~Vous avez reçu de l'armure")
end)

-- Tuer le joueur local
RegisterNetEvent('admin:killTarget')
AddEventHandler('admin:killTarget', function()
    SetEntityHealth(PlayerPedId(), 0)
end)

-- Téléporter vers des coordonnées
RegisterNetEvent('admin:teleportToCoords')
AddEventHandler('admin:teleportToCoords', function(coords)
    local ped = PlayerPedId()
    
    SetEntityCoords(ped, coords.x, coords.y, coords.z, false, false, false, true)
    
    ShowNotification("~g~Téléportation effectuée")
end)

-- Spectate un joueur
local isSpectating = false
local spectateTarget = nil
local lastCoords = nil

RegisterNetEvent('admin:startSpectate')
AddEventHandler('admin:startSpectate', function(targetId)
    if isSpectating then
        StopSpectate()
    else
        StartSpectate(targetId)
    end
end)

function StartSpectate(targetId)
    local playerPed = PlayerPedId()
    local targetPed = GetPlayerPed(GetPlayerFromServerId(targetId))
    
    if not DoesEntityExist(targetPed) then
        ShowNotification("~r~Joueur introuvable")
        return
    end
    
    lastCoords = GetEntityCoords(playerPed)
    isSpectating = true
    spectateTarget = targetId
    
    -- Rendre le joueur invisible
    SetEntityVisible(playerPed, false, false)
    SetEntityCollision(playerPed, false, false)
    
    -- Démarrer le spectate
    NetworkSetInSpectatorMode(true, targetPed)
    
    ShowNotification("~g~Spectate activé - Appuyez sur ~b~E~g~ pour arrêter")
    
    -- Cache du nom pour éviter répétitions
    local targetName = GetPlayerName(GetPlayerFromServerId(targetId))
    
    -- Thread optimisé pour arrêter le spectate
    Citizen.CreateThread(function()
        while isSpectating do
            Citizen.Wait(0) -- Nécessaire pour réactivité
            
            -- Afficher les infos du joueur (nom cached)
            DrawText2D(0.5, 0.05, string.format("~b~Spectate: ~w~%s", targetName), 0.5)
            
            -- Arrêter avec E
            if IsControlJustReleased(0, 38) then -- E
                StopSpectate()
            end
        end
    end)
end

function StopSpectate()
    if not isSpectating then return end
    
    local playerPed = PlayerPedId()
    
    -- Arrêter le spectate
    NetworkSetInSpectatorMode(false, playerPed)
    
    -- Restaurer le joueur
    SetEntityVisible(playerPed, true, false)
    SetEntityCollision(playerPed, true, false)
    
    -- Téléporter au dernier emplacement
    if lastCoords then
        SetEntityCoords(playerPed, lastCoords.x, lastCoords.y, lastCoords.z)
    end
    
    isSpectating = false
    spectateTarget = nil
    lastCoords = nil
    
    ShowNotification("~g~Spectate désactivé")
end

-- Fonction pour afficher du texte 2D
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

