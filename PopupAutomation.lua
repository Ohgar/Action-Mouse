ActionMouse = ActionMouse or {}

ActionMouse.isPopupOpen = false

local function StopOnOpen()
	if ActionMouseSettings.AutoStopPopups and IsMouselooking() and ActionMouse.isPopupOpen then
		ActionMouse.Deactivate()
	end	
end

local function StartOnClose()
	if ActionMouseSettings.AutoStartPopups and not IsMouselooking() then
		ActionMouse.Activate()
	end
end

--STATIC POPUP DETECTION
hooksecurefunc("StaticPopup_Show", function()
	ActionMouse.isPopupOpen = true
	StopOnOpen()
	--print("POPUP OPENED")
end)

hooksecurefunc("StaticPopup_OnClick", function()
	ActionMouse.isPopupOpen = false
	if not ActionMouse.GetUIOpenState() or ActionMouse.GetFrameOpenState() then
		StartOnClose()
	end
	--print("POPUP CLOSED")
end)

--LISTEN FOR ESC KEY
local keyInput = CreateFrame("Frame", nil, UIParent)
keyInput:SetPropagateKeyboardInput(true)
keyInput:EnableKeyboard(true)

keyInput:SetScript("OnKeyDown", function(self, key)	
	if key == "ESCAPE" and ActionMouseSettings.AutoStartPopups then
		if ActionMouse.isPopupOpen then
			ActionMouse.isPopupOpen = false
		end
		
		if not ActionMouse.GetUIOpenState() and not ActionMouse.GetFrameOpenState() then
			StartOnClose()
		end
	end	
end)