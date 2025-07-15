ActionMouse = ActionMouse or {}

ActionMouse.isMapOpen = false

WorldMapFrame:HookScript("OnShow", function()
	ActionMouse.isMapOpen = true
	if ActionMouseSettings.AutoStopMap then
		ActionMouse.Deactivate()
	end
end)
WorldMapFrame:HookScript("OnHide", function()
	ActionMouse.isMapOpen = false
	if ActionMouseSettings.AutoStartMap then
		ActionMouse.Activate()
	end
end)