-- Outsync City Atlas catalog.
--
-- IMPORTANT:
-- The postal codes below are proposed placeholders for development.
-- Replace them with the codes actually used by Outsync RP before release.
-- Street entries intentionally start empty: add verified street names and
-- their district/postal associations instead of publishing guessed data.

OutsyncCityAtlasData = {
    title = "OUTSYNC CITY ATLAS",
    subtitle = "NIGHT CITY • POSTAL & STREET DIRECTORY",
    version = "0.1.0",
    postalStatus = "DRAFT",
    postals = {
        { code = "97101", district = "Watson", streets = {} },
        { code = "97102", district = "Westbrook", streets = {} },
        { code = "97103", district = "City Center", streets = {} },
        { code = "97104", district = "Heywood", streets = {} },
        { code = "97105", district = "Santo Domingo", streets = {} },
        { code = "97106", district = "Pacifica", streets = {} },
        { code = "97107", district = "Badlands", streets = {} },
        { code = "97108", district = "Dogtown", streets = {} }
    },

    -- Add verified entries in this format:
    -- {
    --     name = "Verified street name",
    --     district = "Watson",
    --     postal = "97101"
    -- }
    streets = {}
}
