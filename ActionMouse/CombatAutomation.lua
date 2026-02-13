ActionMouse = ActionMouse or {}

ActionMouse.isCombat = false

--CHECKS REGEN TO DETECT COMBAT
local regenFrame = CreateFrame("Frame")
regenFrame:RegisterEvent("PLAYER_REGEN_DISABLED") -- Entering combat
regenFrame:RegisterEvent("PLAYER_REGEN_ENABLED") -- Exiting combat
regenFrame:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_REGEN_DISABLED" then
		ActionMouse.isCombat = true
		if ActionMouseSettings.Keybind then
			ActionMouse.ReticleButton:EnableMouse(false)
		end
		if ActionMouseSettings.AutoStopCombat and IsMouselooking() then
			ActionMouse.Deactivate()
		end		
    elseif event == "PLAYER_REGEN_ENABLED" then		
		ActionMouse.isCombat = false
		if ActionMouseSettings.Keybind then			
		end
		if ActionMouseSettings.AutoStartCombat and not IsMouselooking() then
			ActionMouse.Activate()
		end		
    end
	ActionMouse.CheckSetRetVis()
end)