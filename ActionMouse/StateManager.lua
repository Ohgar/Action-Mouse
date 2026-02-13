ActionMouse = ActionMouse or {}

ActionMouse.isActive = false

--AUTO START STATE
function ActionMouse.GetAutoStartState()
	if ActionMouseSettings.AutoStartBags or
		ActionMouseSettings.AutoStartMap or
		ActionMouseSettings.AutoStartPanels or
		ActionMouseSettings.AutoStartPopups then
		return true
	else
		return false
	end
end

--UI STATE BY FRAME (excluding menu)
function ActionMouse.GetFrameOpenState()
	if (MailFrame and MailFrame:IsShown()) or
		(CollectionsJournal and CollectionsJournal:IsShown()) then
		return true
	else
		return false
	end
end

--UI OPEN STATE (excluding menu)
function ActionMouse.GetUIOpenState()
	if ActionMouse.isBagOpen or
		ActionMouse.isMapOpen or
		ActionMouse.isPanelOpen or
		ActionMouse.isPopupOpen then
		return true
	else
		return false
	end
end

--SET UI STATE
function ActionMouse.SetUIState(flag)
	ActionMouse.isBagOpen = flag
	ActionMouse.isMenuOpen = flag
	ActionMouse.isPanelOpen = flag
	ActionMouse.isPopupOpen = flag
end