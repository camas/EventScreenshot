EventScreenshot = LibStub("AceAddon-3.0"):NewAddon("EventScreenshot", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0", "AceBucket-3.0")

local ACHIEVEMENT_DELAY = 1.2
local PRINT_DELAY = 0.2

function EventScreenshot:OnInitialize()
	-- Achievement event bucketed so only one screenshot is taken for multiple achievements at the same time
	self:RegisterBucketEvent({"ACHIEVEMENT_EARNED"}, ACHIEVEMENT_DELAY, "AchievementEarned")
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
		self:TakeScreenshot("Achievement: " .. achvName)
	else
		self:TakeScreenshot(totalCount .. " achievements.")
	end
end

--- Takes a screenshot and prints a message to the console
-- @param message The message to print
-- @param[opt=0] delay The delay in seconds before taking the screenshot.
function EventScreenshot:TakeScreenshot(message, delay)
	delay = delay or 0
	Screenshot()
	-- Delayed so doesn't show up in screenshot
	self:DelayedPrint("Took screenshot for " .. message, PRINT_DELAY)
end

function EventScreenshot:DelayedPrint(message, delay)
	self:ScheduleTimer("Print", delay, message)
end