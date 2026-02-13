ActionMouse = ActionMouse or {}

--MOUNT DETECTION
local vMountIds = {122708, 61447, 61425, 264058, 366962}

local frame = CreateFrame("Frame")
frame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")

frame:SetScript("OnEvent", function(self, event, ...)
    local unit, castGUID, spellID = ...

    if event == "UNIT_SPELLCAST_SUCCEEDED" and unit == "player" and ActionMouseSettings.VendorMountStop then
	    for i = 1, #vMountIds do
			if spellID == vMountIds[i] then
				ActionMouse.Deactivate()
			end
		end
	end
end)
