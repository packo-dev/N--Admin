# 📁 Structure du Projet

## Vue d'ensemble

```
fivem-admin-menu/
├── 📄 fxmanifest.lua          # Manifest FiveM (configuration ressource)
├── ⚙️ config.lua               # Configuration principale
│
├── 🖥️ server/                  # Scripts côté serveur
│   ├── permissions.lua        # Système de permissions et grades
│   ├── logs.lua               # Système de logs (Discord + Console)
│   ├── player_management.lua  # Gestion des joueurs (kick, ban, etc.)
│   ├── server_management.lua  # Gestion serveur (météo, heure, etc.)
│   ├── vehicle_management.lua # Gestion véhicules
│   └── main.lua               # Script principal serveur
│
├── 💻 client/                  # Scripts côté client
│   ├── main.lua               # Script principal client + NUI callbacks
│   ├── player_actions.lua     # Actions joueurs (freeze, revive, etc.)
│   ├── vehicle_actions.lua    # Actions véhicules (spawn, repair, etc.)
│   ├── server_actions.lua     # Actions serveur (météo, time, clear)
│   ├── teleport.lua           # Système de téléportation
│   └── noclip.lua             # Noclip + God Mode + Invisible
│
├── 🎨 html/                    # Interface utilisateur (NUI)
│   ├── index.html             # Structure HTML du menu
│   ├── style.css              # Styles CSS (design moderne)
│   ├── script.js              # Logique JavaScript
│   └── img/                   # Images (optionnel)
│
└── 📚 Documentation
    ├── README.md              # Documentation complète
    ├── INSTALLATION.md        # Guide d'installation rapide
    ├── CONTRIBUTING.md        # Guide de contribution
    ├── LICENSE                # Licence MIT
    ├── STRUCTURE.md           # Ce fichier
    └── .gitignore             # Fichiers à ignorer

```

---

## 📖 Description des fichiers

### 🔧 Configuration

#### `fxmanifest.lua`
- Manifest FiveM standard
- Déclare tous les scripts (client/server)
- Définit l'UI page (NUI)
- Liste les fichiers à inclure

#### `config.lua`
- Configuration centrale partagée (client + server)
- Paramètres:
  - Touche d'ouverture du menu
  - Webhook Discord
  - Liste des admins
  - Permissions par grade
  - Liste des véhicules
  - Météos disponibles
  - Lieux de téléportation
  - Messages personnalisables

---

### 🖥️ Scripts Serveur

#### `server/permissions.lua`
**Rôle:** Gestion des permissions et grades

**Fonctions principales:**
- `GetPlayerAdminRank(source)` - Récupère le grade d'un joueur
- `HasPermission(source, permission)` - Vérifie une permission
- `IsPlayerAdmin(source)` - Vérifie si joueur est admin

**Events:**
- `admin:checkPermission` - Vérifier une permission
- `admin:getRank` - Obtenir le grade
- `admin:getPermissions` - Obtenir toutes les permissions

#### `server/logs.lua`
**Rôle:** Système de logging

**Fonctions principales:**
- `SendDiscordLog(title, description, color, fields)` - Envoie vers Discord
- `SendLog(action, adminSource, details, targetSource)` - Log générique

**Features:**
- Logs Discord avec webhooks
- Logs console serveur
- Logs colorés par type d'action
- Timestamps automatiques

#### `server/player_management.lua`
**Rôle:** Gestion des joueurs

**Events disponibles:**
- `admin:kickPlayer` - Kick un joueur
- `admin:banPlayer` - Ban un joueur
- `admin:freezePlayer` - Freeze/Unfreeze
- `admin:revivePlayer` - Réanimer
- `admin:healPlayer` - Soigner
- `admin:giveArmor` - Donner armure
- `admin:killPlayer` - Tuer
- `admin:giveMoney` - Donner argent
- `admin:getPlayers` - Liste des joueurs
- `admin:spectatePlayer` - Observer
- `admin:teleportToPlayer` - TP vers joueur
- `admin:bringPlayer` - Bring joueur

#### `server/server_management.lua`
**Rôle:** Gestion du serveur

**Events disponibles:**
- `admin:announce` - Annonce globale
- `admin:setWeather` - Changer météo
- `admin:setTime` - Changer l'heure
- `admin:clearArea` - Nettoyer une zone
- `admin:clearAllVehicles` - Clear véhicules
- `admin:clearAllPeds` - Clear PNJ
- `admin:restartResource` - Restart ressource
- `admin:stopResource` - Stop ressource
- `admin:startResource` - Start ressource
- `admin:getResources` - Liste ressources
- `admin:getServerInfo` - Infos serveur

#### `server/vehicle_management.lua`
**Rôle:** Gestion des véhicules

**Events disponibles:**
- `admin:spawnVehicle` - Spawn véhicule
- `admin:deleteVehicle` - Supprimer
- `admin:repairVehicle` - Réparer
- `admin:cleanVehicle` - Nettoyer
- `admin:flipVehicle` - Retourner
- `admin:boostVehicle` - Booster
- `admin:godVehicle` - God mode
- `admin:changeVehicleColor` - Changer couleur
- `admin:maxTuneVehicle` - Tune max

#### `server/main.lua`
**Rôle:** Script principal serveur

**Features:**
- Commandes chat (`/admin`, `/myrank`, `/admins`, `/adminhelp`, `/addadmin`)
- Vérification des bans à la connexion
- Message de démarrage

---

### 💻 Scripts Client

#### `client/main.lua`
**Rôle:** Script principal client + gestion NUI

**Features:**
- Détection touche d'ouverture (F10)
- Gestion ouverture/fermeture menu
- Communication NUI ↔ Client
- Tous les NUI callbacks

**Callbacks NUI:**
- Gestion joueurs (kick, ban, freeze, etc.)
- Gestion véhicules (spawn, delete, repair, etc.)
- Gestion serveur (announce, weather, time, etc.)
- Outils personnels (noclip, godmode, etc.)

#### `client/player_actions.lua`
**Rôle:** Actions sur les joueurs côté client

**Events:**
- `admin:freezeTarget` - Freeze local
- `admin:reviveTarget` - Revive local
- `admin:healTarget` - Heal local
- `admin:giveArmorTarget` - Give armor local
- `admin:killTarget` - Kill local
- `admin:teleportToCoords` - TP vers coords
- `admin:startSpectate` - Démarrer spectate

**Features:**
- Système de spectate complet
- Gestion des effets visuels
- Affichage HUD spectate

#### `client/vehicle_actions.lua`
**Rôle:** Actions sur les véhicules

**Events:**
- `admin:spawnVehicleClient` - Spawn avec RequestModel
- `admin:deleteVehicleClient` - Delete véhicule
- `admin:repairVehicleClient` - Réparer complet
- `admin:cleanVehicleClient` - Nettoyer
- `admin:flipVehicleClient` - Retourner
- `admin:boostVehicleClient` - Modifier performances
- `admin:godVehicleClient` - God mode véhicule
- `admin:changeVehicleColorClient` - Couleurs custom
- `admin:maxTuneVehicleClient` - Tune complet
- `admin:clearAllVehiclesClient` - Clear tous

#### `client/server_actions.lua`
**Rôle:** Actions serveur côté client

**Events:**
- `admin:syncWeather` - Synchroniser météo
- `admin:syncTime` - Synchroniser heure
- `admin:clearAreaClient` - Clear zone locale
- `admin:clearAllPedsClient` - Clear PNJ locaux

#### `client/teleport.lua`
**Rôle:** Système de téléportation

**Fonctions:**
- `TeleportToWaypoint()` - TP au waypoint
- `TeleportToVehicle(vehicle)` - TP vers véhicule
- `TeleportToNearestVehicle()` - TP véhicule proche
- `SavePosition(name)` - Sauvegarder position
- `LoadPosition(name)` - Charger position
- `DeletePosition(name)` - Supprimer position

#### `client/noclip.lua`
**Rôle:** Noclip + outils personnels

**Fonctions:**
- `ToggleNoclip()` - Active/désactive noclip
- `ToggleGodMode()` - Active/désactive god mode
- `ToggleInvisible()` - Active/désactive invisibilité

**Features Noclip:**
- Contrôles WASD + Space/Ctrl
- Vitesses variables (Shift rapide, Alt lent)
- Support véhicule
- HUD informatif

---

### 🎨 Interface (NUI)

#### `html/index.html`
**Structure:**
- Header avec titre + badge grade
- Navigation par onglets (5 sections)
- Contenu dynamique par section
- Modal pour actions joueurs

**Sections:**
1. 👥 Joueurs - Liste + recherche + actions
2. 🚗 Véhicules - Catégories + spawn + actions
3. 🖥️ Serveur - Annonces + météo + heure + nettoyage
4. 🛠️ Outils - Outils personnels (noclip, god, etc.)
5. 📍 Téléportation - Lieux rapides

#### `html/style.css`
**Design:**
- Gradient violet/bleu moderne
- Animations fluides
- Responsive design
- Dark theme
- Effets hover/transitions
- Scrollbar custom

**Composants:**
- Cards joueurs
- Grids véhicules/météo/outils
- Boutons stylisés par action
- Modal centré
- Badges de grade

#### `html/script.js`
**Logique:**
- Communication NUI ↔ FiveM
- Gestion des onglets
- Recherche joueurs
- Filtres véhicules par catégorie
- Events listeners
- Fetch API vers callbacks

---

## 🔄 Flux de Communication

### Client → Server
```
Client Event → TriggerServerEvent → Server Handler → Action + Log
```

### Server → Client
```
Server Event → TriggerClientEvent → Client Handler → Action locale
```

### NUI → Client
```
NUI Fetch → RegisterNUICallback → TriggerServerEvent → Server
```

### Server → NUI
```
Server → TriggerClientEvent → SendNUIMessage → NUI Update
```

---

## 🎯 Points d'Extension

### Ajouter une nouvelle action joueur

1. **Server** (`server/player_management.lua`):
```lua
RegisterNetEvent('admin:maNouvelleFonction')
AddEventHandler('admin:maNouvelleFonction', function(targetId)
    -- Code serveur
    SendLog('action', source, "Description", targetId)
end)
```

2. **Client** (`client/main.lua`):
```lua
RegisterNUICallback('maNouvelleFonction', function(data, cb)
    TriggerServerEvent('admin:maNouvelleFonction', data.targetId)
    cb('ok')
end)
```

3. **NUI** (`html/script.js`):
```javascript
function maNouvelleFonction() {
    fetch('https://fivem-admin-menu/maNouvelleFonction', {
        method: 'POST',
        body: JSON.stringify({ targetId: selectedPlayer.id })
    });
}
```

4. **HTML** (`html/index.html`):
```html
<button onclick="maNouvelleFonction()">Ma Fonction</button>
```

### Ajouter un nouvel onglet

1. Ajouter le bouton dans `.menu-tabs`
2. Ajouter le contenu dans `.menu-content`
3. Le système de tabs gérera automatiquement

---

## 📊 Statistiques du Projet

- **Fichiers Lua:** 11
- **Fichiers HTML:** 1
- **Fichiers CSS:** 1
- **Fichiers JS:** 1
- **Lignes de code:** ~3000+
- **Fonctionnalités:** 50+
- **Véhicules:** 50+
- **Permissions:** 40+

---

## 🔐 Sécurité

**Vérifications côté serveur:**
- Toutes les actions passent par des vérifications de permissions
- Logs de toutes les actions administratives
- Validation des identifiants joueurs
- Protection contre les abus

**Bonnes pratiques:**
- Pas de code client de confiance
- Tout validé côté serveur
- Logs complets
- Permissions granulaires

---

**Pour plus d'informations, consultez [README.md](README.md)**

