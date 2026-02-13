ActionMouse = ActionMouse or {}

--IsKeybound()
local function IsKeybound(name)
    local keybind = GetBindingKey(name)
    if keybind then
        return true
    else
        return false
    end
end

--SET CURSOR RETICLE
local function SetCursorRet()
	local cursorX, cursorY = GetCursorPosition()

	ActionMouse.SetCursorReticle(cursorX, cursorY)

	MouselookStart()

	if not ActionMouse.isCombat then ActionMouse.ReticleButton:SetAlpha(1) end

	if ActionMouseSettings.HideRet then
		ActionMouse.ReticleButton:Hide()
	end

	ActionMouse.ReticleButton:EnableMouse(true)
end

--TOGGLE KEYBIND ACTIVATION
function ActionMouse.ToggleKeybindActivation()
	if ActionMouseSettings.Keybind and IsMouselooking() then
		ActionMouse.isActive = false
		if ActionMouse.isCombat then
			ActionMouse.ReticleButton:SetAlpha(0)			
		else
			ActionMouse.ReticleButton:Hide()
		end		
		MouselookStop()
	elseif ActionMouseSettings.Keybind and not IsMouselooking() then
		ActionMouse.SetUIState(false)
		ActionMouse.isActive = true
		SetCursorRet()
	end
end

--ACTIVATE
function ActionMouse.Activate()
	if (ActionMouse.isLootOpen and ActionMouseSettings.LootLock) or not ActionMouse.GetUIOpenState() then
		ActionMouse.isActive = true
		MouselookStart()	
	end	

	if ActionMouseSettings.Keybind and ActionMouseSettings.HideRet then
		ActionMouse.ReticleButton:Hide()		
	elseif ActionMouseSettings.Keybind then
		SetCursorRet()
	end
end

--DEACTIVATE
function ActionMouse.Deactivate()
	MouselookStop()
	ActionMouse.isActive = false	

	if ActionMouseSettings.Click then
		ActionMouse.ReticleButton:Show()
	end

	if ActionMouseSettings.Keybind then
		ActionMouse.ReticleButton:Hide()
	end
end

--PLAYER ENTERING WORLD
local onEnterWorld = CreateFrame("Frame")
onEnterWorld:RegisterEvent("PLAYER_ENTERING_WORLD")
onEnterWorld:RegisterEvent("PLAYER_LOGOUT")
onEnterWorld:SetScript("OnEvent", function(self, event, ...)
	ActionMouse.isMenuOpen = false
	if event == "PLAYER_ENTERING_WORLD" then
		if ActionMouseSettings.Click then
			ActionMouse.SetClickReticle(false) --counters something preventing display of reticle
		end

		if ActionMouseSettings.Keybind and not ActionMouseSettings.HideRet then
			SetCursorRet()
			ActionMouse.Activate()

			if not ActionMouseSettings.MouselookOnEnterWorld then
				ActionMouse.Deactivate()
			end
		end

	elseif event == "PLAYER_LOGOUT" then
		ActionMouse.Deactivate()
	end
	
end)

--PREVENT RIGHT CLICK EXIT
local function PreventRightClick()
	if ActionMouseSettings.Keybind and ActionMouse.isActive and not IsMouselooking() then
		ActionMouse.ToggleKeybindActivation()
	end
end


--UPDATE
local update = CreateFrame("Frame")
update:SetScript("OnUpdate", function(self,elapsed)	
	PreventRightClick()
	ActionMouse.CheckSetRetVis()
end)