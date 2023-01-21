--[[
  ░█████╗░██████╗░████████╗██╗░█████╗░███╗░░██╗███████╗ ██████╗░███████╗██╗░░░██╗███████╗██╗░░░░░░█████╗░██████╗░███████╗██████╗░
  ██╔══██╗██╔══██╗╚══██╔══╝██║██╔══██╗████╗░██║██╔════╝ ██╔══██╗██╔════╝██║░░░██║██╔════╝██║░░░░░██╔══██╗██╔══██╗██╔════╝██╔══██╗
  ██║░░██║██████╔╝░░░██║░░░██║██║░░██║██╔██╗██║█████╗░░ ██║░░██║█████╗░░╚██╗░██╔╝█████╗░░██║░░░░░██║░░██║██████╔╝█████╗░░██████╔╝
  ██║░░██║██╔═══╝░░░░██║░░░██║██║░░██║██║╚████║██╔══╝░░ ██║░░██║██╔══╝░░░╚████╔╝░██╔══╝░░██║░░░░░██║░░██║██╔═══╝░██╔══╝░░██╔══██╗
  ╚█████╔╝██║░░░░░░░░██║░░░██║╚█████╔╝██║░╚███║███████╗ ██████╔╝███████╗░░╚██╔╝░░███████╗███████╗╚█████╔╝██║░░░░░███████╗██║░░██║
  ░╚════╝░╚═╝░░░░░░░░╚═╝░░░╚═╝░╚════╝░╚═╝░░╚══╝╚══════╝ ╚═════╝░╚══════╝░░░╚═╝░░░╚══════╝╚══════╝░╚════╝░╚═╝░░░░░╚══════╝╚═╝░░╚═╝
  THANK FOR SUPPORT | DISCORD: https://discord.gg/4qvynScvey | FACEBOOK: https://www.facebook.com/profile.php?id=100088344682775
]] 

Global = {}
Global['FRAMEWORK'] = {['SHAREDOBJECT'] = 'esx:getSharedObject'}
-- ['t20']         = {
--     type        = 'vehicle',
--     expiration  = { type = 'SECOND', count = 10}
-- },
-- ['weapon_bat']  = {
--     type        = 'weapon',
--     expiration  = { type = 'SECOND', count = 60 }
-- },
Global['CheckExpire'] = 1 * 60 * 1000
Global['ItemExpire'] = {
    ['card_gift']               = {
        ['card_surgery']    = {
            type        = 'item',
            amount      = 1,
            expiration  = { type = 'DAY', count = 4 }
        },
        ['card_newbie']    = {
            type        = 'item',
            amount      = 1,
            expiration  = { type = 'DAY', count = 4 }
        },
        ['card_vault']    = {
            type        = 'item',
            amount      = 1,
            expiration  = { type = 'DAY', count = 4 }
        },
        ['bifta']    = {
            type        = 'vehicle',
            expiration  = { type = 'DAY', count = 7 }
        },
        ['coquette4']    = {
            type        = 'vehicle',
            expiration  = { type = 'DAY', count = 5 }
        },
    },
    ['car_rent_coquette4']      = {
        ['coquette4']    = {
            type        = 'vehicle',
            expiration  = { type = 'DAY', count = 5 }
        },
    },
    ['car_rent_bifta']          = {
        ['bifta']    = {
            type        = 'vehicle',
            expiration  = { type = 'DAY', count = 7 }
        },
    },
    ['car_rent_italigtb']       = {
        ['italigtb']    = {
            type        = 'vehicle',
            expiration  = { type = 'DAY', count = 7 }
        },
    },
    ['car_rent_freecrawler']    = {
        ['freecrawler']    = {
            type        = 'vehicle',
            expiration  = { type = 'DAY', count = 7 }
        },
    },
    ['car_rent_kamacho']        = {
        ['kamacho']    = {
            type        = 'vehicle',
            expiration  = { type = 'DAY', count = 7 }
        },
    },
    ['car_rent_caracara2']      = {
        ['caracara2']    = {
            type        = 'vehicle',
            expiration  = { type = 'DAY', count = 7 }
        },
    },
    ['car_rent_mule3']          = {
        ['mule3']    = {
            type        = 'vehicle',
            expiration  = { type = 'DAY', count = 7 }
        },
    },
    ['car_rent_rallytruck']     = {
        ['rallytruck']    = {
            type        = 'vehicle',
            expiration  = { type = 'DAY', count = 7 }
        },
    },
}


-- TriggerEvent('option_itemexpire:CheckExpireIsUse', 'card_surgery', source)
Global['ItemExpireLogs'] = function(sendToDiscord, Source)
    TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'ItemExpire', sendToDiscord, Source, '^2')
end

