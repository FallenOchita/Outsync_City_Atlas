# Outsync City Atlas

A resource-owned 2D native map tab for OPEN//77. It adds a searchable Night City postal and street directory beside the existing native Map tab. It does not replace the native map or use the 3D map resource.

## Current status

- Native map tab: implemented with `Open77.map.addTab`.
- Outsync-styled directory UI: implemented.
- Postal district directory: seeded with draft codes for development only.
- Street directory: data structure and search are implemented; verified street entries still need to be supplied.
- Drawing labels directly over the native map canvas: not implemented. The documented native map API provides custom WebUI tabs and resource blips, but does not expose an arbitrary 2D canvas text-overlay API.

## Important data note

The codes in `shared/data.lua` (97101–97108) are **provisional placeholders**, not confirmed Outsync RP postal codes. Replace them with the server's actual postal scheme before publishing this resource to players. No street coordinates or map positions have been invented.

## Installation

1. Place the `outsync_city_atlas` folder in the server's configured OPEN//77 resources directory.
2. Ensure the resource is included in the server's resource load configuration.
3. Confirm the client build supports native map tabs.
4. Start/reload `outsync_city_atlas`.
5. Open the native 2D map and select the **ATLAS** tab.

The resource manifest declares the `map.read` and `map.control` permissions and the local WebUI files.

## Adding streets

Edit `OutsyncCityAtlasData.streets` in `shared/data.lua`:

```lua
streets = {
    {
        name = "Verified street name",
        district = "Watson",
        postal = "97101"
    }
}
```

Use street names and postal assignments confirmed by the Outsync RP map/database. The directory search matches street name, district, and postal code.

## Native 2D map integration

This resource uses the documented OPEN//77 native map API:

- `Open77.map.addTab`
- `Open77.map.setTitle`
- `Open77.map.setAccentColor`
- `open77:map:tabEntered`
- WebUI `Open77.on` / `Open77.emit`

See [Native map and player waypoints](https://open2077.net/docs/native-map) and [The Lua resource runtime](https://open2077.net/docs/resource-runtime).

## Development

This repository contains an OPEN//77 Lua resource and a local WebUI. The current release is an integration scaffold; verify it on the target Outsync client/server build before treating it as production-ready.
