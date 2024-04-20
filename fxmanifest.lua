game 'gta5'
version '1.0.0'
fx_version 'cerulean'
lua54 'yes'

client_scripts {
    'client.lua'
}
server_scripts {
    'server.lua',
    'test.lua',
    '@oxmysql/lib/MySQL.lua'
}

shared_scripts {	
	'@es_extended/imports.lua',
	'@ox_lib/init.lua',
}

dependencies {
	'es_extended',
}