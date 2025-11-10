-- N-Admin
-- Créé par discord : nano.pasa

Config = {}

-- Touche pour ouvrir le menu (F10 par défaut)
Config.OpenMenuKey = 121 -- F10

-- Webhook Discord pour les logs
Config.Webhook = "VOTRE_WEBHOOK_DISCORD_ICI"

-- Afficher les logs dans la console serveur
Config.ConsoleLogs = true

-- Système de permissions (identifiants Steam/Discord/License)
Config.Admins = {
    -- SUPERADMIN (Accès total)
    ["steam:110000XXXXXXXX"] = "superadmin",
    ["discord:123456789012345678"] = "superadmin",
    
    -- ADMIN (Accès élevé)
    ["steam:110000YYYYYYYY"] = "admin",
    
    -- MODERATEUR (Accès modéré)
    ["steam:110000ZZZZZZZZ"] = "moderator",
    
    -- SUPPORT (Accès basique)
    ["license:1234567890abcdef"] = "support",
}

-- Permissions par grade
Config.Permissions = {
    superadmin = {
        -- Joueurs
        "kick", "ban", "unban", "freeze", "teleport", "teleport_to", "bring", "goto",
        "spectate", "revive", "heal", "give_armor", "kill", "slap", "give_money",
        "set_job", "give_item", "clear_inventory", "manage_inventory",
        
        -- Serveur
        "announce", "weather", "time", "clear_area", "clear_cars", "clear_peds",
        "restart_resource", "stop_resource", "start_resource", "manage_server",
        
        -- Véhicules
        "spawn_vehicle", "delete_vehicle", "repair_vehicle", "clean_vehicle",
        "flip_vehicle", "boost_vehicle", "god_vehicle",
        
        -- Autres
        "noclip", "invisible", "god_mode", "unlimited_stamina", "super_jump",
        "fast_run", "fast_swim", "manage_permissions", "view_logs"
    },
    
    admin = {
        "kick", "ban", "freeze", "teleport", "teleport_to", "bring", "goto",
        "spectate", "revive", "heal", "give_armor", "slap",
        "announce", "weather", "time", "clear_area", "clear_cars",
        "spawn_vehicle", "delete_vehicle", "repair_vehicle", "clean_vehicle",
        "noclip", "invisible", "view_logs"
    },
    
    moderator = {
        "kick", "freeze", "teleport", "teleport_to", "goto",
        "spectate", "revive", "heal",
        "announce", "clear_area",
        "spawn_vehicle", "delete_vehicle", "repair_vehicle",
        "noclip"
    },
    
    support = {
        "freeze", "teleport", "goto",
        "spectate", "revive", "heal",
        "spawn_vehicle"
    }
}

-- Messages personnalisables
Config.Messages = {
    no_permission = "~r~Vous n'avez pas la permission d'utiliser cette commande",
    player_not_found = "~r~Joueur introuvable",
    action_success = "~g~Action effectuée avec succès",
    menu_opened = "~g~Menu admin ouvert",
    invalid_amount = "~r~Montant invalide",
}

-- Véhicules disponibles dans le menu (catégories)
Config.Vehicles = {
    {
        label = "🏎️ Super Cars",
        vehicles = {
            {name = "Adder", model = "adder"},
            {name = "T20", model = "t20"},
            {name = "Zentorno", model = "zentorno"},
            {name = "Turismo R", model = "turismor"},
            {name = "Osiris", model = "osiris"},
            {name = "Entity XF", model = "entityxf"},
        }
    },
    {
        label = "🚗 Sports",
        vehicles = {
            {name = "Elegy", model = "elegy2"},
            {name = "Jester", model = "jester"},
            {name = "Massacro", model = "massacro"},
            {name = "Rapid GT", model = "rapidgt"},
            {name = "Carbonizzare", model = "carbonizzare"},
        }
    },
    {
        label = "🚙 SUV",
        vehicles = {
            {name = "Huntley S", model = "huntley"},
            {name = "Baller", model = "baller"},
            {name = "Dubsta", model = "dubsta"},
            {name = "Gresley", model = "gresley"},
            {name = "Rocoto", model = "rocoto"},
        }
    },
    {
        label = "🚓 Police",
        vehicles = {
            {name = "Police Cruiser", model = "police"},
            {name = "Police SUV", model = "police2"},
            {name = "Police Buffalo", model = "police3"},
            {name = "Police Bike", model = "policeb"},
            {name = "Unmarked Cruiser", model = "police4"},
        }
    },
    {
        label = "🚑 Emergency",
        vehicles = {
            {name = "Ambulance", model = "ambulance"},
            {name = "Fire Truck", model = "firetruk"},
            {name = "Lifeguard", model = "lguard"},
        }
    },
    {
        label = "🏍️ Motos",
        vehicles = {
            {name = "Akuma", model = "akuma"},
            {name = "Bati 801", model = "bati"},
            {name = "Hakuchou", model = "hakuchou"},
            {name = "Ruffian", model = "ruffian"},
            {name = "PCJ-600", model = "pcj"},
        }
    },
    {
        label = "🚁 Hélicoptères",
        vehicles = {
            {name = "Buzzard", model = "buzzard2"},
            {name = "Frogger", model = "frogger"},
            {name = "Maverick", model = "maverick"},
            {name = "Police Heli", model = "polmav"},
        }
    },
    {
        label = "✈️ Avions",
        vehicles = {
            {name = "Luxor", model = "luxor"},
            {name = "Shamal", model = "shamal"},
            {name = "Velum", model = "velum"},
            {name = "Vestra", model = "vestra"},
        }
    }
}

-- Météos disponibles
Config.Weathers = {
    "CLEAR", "EXTRASUNNY", "CLOUDS", "OVERCAST", 
    "RAIN", "CLEARING", "THUNDER", "SMOG", 
    "FOGGY", "XMAS", "SNOWLIGHT", "BLIZZARD"
}

-- Lieux de téléportation rapide
Config.TeleportLocations = {
    {label = "🏢 Legion Square", coords = vector3(195.17, -933.77, 29.7)},
    {label = "🏥 Hôpital", coords = vector3(298.67, -584.55, 43.26)},
    {label = "🚓 Commissariat LSPD", coords = vector3(425.13, -979.55, 30.71)},
    {label = "🏦 Pacific Bank", coords = vector3(255.001, 225.855, 101.005)},
    {label = "🛫 Aéroport", coords = vector3(-1037.87, -2737.63, 13.76)},
    {label = "🏔️ Mont Chiliad", coords = vector3(501.77, 5604.85, 797.91)},
    {label = "🎰 Casino", coords = vector3(925.329, 46.152, 80.908)},
    {label = "⛽ Station Essence", coords = vector3(49.42, 2778.79, 58.04)},
    {label = "🏖️ Plage", coords = vector3(-1388.94, -1464.13, 4.48)},
    {label = "🌴 Sandy Shores", coords = vector3(1961.54, 3748.77, 32.34)},
    {label = "🏜️ Paleto Bay", coords = vector3(-448.12, 6019.85, 31.34)},
}

