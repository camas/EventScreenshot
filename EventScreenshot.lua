EventScreenshot = LibStub("AceAddon-3.0"):NewAddon("EventScreenshot", "AceConsole-3.0", "AceEvent-3.0")

function EventScreenshot:OnInitialize()
	self:RegisterEvent("ACHIEVEMENT_EARNED")
	self:Print("enabled.")
end

function EventScreenshot:ACHIEVEMENT_EARNED(event, achvId)
	local _, name = GetAchievementInfo(achvId)
	self:TakeScreenshot("Achievement: " .. name)
end

function EventScreenshot:TakeScreenshot(message)
	Screenshot()
	self:Print("Took screenshot for " .. message)
end