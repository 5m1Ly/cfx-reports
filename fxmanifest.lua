fx_version "cerulean"
game "gta5"

author "5m1Ly"
description "Report system for Redux RP"
version "0.0.1"

lua54 'yes'

shared_script '@ox_lib/init.lua'

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "config/config.lua",
    "src/server/main.lua",
    "src/server/utils.lua",
    "src/server/players.lua",
    "src/server/reports.lua",
    "src/server/discord.lua",
    "src/server/commands.lua",
}

client_script "src/client/main.lua"

dependencies {
    "qb-core",
    "oxmysql",
    "ox_lib"
}
