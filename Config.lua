local _, L = ...

local SCREENSHOT_FORMAT_CVAR = "screenshotFormat"
local SCREENSHOT_QUALITY_CVAR = "screenshotQuality"

local currentFormat = GetCVar(SCREENSHOT_FORMAT_CVAR) or GetCVarDefault(SCREENSHOT_FORMAT_CVAR)
local currentQuality = GetCVar(SCREENSHOT_QUALITY_CVAR) or GetCVarDefault(SCREENSHOT_QUALITY_CVAR)
currentQuality = tonumber(currentQuality)

L.optionsTable = {
    type = "group",
    args = {
        general = {
            type = "group",
            name = "Screenshot Options",
            order = 0,
            inline = true,
            args = {
                format = {
                    type = "select",
                    name = "Format",
                    desc = "The format WoW will use to save screenshots.",
                    order = 0,
                    values = {
                        ["jpg"] = "JPG",
                        ["tga"] = "TGA",
                    },
                    get = function() return currentFormat end,
                    set = function(_, value)
                        currentFormat = value
                        SetCVar(SCREENSHOT_FORMAT_CVAR, value)
                    end,

                },
                quality = {
                    type = "range",
                    name = "Quality",
                    desc = "Quality of screenshots. 10 is highest.",
                    order = 1,
                    min = 1,
                    max = 10,
                    step = 1,
                    get = function()
                        if currentFormat == "tga" then
                            return 10
                        else
                            return currentQuality
                        end
                    end,
                    set = function(_, value)
                       currentQuality = value 
                       SetCVar(SCREENSHOT_QUALITY_CVAR, value)
                    end,
                    disabled = function() return currentFormat == "tga" end
                },
                screenshot_info = {
                    type = "description",
                    name = "Settings aren't saved to Config.wtf until the game is exited.",
                    order = 2,
                },
            },
        },
        info = {
            type = "group",
            name = "Info",
            order = 1,
            inline = true,
            args = {
                addon_text = {
                    type = "description",
                    order = 0,
                    name = ("%s v%s by %s"):format(_, GetAddOnMetadata(_, "Version"), GetAddOnMetadata(_, "Author")),
                },
                other_text = {
                    type = "description",
                    order = 1,
                    name = 
[[WoW has only two formats available for screenshots:
TGA, a lossless format, meaning large file sizes but no quality reduction. (~7MB for 1080p)
JPEG, which has variable compression, meaning lower file sizes but lower quality. (~3MB for 1080p at a quality of 10)

By default WoW uses JPEG with a quality of 3.
    
Souce code available at https://github.com/camas/EventScreenshot]],
                },
            },
        },
    },
}
