resource "outsync_city_atlas"
version "0.1.0"
auto_start true

shared_script "shared/data.lua"
client_script "client/main.lua"

web_files { "web/**" }

permissions { "map.read", "map.control" }
