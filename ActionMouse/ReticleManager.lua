ActionMouse = ActionMouse or {}

ActionMouse.ReticleButton = CreateFrame("Button", "ClickButton", UIParent, "SecureActionButtonTemplate")

--CLICK RETICLE
function ActionMouse.SetClickReticle()
	ActionMouse.ReticleButton:SetSize(ActionMouseSettings.sSlider, ActionMouseSettings.sSlider)

	ActionMouse.ReticleButton:SetPoint("CENTER", UIParent, "CENTER", ActionMouseSettings.crSliderX, ActionMouseSettings.crSliderY)

	ActionMouse.ReticleButton:SetNormalTexture("Interface\\AddOns\\ActionMouse\\action_mouse_reticle.png")

	ActionMouse.ReticleButton:SetScript("OnClick", function()
		ActionMouse.isMenuOpen = false
		ActionMouse.isRetVis = true
		ActionMouse.Activate()

		if ActionMouseSettings.HideRet then
			ActionMouse.ReticleButton:SetAlpha(0)
			ActionMouse.isRetVis = false
		end
	end)	
end

function ActionMouse.CheckSetRetVis()
	if ActionMouseSettings.Click and ActionMouseSettings.HideRet then		
		if not IsMouselooking() and not ActionMouse.isRetVis then
			ActionMouse.ReticleButton:SetAlpha(1)
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
	ActionMouse.ReticleButton:SetSize(ActionMouseSettings.sSlider, ActionMouseSettings.sSlider)
	ActionMouse.ReticleButton:SetPoint("CENTER", UIParent, "CENTER", cursorX, cursorY)
	ActionMouse.ReticleButton:SetNormalTexture("Interface\\AddOns\\ActionMouse\\action_mouse_reticle.png")
	ActionMouse.ReticleButton:Show()
end