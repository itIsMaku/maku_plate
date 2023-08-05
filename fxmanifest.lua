fx_version 'cerulean'
games { 'gta5' }
author 'maku#5434'
version '1.0'
repository 'itIsMaku/maku_plate'

shared_scripts {
    'configs/sh-config.lua',
}

client_scripts {
    'client/cl-main.lua'
}

server_scripts {
    'server/sv-version.lua',
    'server/sv-main.lua'
}

dependencies {
    'ox_inventory'
}
