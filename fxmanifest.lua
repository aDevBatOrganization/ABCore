fx_version 'cerulean'
game 'gta5'

author "a-dev.bat Team | Abject"
description "ABCore is a framework developped by a french dev, if you clone the repo github in you're ./ressources/ you've got auto update"
repository "https://github.com/aDevBatOrganization/ABCore.git"
discord "https://discord.gg/KQDcjZGxtq"
version '1.0.0'

-- General

lua54 'yes'

shared_scripts {
    'config.lua'
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}

-- a_hud

shared_scripts {
    'a_hud/config.lua'
}

client_scripts {
    'a_hud/client/*.lua'
}

server_scripts {
    'a_hud/server/*.lua'
}

ui_page 'a_hud/ui/index.html'

files {
    'a_hud/ui/index.html',
    'a_hud/ui/css/*.css',
    'a_hud/ui/js/*.js',
}
