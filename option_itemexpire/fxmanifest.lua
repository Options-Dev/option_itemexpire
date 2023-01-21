--[[
  ░█████╗░██████╗░████████╗██╗░█████╗░███╗░░██╗███████╗ ██████╗░███████╗██╗░░░██╗███████╗██╗░░░░░░█████╗░██████╗░███████╗██████╗░
  ██╔══██╗██╔══██╗╚══██╔══╝██║██╔══██╗████╗░██║██╔════╝ ██╔══██╗██╔════╝██║░░░██║██╔════╝██║░░░░░██╔══██╗██╔══██╗██╔════╝██╔══██╗
  ██║░░██║██████╔╝░░░██║░░░██║██║░░██║██╔██╗██║█████╗░░ ██║░░██║█████╗░░╚██╗░██╔╝█████╗░░██║░░░░░██║░░██║██████╔╝█████╗░░██████╔╝
  ██║░░██║██╔═══╝░░░░██║░░░██║██║░░██║██║╚████║██╔══╝░░ ██║░░██║██╔══╝░░░╚████╔╝░██╔══╝░░██║░░░░░██║░░██║██╔═══╝░██╔══╝░░██╔══██╗
  ╚█████╔╝██║░░░░░░░░██║░░░██║╚█████╔╝██║░╚███║███████╗ ██████╔╝███████╗░░╚██╔╝░░███████╗███████╗╚█████╔╝██║░░░░░███████╗██║░░██║
  ░╚════╝░╚═╝░░░░░░░░╚═╝░░░╚═╝░╚════╝░╚═╝░░╚══╝╚══════╝ ╚═════╝░╚══════╝░░░╚═╝░░░╚══════╝╚══════╝░╚════╝░╚═╝░░░░░╚══════╝╚═╝░░╚═╝
  THANK FOR SUPPORT | DISCORD: https://discord.gg/4qvynScvey | FACEBOOK: https://www.facebook.com/profile.php?id=100088344682775
]]

fx_version 'cerulean'                                                                      
games { 'gta5' }                                                                           
                                                                                           
author 'OPTION DEVELOPER'
description 'OPTION DEVELOPER'
version '1.0.1'

client_scripts {
  'extension.config.lua',                                                                  
  'core/modules/module.lua',
  'core/client_main.lua',
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  '@oxmysql/lib/MySQL.lua',
  'extension.config.lua',
  'core/modules/module.lua',
  'core/server_main.lua',
}

-- ui_page "Interface/index.html"

-- files {
--   "Interface/*.html",
--   "Interface/*.js",
--   "Interface/*.css",
--   "Interface/imges/*.png",
-- }