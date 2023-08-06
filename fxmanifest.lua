fx_version 'cerulean'
games { 'gta5' }
author 'maku#5434'
version '1.1'
lua54 'yes'
repository 'itIsMaku/maku_plate'

shared_scripts {
    '@ox_lib/init.lua',
    'configs/sh-config.lua',
}

client_scripts {
    'client/cl-main.lua',
    'client/cl-progressbar.lua'
}

server_scripts {
    'server/sv-version.lua',
    'server/sv-main.lua',
    'server/sv-progressbar.lua'
}

dependencies {
    'ox_inventory'
}

ox_libs {
    'interface'
}
