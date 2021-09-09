resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'FOXWILDS CRAFTING base CUSTOM JOBS'

version '2.0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/clip.lua',
	'server/lockpick.lua',
	'server/vest.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/clip.lua',
	'client/lockpick.lua',
	'client/vest.lua',
	'client/main.lua'
}

dependencies {
	'es_extended'
}
