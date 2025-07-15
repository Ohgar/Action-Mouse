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


--CreateClickReticleCheckbox()
local function CreateClickReticleCheckbox(text, xPos, yPos)
    local crCheckbox = CreateFrame("CheckButton", "crCheckbox", mFrame, "ChatConfigCheckButtonTemplate")
	crCheckbox:SetPoint("TOPLEFT", mTitle, "BOTTOMLEFT", xPos, yPos)
    crCheckbox.Text:SetText(text)
    local isChecked
    if ActionMouseSettings.Click == nil then
	    ActionMouseSettings.Click = true
	end
    if ActionMouse.GetAutoStartState() then
        isChecked = false
        crCheckbox:SetChecked(isChecked)
        ActionMouseSettings.Click = isChecked
	else
        isChecked = ActionMouseSettings.Click
        crCheckbox:SetChecked(isChecked)
	end
    
    crCheckbox:SetScript("OnClick", function(self)
        ActionMouse.isMenuOpen = false
        if not ActionMouse.GetAutoStartState() then
            isChecked = self:GetChecked()
            ActionMouseSettings.Click = isChecked
		else
            isChecked = false
            crCheckbox:SetChecked(isChecked)
		end

        --isChecked = not isChecked
        --crCheckbox:SetChecked(isChecked)
        
        if isChecked or not ActionMouseSettings.Keybind then
            --startBagsCheckbox:SetChecked(false)
            kbCheckbox:SetChecked(false)
            ActionMouseSettings.Keybind = false
            crCheckbox:SetChecked(true)
            ActionMouseSettings.Click = true
            ActionMouse.SetClickReticle()
            ActionMouse.reticleButton:Show()            
		end        
	end)    
end

--FORCE KEYBIND
local function ForceKeybind()
    crCheckbox:SetChecked(false)
    ActionMouseSettings.Click = false
    kbCheckbox:SetChecked(true)
    ActionMouseSettings.Keybind = true
    ActionMouse.reticleButton:Hide()
end

--CreateUseKeybindCheckbox()
local function CreateUseKeybindCheckbox(text, xPos, yPos)
    local kbCheckbox = CreateFrame("CheckButton", "kbCheckbox", mFrame, "ChatConfigCheckButtonTemplate")
    kbCheckbox:SetPoint("TOPLEFT", mTitle, "BOTTOMLEFT", xPos, yPos)
    kbCheckbox.Text:SetText(text)
    local isChecked
    if ActionMouseSettings.Keybind == nil then
	    ActionMouseSettings.Keybind = false
	end
    if ActionMouse.GetAutoStartState() then
        isChecked = true
        kbCheckbox:SetChecked(isChecked)
        ActionMouseSettings.Keybind = isChecked
	else
        isChecked = ActionMouseSettings.Keybind
        kbCheckbox:SetChecked(isChecked)
	end
    
    kbCheckbox:SetScript("OnClick", function(self)
        ActionMouse.Deactivate()
	    isChecked = self:GetChecked()
		ActionMouseSettings.Keybind = isChecked
        if isChecked or not ActionMouseSettings.Click then
            ForceKeybind()
		end		
	end)
end

--CreateHideReticleCheckbox()
local function CreateHideReticleCheckbox(text, xPos, yPos)
    local hrCheckbox = CreateFrame("CheckButton", "hrCheckbox", mFrame, "ChatConfigCheckButtonTemplate")
    hrCheckbox:SetPoint("TOPLEFT", mTitle, "BOTTOMLEFT", xPos, yPos)
    hrCheckbox.Text:SetText(text)
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

--STOP BAGS CHECKBOX
local function CreateStopBagsCheckbox(xPos, yPos)
    local stopBagsCheckbox = CreateFrame("CheckButton", "stopBagsCheckbox", mFrame, "ChatConfigCheckButtonTemplate")
    stopBagsCheckbox:SetPoint("TOPLEFT", mTitle, "BOTTOMLEFT", xPos, yPos)
    local isChecked
    if ActionMouseSettings.AutoStopBags == nil then
        ActionMouseSettings.AutoStopBags = false
	end
	isChecked = ActionMouseSettings.AutoStopBags
	stopBagsCheckbox:SetChecked(isChecked)
	stopBagsCheckbox:SetScript("OnClick", function(self)
        isChecked = self:GetChecked()
        ActionMouseSettings.AutoStopBags = isChecked
    end)
    stopBagsCheckbox:SetHitRectInsets(0,0,0,0)
end

--STOP MAP CHECKBOX
local function CreateStopMapCheckbox(xPos, yPos)
    local stopMapCheckbox = CreateFrame("CheckButton", "stopMapCheckbox", mFrame, "ChatConfigCheckButtonTemplate")
    stopMapCheckbox:SetPoint("TOPLEFT", mTitle, "BOTTOMLEFT", xPos, yPos)
    local isChecked
    if ActionMouseSettings.AutoStopMap == nil then
	    ActionMouseSettings.AutoStopMap = false
	end
    isChecked = ActionMouseSettings.AutoStopMap
    stopMapCheckbox:SetChecked(isChecked)
    stopMapCheckbox:SetScript("OnClick", function(self)
        isChecked = self:GetChecked()
        ActionMouseSettings.AutoStopMap = isChecked
	end)
    stopMapCheckbox:SetHitRectInsets(0,0,0,0)
end

--STOP PANELS CHECKBOX
local function CreateStopPanelsCheckbox(xPos,yPos)
    local stopPanelsCheckbox = CreateFrame("CheckButton", "stopPanelsCheckbox", mFrame, "ChatConfigCheckButtonTemplate")
    stopPanelsCheckbox:SetPoint("TOPLEFT",mTitle,"BOTTOMLEFT",xPos,yPos)
    local isChecked
    if ActionMouseSettings.AutoStopPanels == nil then
        ActionMouseSettings.AutoStopPanels = false
	end
    isChecked = ActionMouseSettings.AutoStopPanels
    stopPanelsCheckbox:SetChecked(isChecked)
    stopPanelsCheckbox:SetScript("OnClick", function(self)
        isChecked = self:GetChecked()
        ActionMouseSettings.AutoStopPanels = isChecked
	end)
    stopPanelsCheckbox:SetHitRectInsets(0,0,0,0)
end

--STOP POPUPS CHECKBOX
local function CreateStopPopupsCheckbox(xPos,yPos)
    local stopPopupsCheckbox = CreateFrame("CheckButton","stopPopupsCheckbox",mFrame,"ChatConfigCheckButtonTemplate")
    stopPopupsCheckbox:SetPoint("TOPLEFT",mTitle,"BOTTOMLEFT",xPos,yPos)
    local isChecked
    if ActionMouseSettings.AutoStopPopups == nil then
	    ActionMouseSettings.AutoStopPopups = false
	end
    isChecked = ActionMouseSettings.AutoStopPopups
    stopPopupsCheckbox:SetChecked(isChecked)
    stopPopupsCheckbox:SetScript("OnClick",function(self)
	    isChecked = self:GetChecked()
		ActionMouseSettings.AutoStopPopups = isChecked
	end)
    stopPopupsCheckbox:SetHitRectInsets(0,0,0,0)
end

--STOP COMBAT CHECKBOX
local function CreateStopCombatCheckbox(xPos,yPos)
    local stopCombatCheckbox = CreateFrame("CheckButton","stopCombatCheckbox",mFrame,"ChatConfigCheckButtonTemplate")
    stopCombatCheckbox:SetPoint("TOPLEFT",mTitle,"BOTTOMLEFT",xPos,yPos)
    local isChecked
    if ActionMouseSettings.AutoStopCombat == nil then
	    ActionMouseSettings.AutoStopCombat = false
	end
    isChecked = ActionMouseSettings.AutoStopCombat
    stopCombatCheckbox:SetChecked(isChecked)
    stopCombatCheckbox:SetScript("OnClick",function(self)
	    isChecked = self:GetChecked()
		ActionMouseSettings.AutoStopCombat = isChecked
	end)
    stopCombatCheckbox:SetHitRectInsets(0,0,0,0)
end

--STOP VENDOR MOUNT CHECKBOX
local function CreateStopVendorMountCheckbox(xPos,yPos)
    local stopMountCheckbox = CreateFrame("CheckButton", "stopMountCheckbox", mFrame, "ChatConfigCheckButtonTemplate")
    stopMountCheckbox:SetPoint("TOPLEFT", mTitle, "BOTTOMLEFT", xPos, yPos)
    local isChecked
    if ActionMouseSettings.VendorMountStop == nil then
        ActionMouseSettings.VendorMountStop = false
	end
    isChecked = ActionMouseSettings.VendorMountStop
    stopMountCheckbox:SetChecked(isChecked)
    stopMountCheckbox:SetScript("OnClick",function(self)
        isChecked = self:GetChecked()
        ActionMouseSettings.VendorMountStop = isChecked
	end)
    stopMountCheckbox:SetHitRectInsets(0,0,0,0)
end

--START BAGS CHECKBOX
local function CreateStartBagsCheckbox(xPos, yPos)
    local startBagsCheckbox = CreateFrame("CheckButton", "startBagsCheckbox", mFrame, "ChatConfigCheckButtonTemplate")
    startBagsCheckbox:SetPoint("TOPLEFT", mTitle, "BOTTOMLEFT", xPos, yPos)
    local isChecked
    if ActionMouseSettings.AutoStartBags == nil then
        ActionMouseSettings.AutoStartBags = false
	end
	isChecked = ActionMouseSettings.AutoStartBags
	startBagsCheckbox:SetChecked(isChecked)
	startBagsCheckbox:SetScript("OnClick", function(self)
        isChecked = self:GetChecked()
        ActionMouseSettings.AutoStartBags = isChecked
        if isChecked then
            ForceKeybind()
		end	
    end)
    startBagsCheckbox:SetHitRectInsets(0,0,0,0)
        
end

--START MAP CHECKBOX
local function CreateStartMapCheckbox(xPos, yPos)
    local startMapCheckbox = CreateFrame("CheckButton", "startMapCheckbox", mFrame, "ChatConfigCheckButtonTemplate")
    startMapCheckbox:SetPoint("TOPLEFT", mTitle, "BOTTOMLEFT", xPos, yPos)
    local isChecked
    if ActionMouseSettings.AutoStartMap == nil then
        ActionMouseSettings.AutoStartMap = false
	end
    isChecked = ActionMouseSettings.AutoStartMap
    startMapCheckbox:SetChecked(isChecked)
    startMapCheckbox:SetScript("OnClick", function(self)
	    isChecked = self:GetChecked()
		ActionMouseSettings.AutoStartMap = isChecked
        if isChecked then
            ForceKeybind()
		end	
	end)
    startMapCheckbox:SetHitRectInsets(0,0,0,0)
end

--START PANELS CHECKBOX
local function CreateStartPanelsCheckbox(xPos,yPos)
    local startPanelsCheckbox = CreateFrame("CheckButton", "startPanelsCheckbox",mFrame,"ChatConfigCheckButtonTemplate")
    startPanelsCheckbox:SetPoint("TOPLEFT",mTitle,"BOTTOMLEFT",xPos,yPos)
    local isChecked
    if ActionMouseSettings.AutoStartPanels == nil then
	    ActionMouseSettings.AutoStartPanels = false
	end
    isChecked = ActionMouseSettings.AutoStartPanels
    startPanelsCheckbox:SetChecked(isChecked)
    startPanelsCheckbox:SetScript("OnClick",function(self)
	    isChecked = self:GetChecked()
		ActionMouseSettings.AutoStartPanels = isChecked
        if isChecked then
            ForceKeybind()
		end	
	end)
    startPanelsCheckbox:SetHitRectInsets(0,0,0,0)
end

--START POPUPS CHECKBOX
local function CreateStartPopupsCheckbox(xPos,yPos)
    local startPopupsCheckbox = CreateFrame("CheckButton","startPopupsCheckbox",mFrame,"ChatConfigCheckButtonTemplate")
	startPopupsCheckbox:SetPoint("TOPLEFT",mTitle,"BOTTOMLEFT",xPos,yPos)
	local isChecked
	if ActionMouseSettings.AutoStartPopups == nil then
	    ActionMouseSettings.AutoStartPopups = false
    end
	isChecked = ActionMouseSettings.AutoStartPopups
	startPopupsCheckbox:SetChecked(isChecked)
	startPopupsCheckbox:SetScript("OnClick",function(self)
	    isChecked = self:GetChecked()
		ActionMouseSettings.AutoStartPopups = isChecked
        if isChecked then
            ForceKeybind()
		end	
	end)
	startPopupsCheckbox:SetHitRectInsets(0,0,0,0)
end

--START COMBAT CHECKBOX
local function CreateStartCombatCheckbox(xPos,yPos)
    local startCombatCheckbox = CreateFrame("CheckButton","startCombatCheckbox",mFrame,"ChatConfigCheckButtonTemplate")
	startCombatCheckbox:SetPoint("TOPLEFT",mTitle,"BOTTOMLEFT",xPos,yPos)
	local isChecked
	if ActionMouseSettings.AutoStartCombat == nil then
	    ActionMouseSettings.AutoStartCombat = false
    end
	isChecked = ActionMouseSettings.AutoStartCombat
	startCombatCheckbox:SetChecked(isChecked)
	startCombatCheckbox:SetScript("OnClick",function(self)
	    isChecked = self:GetChecked()
		ActionMouseSettings.AutoStartCombat = isChecked
        if isChecked then
            ForceKeybind()
		end	
	end)
	startCombatCheckbox:SetHitRectInsets(0,0,0,0)
end

--LOOT LOCK
local function CreateLootLockCheckbox(xPos,yPos)
    local lootCheckbox = CreateFrame("CheckButton", "lootCheckbox", mFrame, "ChatConfigCheckButtonTemplate")
    lootCheckbox:SetPoint("TOPLEFT",mTitle, "BOTTOMLEFT", xPos, yPos)
    local isChecked
    if ActionMouseSettings.LootLock == nil then
        ActionMouseSettings.LootLock = false
	end
    isChecked = ActionMouseSettings.LootLock
    lootCheckbox:SetChecked(isChecked)
    lootCheckbox:SetScript("OnClick",function(self)
        isChecked = self:GetChecked()
        ActionMouseSettings.LootLock = isChecked
	end)
    lootCheckbox:SetHitRectInsets(0,0,0,0)
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

--loadMenu()
local function loadMenu()

    local chkX = -10
    local desX = 20
    local adjY = 10
    local sliderY = -295

    local autoDes = 0
    local bagsX = 90
    local mapX = 150
    local panelsX = 210
    local popupsX = 275
    local combatX = 335
    local vMountX = 395
    local lootLockX = 550

    local groupY = -465
    local stopY = -485
    local startY = -520

    --/Header
    CreateDescription("/actionmouse", 450, 0, "GameFontNormalHuge")
    CreateDescription("Please leave a review or feedback\nand tell your friends :)", 415, -30, "GameFontHighlight")
    CreateDescription("V 3.1.2", 600, 15, "GameFontHighlightSmall")    

    --PLAY STYLE
    CreateDescription("Play Style", desX, -30 + adjY, "GameFontHighlightHuge")

    CreateClickReticleCheckbox("Click Reticle", chkX, -60 + adjY)
    CreateDescription("-Enable a fixed reticle button.\n-Left click to activate, right click to exit.\n-Overrides to Keybind if using Auto Start.", desX, -80 + adjY, "GameFontNormalMed1")
    
    CreateUseKeybindCheckbox("Keybind", chkX, -125 + adjY)
    CreateDescription("-Use a custom keybind to start and stop mouselook.\n-ESC > Options > Keybindings > Action Mouse.", desX, -145 + adjY, "GameFontNormalMed1")
    
    --DIV 0
    CreateDescription("-----------------------------------------------------------------------------------------------------------------------------",-20,-175+adjY,"GameFontHighlight")

    --PREFERENCES
    CreateDescription("Preferences",desX,-205+ adjY,"GameFontHighlightHuge")
    CreateHideReticleCheckbox("Hide Reticle on Mouselook",chkX,-235+adjY)
    CreateDescription("-The cursor location reticle will hide when mouselook is active.",desX,-255+adjY,"GameFontNormalMed1")

    local crSliderX = CreateSlider("Click Reticle X",desX,sliderY+adjY,-200,200,1,"x")
    local crSliderY = CreateSlider("Click Reticle Y",desX+210,sliderY+adjY,-200,200,1,"y")
    local sSlider = CreateSlider("Reticle Size",440,sliderY+adjY,10,40,1,"z")    

    --DIV 1
    CreateDescription("-----------------------------------------------------------------------------------------------------------------------------",-20,-340+adjY,"GameFontHighlight")

    --Automation
    CreateDescription("Automation",desX,-370+adjY,"GameFontHighlightHuge")
    CreateDescription("WARNING: Mouselook locking can occur when using Auto Start.\n\n-Make sure a keybind is set in Options > Keybindings > ActionMouse.",desX,-400+adjY,"GameFontNormalMed1")

    CreateDescription("Auto Stop",desX+autoDes,groupY-25+adjY,"GameFontHighlight")
    CreateDescription("Auto Start",desX+autoDes,groupY-65+adjY,"GameFontHighlight")

    CreateDescription("Bags",desX+bagsX-3,groupY+adjY,"GameFontHighlight")
    CreateStopBagsCheckbox(desX+bagsX,stopY+adjY)
    CreateStartBagsCheckbox(desX+bagsX,startY+adjY)

    CreateDescription("Map",desX+mapX-3,groupY+adjY,"GameFontHighlight")
    CreateStopMapCheckbox(desX+mapX,stopY+adjY)
    CreateStartMapCheckbox(desX+mapX,startY+adjY)

    CreateDescription("Panels",desX+panelsX-8,groupY+adjY,"GameFontHighlight")
    CreateStopPanelsCheckbox(desX+panelsX,stopY+adjY)
    CreateStartPanelsCheckbox(desX+panelsX,startY+adjY)

    CreateDescription("Popups",desX+popupsX-8,groupY+adjY,"GameFontHighlight")
    CreateStopPopupsCheckbox(desX+popupsX,stopY+adjY)
    CreateStartPopupsCheckbox(desX+popupsX,startY+adjY)

    CreateDescription("Combat",desX+combatX-8,groupY+adjY,"GameFontHighlight")
    CreateStopCombatCheckbox(desX+combatX,stopY+adjY)
    CreateStartCombatCheckbox(desX+combatX,startY+adjY)

    CreateDescription("Vendor\nMount",desX+vMountX-8,groupY+adjY+12,"GameFontHighlight")
    CreateStopVendorMountCheckbox(desX+vMountX,stopY+adjY)

    CreateDescription("Loot Lock", desX+mapX-5, groupY+adjY-95, "GameFontHighlight")
    CreateLootLockCheckbox(desX+panelsX, startY+adjY-35)
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