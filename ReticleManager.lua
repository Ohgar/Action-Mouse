ActionMouse = ActionMouse or {}

ActionMouse.reticleButton = CreateFrame("Button", "ClickButton", UIParent, "SecureActionButtonTemplate")

--CLICK RETICLE
function ActionMouse.SetClickReticle()
	ActionMouse.reticleButton:SetSize(ActionMouseSettings.sSlider, ActionMouseSettings.sSlider)
	ActionMouse.reticleButton:SetPoint("CENTER", UIParent, "CENTER", ActionMouseSettings.crSliderX, ActionMouseSettings.crSliderY)
	ActionMouse.reticleButton:SetNormalTexture("Interface\\AddOns\\ActionMouse\\action_mouse_reticle.png")
	ActionMouse.reticleButton:SetScript("OnClick", function()
		ActionMouse.isMenuOpen = false
		ActionMouse.isRetVis = true
		ActionMouse.Activate()
		if ActionMouseSettings.HideRet then
			--ActionMouse.reticleButton:Hide()
			ActionMouse.reticleButton:SetAlpha(0)
			ActionMouse.isRetVis = false
		end
	end)	
end

function ActionMouse.CheckSetRetVis()
	if ActionMouseSettings.Click and ActionMouseSettings.HideRet then		
		if not IsMouselooking() and not ActionMouse.isRetVis then
			--ActionMouse.reticleButton:Show()
			ActionMouse.reticleButton:SetAlpha(1)
			ActionMouse.isRetVis = true
		end
	end
end

--CURSOR RETICLE
function ActionMouse.SetCursorReticle(xPos, yPos)
    local uiScale = UIParent:GetEffectiveScale()
    local uiCenterX, uiCenterY = UIParent:GetCenter()
    local cursorX = (xPos / uiScale) - uiCenterX
    local cursorY = (yPos / uiScale) - uiCenterY
	ActionMouse.reticleButton:SetSize(ActionMouseSettings.sSlider, ActionMouseSettings.sSlider)
	ActionMouse.reticleButton:SetPoint("CENTER", UIParent, "CENTER", cursorX, cursorY)
	ActionMouse.reticleButton:SetNormalTexture("Interface\\AddOns\\ActionMouse\\action_mouse_reticle.png")
	ActionMouse.reticleButton:Show()
end