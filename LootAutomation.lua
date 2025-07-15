ActionMouse = ActionMouse or {}

ActionMouse.isLootOpen = false

local frame = CreateFrame("Frame")
	frame:RegisterEvent("LOOT_READY")
	frame:RegisterEvent("LOOT_CLOSED")
	
	frame:SetScript("OnEvent", function(self, event, ...)
		if event == "LOOT_READY" then
			ActionMouse.isLootOpen = true;
		elseif event == "LOOT_CLOSED" then
			ActionMouse.isLootOpen = false;			
		end
end)