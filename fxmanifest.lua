fx_version 'cerulean'
game 'gta5'

framework "ABCore"
author "a-dev.bat Team | Abject | Laarfang"
description "ABCore is a framework developped by French dev, if you clone the repo github in you're ./ressources/ you've got auto update"
repository "https://github.com/aDevBatOrganization/ABCore.git"
discord "https://discord.gg/KQDcjZGxtq"
shop "https://a-dev.ovh"
version '1.0.0'

-- #######
-- General
-- #######

lua54 'yes'


shared_scripts {
    'shared/*.lua'
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}

ui_page 'ui/index.html'

files {
    'ui/index.html',
    'ui/css/*.css',
    'ui/js/*.js',
}

-- #####
-- a_hud
-- #####

shared_scripts {
    'a_hud/*.lua'
}

client_scripts {
    'a_hud/client/*.lua'
}

server_scripts {
    'a_hud/server/*.lua'
}


-- ########################################################################
-- playerConnect verifie l'id steam, cree le joueur si il n'est pas present
-- ########################################################################

shared_scripts {
    'a_playerConnect/*.lua'
}

client_scripts {
    'a_playerConnect/client/*.lua'
}

server_scripts {
    "@mysql-async/lib/MYSQL.lua",
    'a_playerConnect/server/*.lua'
}
