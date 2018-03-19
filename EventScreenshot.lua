EventScreenshot = LibStub("AceAddon-3.0"):NewAddon("EventScreenshot", "AceConsole-3.0", "AceEvent-3.0")

function EventScreenshot:OnInitialize()
	self:RegisterEvent("ACHIEVEMENT_EARNED")
	self:Print("EventScreenshot enabled.")
end

function EventScreenshot:ACHIEVEMENT_EARNED(achvId)
	local achvName = select(2, GetAchievementInfo(achvId))
	self:TakeScreenshot("Achievement: " .. name)
end

function EventScreenshot:TakeScreenshot(message)
	Screenshot()
	self:Print("Took screenshot for " .. message)
end