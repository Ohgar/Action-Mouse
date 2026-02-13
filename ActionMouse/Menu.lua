ActionMouse = ActionMouse or {}
	
local mFrame = CreateFrame("Frame", "ActionMouseMenu", UIParent)
mFrame.name = "Action Mouse"

local mTitle = mFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalHuge")
mTitle:SetPoint("TOPLEFT", 16, -16)

local category = Settings.RegisterCanvasLayoutCategory(mFrame, "Action Mouse")
Settings.RegisterAddOnCategory(category)

ActionMouse.isMenuOpen = false

SLASH_ACTIONMOUSE1 = "/actionmouse"
SlashCmdList["ACTIONMOUSE"] = function()
    Settings.OpenToCategory(category:GetID())
end

------------------------------------------------------------Play Style
local psTipsX = -25
local psTipsY = -65

local function CreateClickReticleCheckbox(posX, posY)
    local crCheckbox = CreateFrame("CheckButton", "crCheckbox", mFrame, "ChatConfigCheckButtonTemplate")

	crCheckbox:SetPoint("TOPLEFT", mTitle, "BOTTOMLEFT", posX, posY)
    crCheckbox.Text:SetText("Click Reticle")

    if ActionMouseSettings.Click == nil then
	    ActionMouseSettings.Click = true
	end
    
    crCheckbox:SetChecked(ActionMouseSettings.Click)

    crCheckbox:SetScript("OnClick", function(self)
        ActionMouse.isMenuOpen = false

        kbCheckbox:SetChecked(false)
        ActionMouseSettings.Keybind = false
        startBagsCheckbox:SetChecked(false)
        ActionMouseSettings.AutoStartBags = false
        startMapCheckbox:SetChecked(false)
        ActionMouseSettings.AutoStartMap = false
        startPanelsCheckbox:SetChecked(false)
        ActionMouseSettings.AutoStartPanels = false
        startPopupsCheckbox:SetChecked(false)
        ActionMouseSettings.AutoStartPopups = false
        startCombatCheckbox:SetChecked(false)
        ActionMouseSettings.AutoStartCombat = false
        startEnterWorldCheckbox:SetChecked(false)
        ActionMouseSettings.MouselookOnEnterWorld = false

        self:SetChecked(true)
        ActionMouseSettings.Click = true

        ActionMouse.SetClickReticle()
        ActionMouse.ReticleButton:Show()
	end)

    crCheckbox:SetScript("OnEnter", function(self)
        GameTooltip:Hide()
        GameTooltip:SetOwner(UIParent, "ANCHOR_NONE")
        GameTooltip:SetPoint("TOP", mFrame, "TOP", psTipsX, psTipsY)
        GameTooltip:SetText("-Enables a fixed reticle button.\n-Left click the reticle to activate, right click to exit.")
        GameTooltip:Show()
    end)

    crCheckbox:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)
        
    crCheckbox:SetHitRectInsets(0, -80, 0, 0)
end

local function CreateUseKeybindCheckbox(posX, posY)
    local kbCheckbox = CreateFrame("CheckButton", "kbCheckbox", mFrame, "ChatConfigCheckButtonTemplate")

    kbCheckbox:SetPoint("TOPLEFT", mTitle, "BOTTOMLEFT", posX, posY)
    kbCheckbox.Text:SetText("Keybind")

    if ActionMouseSettings.Keybind == nil then
	    ActionMouseSettings.Keybind = false
	end

    kbCheckbox:SetChecked(ActionMouseSettings.Keybind)

    kbCheckbox:SetScript("OnClick", function(self)
        crCheckbox:SetChecked(false)
        ActionMouseSettings.Click = false
        self:SetChecked(true)
        ActionMouseSettings.Keybind = true
        ActionMouse.Deactivate()
	end)

    kbCheckbox:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(UIParent, "ANCHOR_NONE")
        GameTooltip:SetPoint("TOP", mFrame, "TOP", psTipsX, psTipsY)
        GameTooltip:SetText("-Use a custom keybind to start and stop mouselook.\n-ESC > Options > Keybindings > Action Mouse.")
        GameTooltip:Show()
    end)

    kbCheckbox:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)

    kbCheckbox:SetHitRectInsets(0, -80, 0, 0)
end

-------------------------------------------------------------RETICLE SETTINGS
local function CreateHideReticleCheckbox(posX, posY)
    local hrCheckbox = CreateFrame("CheckButton", "hrCheckbox", mFrame, "ChatConfigCheckButtonTemplate")
    hrCheckbox:SetPoint("TOPLEFT", mTitle, "BOTTOMLEFT", posX, posY)
    hrCheckbox.Text:SetText("Hide Reticle On Mouselook")
    local isChecked
    if ActionMouseSettings.HideRet == nil then
        ActionMouseSettings.HideRet = false
	end
    isChecked = ActionMouseSettings.HideRet
    hrCheckbox:SetChecked(isChecked)
    hrCheckbox:SetScript("OnClick", function(self)
        isChecked = self:GetChecked()
        ActionMouseSettings.HideRet = isChecked
	end)
end

----------------------------------------AUTOMATION
local autoTipsX = -20
local autoTipsY = -185

local function CreateStopBagsCheckbox(xPos, yPos, tipText)
    local stopBagsCheckbox = CreateFrame("CheckButton", "stopBagsCheckbox", mFrame, "ChatConfigCheckButtonTemplate")

    stopBagsCheckbox:SetPoint("TOPLEFT", mTitle, "BOTTOMLEFT", xPos, yPos)

    if ActionMouseSettings.AutoStopBags == nil then
        ActionMouseSettings.AutoStopBags = false
	end

	stopBagsCheckbox:SetChecked(ActionMouseSettings.AutoStopBags)

	stopBagsCheckbox:SetScript("OnClick", function(self)
        ActionMouseSettings.AutoStopBags = self:GetChecked()
    end)

    stopBagsCheckbox:SetScript("OnEnter", function(self)
        GameTooltip:Hide()
        GameTooltip:SetOwner(UIParent, "ANCHOR_NONE")
        GameTooltip:SetPoint("CENTER", mFrame, "CENTER", autoTipsX, autoTipsY)
        GameTooltip:SetText(tipText)
        GameTooltip:Show()
    end)

    stopBagsCheckbox:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)

    stopBagsCheckbox:SetHitRectInsets(0, 0, 0, 0)
end

local function CreateStopMapCheckbox(xPos, yPos, tipText)
    local stopMapCheckbox = CreateFrame("CheckButton", "stopMapCheckbox", mFrame, "ChatConfigCheckButtonTemplate")

    stopMapCheckbox:SetPoint("TOPLEFT", mTitle, "BOTTOMLEFT", xPos, yPos)

    if ActionMouseSettings.AutoStopMap == nil then
	    ActionMouseSettings.AutoStopMap = false
	end

    stopMapCheckbox:SetChecked(ActionMouseSettings.AutoStopMap)

    stopMapCheckbox:SetScript("OnClick", function(self)
        ActionMouseSettings.AutoStopMap = self:GetChecked()
	end)

    stopMapCheckbox:SetScript("OnEnter", function(self)
        GameTooltip:Hide()
        GameTooltip:SetOwner(UIParent, "ANCHOR_NONE")
        GameTooltip:SetPoint("CENTER", mFrame, "CENTER", autoTipsX, autoTipsY)
        GameTooltip:SetText(tipText)
        GameTooltip:Show()
    end)

    stopMapCheckbox:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)

    stopMapCheckbox:SetHitRectInsets(0,0,0,0)
end

local function CreateStopPanelsCheckbox(xPos,yPos, tipText)
    local stopPanelsCheckbox = CreateFrame("CheckButton", "stopPanelsCheckbox", mFrame, "ChatConfigCheckButtonTemplate")

    stopPanelsCheckbox:SetPoint("TOPLEFT",mTitle,"BOTTOMLEFT",xPos,yPos)

    if ActionMouseSettings.AutoStopPanels == nil then
        ActionMouseSettings.AutoStopPanels = false
	end

    stopPanelsCheckbox:SetChecked(ActionMouseSettings.AutoStopPanels)

    stopPanelsCheckbox:SetScript("OnClick", function(self)
        ActionMouseSettings.AutoStopPanels = self:GetChecked()
	end)

    stopPanelsCheckbox:SetScript("OnEnter", function(self)
        GameTooltip:Hide()
        GameTooltip:SetOwner(UIParent, "ANCHOR_NONE")
        GameTooltip:SetPoint("CENTER", mFrame, "CENTER", autoTipsX, autoTipsY)
        GameTooltip:SetText(tipText)
        GameTooltip:Show()
    end)

    stopPanelsCheckbox:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)

    stopPanelsCheckbox:SetHitRectInsets(0,0,0,0)
end

local function CreateStopPopupsCheckbox(xPos,yPos, tipText)
    local stopPopupsCheckbox = CreateFrame("CheckButton","stopPopupsCheckbox",mFrame,"ChatConfigCheckButtonTemplate")

    stopPopupsCheckbox:SetPoint("TOPLEFT",mTitle,"BOTTOMLEFT",xPos,yPos)

    if ActionMouseSettings.AutoStopPopups == nil then
	    ActionMouseSettings.AutoStopPopups = false
	end

    stopPopupsCheckbox:SetChecked(ActionMouseSettings.AutoStopPopups)

    stopPopupsCheckbox:SetScript("OnClick",function(self)
		ActionMouseSettings.AutoStopPopups = self:GetChecked()
	end)

    stopPopupsCheckbox:SetScript("OnEnter", function(self)
        GameTooltip:Hide()
        GameTooltip:SetOwner(UIParent, "ANCHOR_NONE")
        GameTooltip:SetPoint("CENTER", mFrame, "CENTER", autoTipsX, autoTipsY)
        GameTooltip:SetText(tipText)
        GameTooltip:Show()
    end)

    stopPopupsCheckbox:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)

    stopPopupsCheckbox:SetHitRectInsets(0,0,0,0)
end

local function CreateStopCombatCheckbox(xPos,yPos, tipText)
    local stopCombatCheckbox = CreateFrame("CheckButton","stopCombatCheckbox",mFrame,"ChatConfigCheckButtonTemplate")

    stopCombatCheckbox:SetPoint("TOPLEFT",mTitle,"BOTTOMLEFT",xPos,yPos)

    if ActionMouseSettings.AutoStopCombat == nil then
	    ActionMouseSettings.AutoStopCombat = false
	end

    stopCombatCheckbox:SetChecked(ActionMouseSettings.AutoStopCombat)

    stopCombatCheckbox:SetScript("OnClick",function(self)
		ActionMouseSettings.AutoStopCombat = self:GetChecked()
	end)

    stopCombatCheckbox:SetScript("OnEnter", function(self)
        GameTooltip:Hide()
        GameTooltip:SetOwner(UIParent, "ANCHOR_NONE")
        GameTooltip:SetPoint("CENTER", mFrame, "CENTER", autoTipsX, autoTipsY)
        GameTooltip:SetText(tipText)
        GameTooltip:Show()
    end)

    stopCombatCheckbox:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)

    stopCombatCheckbox:SetHitRectInsets(0,0,0,0)
end

local function CreateStopVendorMountCheckbox(xPos,yPos, tipText)
    local stopVendorMountCheckbox = CreateFrame("CheckButton", "stopVendorMountCheckbox", mFrame, "ChatConfigCheckButtonTemplate")

    stopVendorMountCheckbox:SetPoint("TOPLEFT", mTitle, "BOTTOMLEFT", xPos, yPos)

    if ActionMouseSettings.VendorMountStop == nil then
        ActionMouseSettings.VendorMountStop = false
	end

    stopVendorMountCheckbox:SetChecked(ActionMouseSettings.VendorMountStop)

    stopVendorMountCheckbox:SetScript("OnClick",function(self)
        ActionMouseSettings.VendorMountStop = self:GetChecked()
	end)

    stopVendorMountCheckbox:SetScript("OnEnter", function(self)
        GameTooltip:Hide()
        GameTooltip:SetOwner(UIParent, "ANCHOR_NONE")
        GameTooltip:SetPoint("CENTER", mFrame, "CENTER", autoTipsX, autoTipsY)
        GameTooltip:SetText(tipText)
        GameTooltip:Show()
    end)

    stopVendorMountCheckbox:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)

    stopVendorMountCheckbox:SetHitRectInsets(0,0,0,0)
end

local function CreateStartBagsCheckbox(xPos, yPos, tipText)
    local startBagsCheckbox = CreateFrame("CheckButton", "startBagsCheckbox", mFrame, "ChatConfigCheckButtonTemplate")

    startBagsCheckbox:SetPoint("TOPLEFT", mTitle, "BOTTOMLEFT", xPos, yPos)

    if ActionMouseSettings.AutoStartBags == nil then
        ActionMouseSettings.AutoStartBags = false
	end

	startBagsCheckbox:SetChecked(ActionMouseSettings.AutoStartBags)

	startBagsCheckbox:SetScript("OnClick", function(self)
        if ActionMouseSettings.Click then
            self:SetChecked(false)
            ActionMouseSettings.AutoStartBags = false
        else
            ActionMouseSettings.AutoStartBags = self:GetChecked()
        end
    end)

    startBagsCheckbox:SetScript("OnEnter", function(self)
        GameTooltip:Hide()
        GameTooltip:SetOwner(UIParent, "ANCHOR_NONE")
        GameTooltip:SetPoint("CENTER", mFrame, "CENTER", autoTipsX, autoTipsY)
        GameTooltip:SetText(tipText)
        GameTooltip:Show()
    end)

    startBagsCheckbox:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)

    startBagsCheckbox:SetHitRectInsets(0,0,0,0)
end

--START MAP CHECKBOX
local function CreateStartMapCheckbox(xPos, yPos, tipText)
    local startMapCheckbox = CreateFrame("CheckButton", "startMapCheckbox", mFrame, "ChatConfigCheckButtonTemplate")

    startMapCheckbox:SetPoint("TOPLEFT", mTitle, "BOTTOMLEFT", xPos, yPos)

    if ActionMouseSettings.AutoStartMap == nil then
        ActionMouseSettings.AutoStartMap = false
	end

    startMapCheckbox:SetChecked(ActionMouseSettings.AutoStartMap)

    startMapCheckbox:SetScript("OnClick", function(self)
	    if ActionMouseSettings.Click then
            self:SetChecked(false)
            ActionMouseSettings.AutoStartMap = false
        else
            ActionMouseSettings.AutoStartMap = self:GetChecked()
        end
	end)

    startMapCheckbox:SetScript("OnEnter", function(self)
        GameTooltip:Hide()
        GameTooltip:SetOwner(UIParent, "ANCHOR_NONE")
        GameTooltip:SetPoint("CENTER", mFrame, "CENTER", autoTipsX, autoTipsY)
        GameTooltip:SetText(tipText)
        GameTooltip:Show()
    end)

    startMapCheckbox:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)

    startMapCheckbox:SetHitRectInsets(0,0,0,0)
end

--START PANELS CHECKBOX
local function CreateStartPanelsCheckbox(xPos,yPos, tipText)
    local startPanelsCheckbox = CreateFrame("CheckButton", "startPanelsCheckbox",mFrame,"ChatConfigCheckButtonTemplate")

    startPanelsCheckbox:SetPoint("TOPLEFT",mTitle,"BOTTOMLEFT",xPos,yPos)

    if ActionMouseSettings.AutoStartPanels == nil then
	    ActionMouseSettings.AutoStartPanels = false
	end

    startPanelsCheckbox:SetChecked(ActionMouseSettings.AutoStartPanels)

    startPanelsCheckbox:SetScript("OnClick",function(self)
	    if ActionMouseSettings.Click then
            self:SetChecked(false)
            ActionMouseSettings.AutoStartPanels = false
        else
            ActionMouseSettings.AutoStartPanels = self:GetChecked()
        end
	end)

    startPanelsCheckbox:SetScript("OnEnter", function(self)
        GameTooltip:Hide()
        GameTooltip:SetOwner(UIParent, "ANCHOR_NONE")
        GameTooltip:SetPoint("CENTER", mFrame, "CENTER", autoTipsX, autoTipsY)
        GameTooltip:SetText(tipText)
        GameTooltip:Show()
    end)

    startPanelsCheckbox:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)

    startPanelsCheckbox:SetHitRectInsets(0,0,0,0)
end

--START POPUPS CHECKBOX
local function CreateStartPopupsCheckbox(xPos,yPos, tipText)
    local startPopupsCheckbox = CreateFrame("CheckButton","startPopupsCheckbox",mFrame,"ChatConfigCheckButtonTemplate")

	startPopupsCheckbox:SetPoint("TOPLEFT",mTitle,"BOTTOMLEFT",xPos,yPos)

	if ActionMouseSettings.AutoStartPopups == nil then
	    ActionMouseSettings.AutoStartPopups = false
    end

	startPopupsCheckbox:SetChecked(ActionMouseSettings.AutoStartPopups)

	startPopupsCheckbox:SetScript("OnClick",function(self)
        if ActionMouseSettings.Click then
            self:SetChecked(false)
            ActionMouseSettings.AutoStartPopups = false
        else
            ActionMouseSettings.AutoStartPopups = self:GetChecked()
        end
	end)

    startPopupsCheckbox:SetScript("OnEnter", function(self)
        GameTooltip:Hide()
        GameTooltip:SetOwner(UIParent, "ANCHOR_NONE")
        GameTooltip:SetPoint("CENTER", mFrame, "CENTER", autoTipsX, autoTipsY)
        GameTooltip:SetText(tipText)
        GameTooltip:Show()
    end)

    startPopupsCheckbox:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)

	startPopupsCheckbox:SetHitRectInsets(0,0,0,0)
end

--START COMBAT CHECKBOX
local function CreateStartCombatCheckbox(xPos,yPos, tipText)
    local startCombatCheckbox = CreateFrame("CheckButton","startCombatCheckbox",mFrame,"ChatConfigCheckButtonTemplate")

	startCombatCheckbox:SetPoint("TOPLEFT",mTitle,"BOTTOMLEFT",xPos,yPos)

	if ActionMouseSettings.AutoStartCombat == nil then
	    ActionMouseSettings.AutoStartCombat = false
    end

	startCombatCheckbox:SetChecked(ActionMouseSettings.AutoStartCombat)

	startCombatCheckbox:SetScript("OnClick",function(self)
        if ActionMouseSettings.Click then
            self:SetChecked(false)
            ActionMouseSettings.AutoStartCombat = false
        else
            ActionMouseSettings.AutoStartCombat = self:GetChecked()
        end
	end)

    startCombatCheckbox:SetScript("OnEnter", function(self)
        GameTooltip:Hide()
        GameTooltip:SetOwner(UIParent, "ANCHOR_NONE")
        GameTooltip:SetPoint("CENTER", mFrame, "CENTER", autoTipsX, autoTipsY)
        GameTooltip:SetText(tipText)
        GameTooltip:Show()
    end)

    startCombatCheckbox:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)

	startCombatCheckbox:SetHitRectInsets(0,0,0,0)
end

--START ENTER WORLD
local function CreateEnterWorldCheckbox(xPos, yPos, tipText)
    local startEnterWorldCheckbox = CreateFrame("CheckButton", "startEnterWorldCheckbox", mFrame, "ChatConfigCheckButtonTemplate")

    startEnterWorldCheckbox:SetPoint("TOPLEFT", mTitle, "BOTTOMLEFT", xPos, yPos)

    if ActionMouseSettings.MouselookOnEnterWorld == nil then
        ActionMouseSettings.MouselookOnenterWorld = false
    end

    startEnterWorldCheckbox:SetChecked(ActionMouseSettings.MouselookOnEnterWorld)

    startEnterWorldCheckbox:SetScript("OnClick", function(self)
        if ActionMouseSettings.Click then
            self:SetChecked(false)
            ActionMouseSettings.MouselookOnEnterWorld = false
        else
            ActionMouseSettings.MouselookOnEnterWorld = self:GetChecked()
        end
    end)

    startEnterWorldCheckbox:SetScript("OnEnter", function(self)
        GameTooltip:Hide()
        GameTooltip:SetOwner(UIParent, "ANCHOR_NONE")
        GameTooltip:SetPoint("CENTER", mFrame, "CENTER", autoTipsX, autoTipsY)
        GameTooltip:SetText(tipText)
        GameTooltip:Show()
    end)

    startEnterWorldCheckbox:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)

    startEnterWorldCheckbox:SetHitRectInsets(0, 0, 0, 0)
end

--LOOT LOCK
local function CreateLootLockCheckbox(xPos,yPos, tipText)
    local lootCheckbox = CreateFrame("CheckButton", "lootCheckbox", mFrame, "ChatConfigCheckButtonTemplate")

    lootCheckbox:SetPoint("TOPLEFT",mTitle, "BOTTOMLEFT", xPos, yPos)

    if ActionMouseSettings.LootLock == nil then
        ActionMouseSettings.LootLock = false
	end

    lootCheckbox:SetChecked(ActionMouseSettings.LootLock)

    lootCheckbox:SetScript("OnClick",function(self)
        ActionMouseSettings.LootLock = self:GetChecked()
	end)

    lootCheckbox:SetScript("OnEnter", function(self)
        GameTooltip:Hide()
        GameTooltip:SetOwner(UIParent, "ANCHOR_NONE")
        GameTooltip:SetPoint("CENTER", mFrame, "CENTER", autoTipsX, autoTipsY)
        GameTooltip:SetText(tipText)
        GameTooltip:Show()
    end)

    lootCheckbox:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)

    lootCheckbox:SetHitRectInsets(0,0,0,0)
end

--Active Enemy Tips
local function CreateActiveEnemyTipsCheckbox(xPos, yPos, tipText)
    local activeEnemyTipscheckbox = CreateFrame("CheckButton", "activeEnemyTipsCheckbox", mFrame,
    "ChatConfigCheckButtonTemplate")

    activeEnemyTipsCheckbox:SetPoint("TOPLEFT", mTitle, "BOTTOMLEFT", xPos, yPos)
    
    if ActionMouseSettings.ActiveEnemyTips == nil then
        ActionMouseSettings.ActiveEnemyTips = false
    end
    
    activeEnemyTipsCheckbox:SetChecked(ActionMouseSettings.ActiveEnemyTips)

    activeEnemyTipsCheckbox:SetScript("OnClick", function(self)
        ActionMouseSettings.ActiveEnemyTips = self:GetChecked()
    end)

    activeEnemyTipsCheckbox:SetScript("OnEnter", function(self)
        GameTooltip:Hide()
        GameTooltip:SetOwner(UIParent, "ANCHOR_NONE")
        GameTooltip:SetPoint("CENTER", mFrame, "CENTER", autoTipsX, autoTipsY)
        GameTooltip:SetText(tipText)
        GameTooltip:Show()
    end)

    activeEnemyTipsCheckbox:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)

    activeEnemyTipsCheckbox:SetHitRectInsets(0,0,0,0)
end

--Soft Enemy Tips
local function CreateSoftEnemyTipsCheckbox(xPos, yPos, tipText)
    local softEnemyTipsCheckbox = CreateFrame("CheckButton", "softEnemyTipsCheckbox", mFrame,
    "ChatConfigCheckButtonTemplate")

    softEnemyTipsCheckbox:SetPoint("TOPLEFT", mTitle, "BOTTOMLEFT", xPos, yPos)
    
    if ActionMouseSettings.SoftEnemyTips == nil then
        ActionMouseSettings.SoftEnemyTips = false
    end
    
    softEnemyTipsCheckbox:SetChecked(ActionMouseSettings.SoftEnemyTips)

    softEnemyTipsCheckbox:SetScript("OnClick", function(self)
        ActionMouseSettings.SoftEnemyTips = self:GetChecked()
    end)

    softEnemyTipsCheckbox:SetScript("OnEnter", function(self)
        GameTooltip:Hide()
        GameTooltip:SetOwner(UIParent, "ANCHOR_NONE")
        GameTooltip:SetPoint("CENTER", mFrame, "CENTER", autoTipsX, autoTipsY)
        GameTooltip:SetText(tipText)
        GameTooltip:Show()
    end)

    softEnemyTipsCheckbox:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)

    softEnemyTipsCheckbox:SetHitRectInsets(0,0,0,0)
end

--Soft Interact Tips
local function CreateSoftInteractTipsCheckbox(xPos, yPos, tipText)
    local softInteractTipsCheckbox = CreateFrame("CheckButton", "softInteractTipsCheckbox", mFrame,
    "ChatConfigCheckButtonTemplate")

    softInteractTipsCheckbox:SetPoint("TOPLEFT", mTitle, "BOTTOMLEFT", xPos, yPos)
    
    if ActionMouseSettings.SoftInteractTips == nil then
        ActionMouseSettings.SoftInteractTips = false
    end
    
    softInteractTipsCheckbox:SetChecked(ActionMouseSettings.SoftInteractTips)

    softInteractTipsCheckbox:SetScript("OnClick", function(self)
        ActionMouseSettings.SoftInteractTips = self:GetChecked()
    end)

    softInteractTipsCheckbox:SetScript("OnEnter", function(self)
        GameTooltip:Hide()
        GameTooltip:SetOwner(UIParent, "ANCHOR_NONE")
        GameTooltip:SetPoint("CENTER", mFrame, "CENTER", autoTipsX, autoTipsY)
        GameTooltip:SetText(tipText)
        GameTooltip:Show()
    end)

    softInteractTipsCheckbox:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)

    softInteractTipsCheckbox:SetHitRectInsets(0,0,0,0)
end

--Soft Portals tips
local function CreateSoftPortalTipsCheckbox(xPos, yPos, tipText)
    local softPortalTipsCheckbox = CreateFrame("CheckButton", "softPortalsTipCheckbox", mFrame,
    "ChatConfigCheckButtonTemplate")

    softPortalTipsCheckbox:SetPoint("TOPLEFT", mTitle, "BOTTOMLEFT", xPos, yPos)
    
    if ActionMouseSettings.SoftPortalTips == nil then
        ActionMouseSettings.SoftPortalTips = false
    end
    
    softPortalTipsCheckbox:SetChecked(ActionMouseSettings.SoftPortalTips)

    softPortalTipsCheckbox:SetScript("OnClick", function(self)
        ActionMouseSettings.SoftPortalTips = self:GetChecked()
    end)

    softPortalTipsCheckbox:SetScript("OnEnter", function(self)
        GameTooltip:Hide()
        GameTooltip:SetOwner(UIParent, "ANCHOR_NONE")
        GameTooltip:SetPoint("CENTER", mFrame, "CENTER", autoTipsX, autoTipsY)
        GameTooltip:SetText(tipText)
        GameTooltip:Show()
    end)

    softPortalsTipCheckbox:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)

    softPortalTipsCheckbox:SetHitRectInsets(0,0,0,0)
end

-- createSlider()
local function CreateSlider(name, xPos, yPos, minVal, maxVal, step, axis)
    local slider = CreateFrame("Slider", name, mFrame, "OptionsSliderTemplate")
    slider:SetPoint("TOPLEFT", mTitle, "BOTTOMLEFT", xPos, yPos)
    slider:SetMinMaxValues(minVal, maxVal)
    slider:SetValueStep(step)
    slider:SetObeyStepOnDrag(true)
    local sliderValue
    if axis == "x" then        
        if ActionMouseSettings.crSliderX == nil then
	    ActionMouseSettings.crSliderX = 0
	    end
        sliderValue = ActionMouseSettings.crSliderX
    elseif axis == "y" then
        if ActionMouseSettings.crSliderY == nil then
	    ActionMouseSettings.crSliderY = 80
	    end
        sliderValue = ActionMouseSettings.crSliderY
	elseif axis == "z" then
        if ActionMouseSettings.sSlider == nil then
	    ActionMouseSettings.sSlider = 25
	    end
        sliderValue = ActionMouseSettings.sSlider
	end
    slider:SetValue(sliderValue)
    slider.Text:SetText(name)
    slider.Text:SetPoint("BOTTOM", slider, "TOP")
    slider.Value = slider:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    slider.Value:SetPoint("Top", slider, "Bottom")
    slider.Value:SetText(string.format("%.2f", sliderValue))
    slider:SetScript("OnValueChanged", function(self, value)
        self.Value:SetText(string.format("%.2f", value))
        if axis == "x" then
            ActionMouseSettings.crSliderX = value
            ActionMouse.SetClickReticle()
        elseif axis == "y" then
	        ActionMouseSettings.crSliderY = value
            ActionMouse.SetClickReticle()
	    elseif axis == "z" then
	        ActionMouseSettings.sSlider = value
            ActionMouse.SetClickReticle()
	    end
	end) 
end

-- createDescription()
local function CreateDescription(text, xPos, yPos, size)
    local descriptionFrame = CreateFrame("Frame", "ActionMouseDescription", mFrame)
    descriptionFrame:SetSize(200, 50)
    descriptionFrame:SetPoint("TOPLEFT", mTitle, "BOTTOMLEFT", xPos, yPos)
    descriptionFrame.text = descriptionFrame:CreateFontString(nil, "ARTWORK", size)
    descriptionFrame.text:SetPoint("TOPLEFT", descriptionFrame, "TOPLEFT")
    descriptionFrame.text:SetJustifyH("LEFT")
    descriptionFrame.text:SetText(text)
end

----------------------------------------------LOAD MENU
local function loadMenu()

    --/Header
    CreateDescription("V 4.0.1", 600, 15, "GameFontHighlightSmall")
    CreateDescription("/actionmouse", 450, 0, "GameFontNormalHuge")
    CreateDescription("FIXED:Missing portal data\nFIXED:Print logs\nNEW: Menu overhaul.\nNEW: Enter World automation.\nNEW: Tooltips while mouselook.", 415, -30, "GameFontHighlight")

    local mostLeft = -10

    --PLAY STYLE
    CreateDescription("Play Style", 20, -20, "GameFontHighlightHuge")
    CreateClickReticleCheckbox(mostLeft, -50)    
    CreateUseKeybindCheckbox(mostLeft, -75)
    
    --DIV 0
    CreateDescription("-----------------------------------------------------------------------------------------------------------------------------",-20,-100,"GameFontHighlight")

    CreateDescription("Reticle Settings",20,-125,"GameFontHighlightHuge")
    CreateHideReticleCheckbox(mostLeft, -155)

    local sliderY = -200

    local crSliderX = CreateSlider("Click Reticle X", 20, sliderY, -200, 200, 1, "x")
    local crSliderY = CreateSlider("Click Reticle Y", 220, sliderY, -200, 200, 1, "y")
    local sSlider = CreateSlider("Reticle Size", 440, sliderY, 10, 40, 1, "z")    

    --DIV 1
    CreateDescription("-----------------------------------------------------------------------------------------------------------------------------", -20, -245, "GameFontHighlight")

    CreateDescription("Automation", 20, -275,"GameFontHighlightHuge")
    CreateDescription("WARNING: Mouselook locking can occur when using Auto Start.",15,-305,"GameFontNormalMed1")

    local stopY = -350
    local startY = stopY - 30

    CreateDescription("Auto Stop", 0, stopY, "GameFontHighlight")
    CreateDescription("Auto Start", 0, startY, "GameFontHighlight")

    local labelY = stopY + 15

    local bagsX = 80
    local bagsBox = bagsX + 2
    CreateDescription("Bags", bagsX, labelY, "GameFontHighlight")
    CreateStopBagsCheckbox(bagsBox, stopY, "-Ends mouselook when bags open.")
    CreateStartBagsCheckbox(bagsBox, startY, "-Starts mouselook when bags close.\n-Only usable with the Keybind play style.")

    local mapX = 120
    local mapBox = mapX + 1
    CreateDescription("Map", mapX, labelY, "GameFontHighlight")
    CreateStopMapCheckbox(mapBox, stopY, "-Ends mouselook when the map opens.")
    CreateStartMapCheckbox(mapBox, startY, "-Starts mouselook when the map closes.\n-Only usable with the Keybind play style.")

    local panelsX = 160
    local panelsBox = panelsX + 6
    CreateDescription("Panels", panelsX, labelY, "GameFontHighlight")
    CreateStopPanelsCheckbox(panelsBox, stopY, "-Ends mouselook when 'panels' open")
    CreateStartPanelsCheckbox(panelsBox, startY, "-Starts mouselook when 'panels' close.\n-Only usable with the Keybind play style.")

    local popupsX = 210
    local popupsBox = popupsX + 8
    CreateDescription("Popups", popupsX, labelY, "GameFontHighlight")
    CreateStopPopupsCheckbox(popupsBox, stopY, "-Ends mouselook when 'popups' open")
    CreateStartPopupsCheckbox(popupsBox, startY, "-Starts mouselook when 'popups' close.\n-Only usable with the Keybind play style.")

    local combatX = 265
    local combatBox = combatX + 10
    CreateDescription("Combat", combatX, labelY, "GameFontHighlight")
    CreateStopCombatCheckbox(combatBox, stopY, "-Ends mouselook when combat starts.")
    CreateStartCombatCheckbox(combatBox, startY, "-Starts mouselook when combat ends.\n-Only usable with the Keybind play style.")

    local vMountX = 325
    local vMountBox = vMountX + 25
    CreateDescription("Vendor Mount", vMountX, labelY, "GameFontHighlight")
    CreateStopVendorMountCheckbox(vMountBox, stopY, "-Ends mouselook when you summon a mount with a vendor.")

    local enterX = 425
    local enterBox = enterX + 20
    CreateDescription("Enter World", enterX, labelY, "GameFontHighlight")
    CreateEnterWorldCheckbox(enterBox, startY, "-Start mouselook when you load in.\n-Only usable with the Keybind play sytle.")

    local lootLockX = mapX - 20
    local lootLockY = startY - 32
    local lootLockBox = lootLockY + 4
    CreateDescription("Loot Lock", lootLockX, lootLockY, "GameFontHighlight")
    CreateLootLockCheckbox(panelsBox, lootLockBox, "-Helps to keep mouselook active when loot opens.")

    local tipsY = -535
    CreateDescription("Tooltips", 0, tipsY, "GameFontHighlight")

    local tipsLabelY = tipsY + 15

    local activeX = 60
    local activeBox = activeX + 30
    CreateDescription("Active Enemy", activeX, tipsLabelY, "GameFontHighlight")
    CreateActiveEnemyTipsCheckbox(activeBox, tipsY, "-Tooltips will show when you tab target an enemy until the enemy is no longer a target.\n-WoW's 'Show Target Tooltip' setting will override this one.")

    local enemyX = 160
    local enemyBox = enemyX + 22
    CreateDescription("Soft Enemy", enemyX, tipsLabelY, "GameFontHighlight")
    CreateSoftEnemyTipsCheckbox(enemyBox, tipsY, "-Tooltips will show when you are close enough to and looking at an enemy.\n-'Interact' Key must be enabled for this to work.\n-ESC > Options > Controls > Enable Interact Key")

    local interactX = 250
    local interactBox = interactX + 28
    CreateDescription("Soft Interact", interactX, tipsLabelY, "GameFontHighlight")
    CreateSoftInteractTipsCheckbox(interactBox, tipsY, "-Tooltips will show when you are close enough something 'interactable'.\n-'Interact Key' must be enabled for this to work.\n-ESC > Options > Controls > Enable Interact Key")

    local portalsX = 340
    local portalsBox = portalsX + 20
    CreateDescription("Soft Portals", portalsX, tipsLabelY, "GameFontHighlight")
    CreateSoftPortalTipsCheckbox(portalsBox, tipsY, "-Tooltips will show at the cursor when you are close enough to a common portal.\n-'Interact Key' must be enabled for this to work.\n-ESC > Options > Controls > Enable Interact Key")
end

--ADDON_LOADED
local addonLoaded = CreateFrame("Frame")
addonLoaded:RegisterEvent("ADDON_LOADED")
addonLoaded:SetScript("OnEvent", function(self, event, addonName)
    if addonName == "ActionMouse" then
        ActionMouseSettings = ActionMouseSettings or {}     
        loadMenu()
	end
end)