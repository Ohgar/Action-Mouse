ActionMouse = ActionMouse or {}

ActionMouse.isPanelOpen = false
ActionMouse.isMenuOpen = false

local function StopOnOpen()
	if ActionMouseSettings.AutoStopPanels and IsMouselooking() and ActionMouse.isPanelOpen then		
		--print("STOP ON OPEN UI")
		ActionMouse.Deactivate()				
		if ActionMouse.isLootOpen and ActionMouseSettings.LootLock then
			--print("LOOT LOCK")
			ActionMouse.Activate()			
		end
	end
end

local function StartOnClose()
	if ActionMouseSettings.AutoStartPanels and not IsMouselooking() and not ActionMouse.isPanelOpen and not ActionMouse.GetFrameOpenState() then
		--print("START ON CLOSE UI")
		ActionMouse.Activate()		
	end
end

--LISTEN FOR ESC KEY
local keyInput = CreateFrame("Frame", nil, UIParent)
keyInput:SetPropagateKeyboardInput(true)
keyInput:EnableKeyboard(true)

keyInput:SetScript("OnKeyDown", function(self, key)
	if key == "ESCAPE" and GameMenuFrame:IsShown() then
		ActionMouse.isMenuOpen = false
		--print("MENU CLOSED WITH ESC")
	elseif key == "ESCAPE" and not GameMenuFrame:IsShown() and not ActionMouse.GetUIOpenState() and not ActionMouse.GetFrameOpenState() then
		ActionMouse.isMenuOpen = true

		--print("isMenuOpen = : " .. tostring(ActionMouse.isMenuOpen))
		--print("MENU OPENED WITH ESC")
	end

	if key == "ESCAPE" and ActionMouseSettings.AutoStartPanels then
		if ActionMouse.isPanelOpen then
			ActionMouse.isPanelOpen = false
		end
		
		if not ActionMouse.GetUIOpenState() and not ActionMouse.GetFrameOpenState() then
			StartOnClose()
		end
		--print("UI CLOSED WITH ESC")
	end	
end)

--ON SHOW UI
hooksecurefunc("ShowUIPanel", function(...)
	if ActionMouse.isMenuOpen then
		ActionMouse.Deactivate()
	else
		ActionMouse.isPanelOpen = true
		StopOnOpen()
		--print("UI OPENED")
	end	    
end)

--ON HIDE UI
hooksecurefunc("HideUIPanel", function(...)
	if not ActionMouse.isMenuOpen then
		ActionMouse.isPanelOpen = false
		StartOnClose()
		--print("UI CLOSED")
	end
end)


