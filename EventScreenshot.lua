local _, L = ...

local EV_ADDON_NAME = "EventScreenshot"
local EV_SHORT_NAME = "EV"
local ACHIEVEMENT_DELAY = 1.2 -- Delay in seconds before screenshot taken after achievements
local PRINT_DELAY = 0.2 -- Delay in seconds message printed to screen after screenshot.

EventScreenshot = LibStub("AceAddon-3.0"):NewAddon(EV_ADDON_NAME, "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0", "AceBucket-3.0")

function EventScreenshot:OnInitialize()
	-- Achievement event bucketed so only one screenshot is taken when multiple achievements earned at the same time.
	self:RegisterBucketEvent({"ACHIEVEMENT_EARNED"}, ACHIEVEMENT_DELAY, "AchievementEarned")

	-- Register config and add logo to it. (Logo code shamelessly appropriated from Immersion)
	-- https://www.curseforge.com/wow/addons/immersion
	LibStub("AceConfig-3.0"):RegisterOptionsTable(EV_ADDON_NAME, L.optionsTable)
	L.configGUI = LibStub("AceConfigDialog-3.0"):AddToBlizOptions(_)
	local logo = CreateFrame('Frame', nil, L.configGUI, "BackdropTemplate")
	logo:SetFrameLevel(4)
	logo:SetSize(64, 64)
	logo:SetPoint("TopRight", 4, 24)
	logo:SetBackdrop({bgFile = ("Interface\\Addons\\%s\\Logo-64x64.tga"):format(_)})
	L.configGUI.logo = logo

	self:Print("enabled.")
end

function EventScreenshot:AchievementEarned(achvIds)
	local totalCount = 0
	for id, count in pairs(achvIds) do
		totalCount = totalCount + count
	end
	
	if totalCount == 1 then
		local key, value = next(achvIds, nil)
		local _, achvName = GetAchievementInfo(key)
		self:TakeScreenshot("Achievement: " .. achvName .. ".")
	else
		self:TakeScreenshot(totalCount .. " achievements.")
	end
end

--- Takes a screenshot and prints a message to the console
-- @param message The message to print
function EventScreenshot:TakeScreenshot(message)
	Screenshot()
	-- Delayed so doesn't show up in screenshot
	self:DelayedPrint("Took screenshot for " .. message, PRINT_DELAY)
end

function EventScreenshot:DelayedPrint(message, delay)
	self:ScheduleTimer("Print", delay, message)
end