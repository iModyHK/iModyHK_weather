resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

-- Resource Information
author 'iModyHK'
description 'Weather Voting Script'
version '1.0.0'

client_script {
    'config.lua',
    'client.lua'
}
server_script {
    'config.lua',
    'server.lua'
}
ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js'
}