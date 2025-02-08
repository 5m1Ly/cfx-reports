fx_version "cerulean"
game "gta5"

author "5m1Ly"
description "Report system for Redux RP"
version "0.0.1"

lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'config/config.pub.lua',
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "config/config.lua",
    "src/server/main.lua",
    "src/server/utils.lua",
    "src/server/players.lua",
    "src/server/reports.lua",
    "src/server/commands.lua",
}

client_scripts {
    "src/client/main.lua"
}

dependencies {
    "qb-core",
    "oxmysql",
    "ox_lib"
}
