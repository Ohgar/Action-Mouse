ActionMouse = ActionMouse or {}

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_DEAD")
frame:SetScript("OnEvent", function(self, event)
    --print("DEAD")
end)

