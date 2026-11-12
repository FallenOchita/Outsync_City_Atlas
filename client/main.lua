local RESOURCE_NAME = GetCurrentResourceName()
local TAB_LOCAL_ID = "outsync-atlas"

local atlasTabId
local atlasPage

local function log(message)
    print(("[Outsync City Atlas] %s"):format(message))
end

local function sendCatalog()
    if not atlasPage then
        return
    end

    local catalog = OutsyncCityAtlasData or {}
    atlasPage:emit("atlas:state", {
        title = catalog.title or "OUTSYNC CITY ATLAS",
        subtitle = catalog.subtitle or "NIGHT CITY",
        version = catalog.version or "unknown",
        postalStatus = catalog.postalStatus or "UNVERIFIED",
        postals = catalog.postals or {},
        streets = catalog.streets or {}
    })
end

local function registerAtlasTab()
    if not Open77 or not Open77.map
        or type(Open77.map.addTab) ~= "function" then
        log("Native map tabs are unavailable on this client; resource left inactive.")
        return
    end

    if type(Open77.map.setTitle) == "function" then
        local ok, reason = Open77.map.setTitle("OUTSYNC ROLEPLAY")
        if not ok then
            log(("Could not set map title: %s"):format(tostring(reason)))
        end
    end

    if type(Open77.map.setAccentColor) == "function" then
        local ok, reason = Open77.map.setAccentColor("#22D8E2")
        if not ok then
            log(("Could not set map accent: %s"):format(tostring(reason)))
        end
    end

    local reason
    atlasTabId, atlasPage = Open77.map.addTab({
        id = TAB_LOCAL_ID,
        label = "ATLAS",
        url = "web/index.html",
        order = 20
    })

    if not atlasTabId then
        log(("Could not register native map tab: %s"):format(tostring(atlasPage)))
        atlasPage = nil
        return
    end

    atlasPage:on("atlas:refresh", sendCatalog)
    log(("Registered native 2D map tab (%s)."):format(atlasTabId))
end

AddEventHandler("onClientResourceStart", function(resourceName)
    if resourceName ~= RESOURCE_NAME then
        return
    end

    registerAtlasTab()
end)

AddEventHandler("open77:map:tabEntered", function(event)
    if atlasTabId and event and event.id == atlasTabId then
        sendCatalog()
    end
end)

AddEventHandler("open77:map:tabRemoved", function(event)
    if atlasTabId and event and event.id == atlasTabId then
        atlasPage = nil
        atlasTabId = nil
        log("Map tab was removed because its page became unavailable.")
    end
end)
