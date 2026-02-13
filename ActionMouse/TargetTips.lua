ActionMouse = ActionMouse or {}

local objects = {
    -- Org > ...
    [355229] = "Oribos",
    [383583] = "Valdrakken",
    [543406] = "Razorwind Shores",
    [452407] = "Dornogal",
    [323852] = "Jade Forest",
    [323851] = "Dalaran: Crystalsong Forest",
    [323850] = "Azsuna",
    [323855] = "Zuldazar",
    [323853] = "Shattrath",
    [332214] = "Caverns of Time",
    [323849] = "Warspear, Ashran",
    [323854] = "Silvermoon (Burning Crusade)",

    -- Stormwind > ...
    [620463] = "Dornogal",
    [620458] = "Valdrakken",
    [620464] = "Oribos",
    [543407] = "Founder's Point",
    [620475] = "Dalaran: Crystalsong Forest",
    [620473] = "Exodar",
    [620455] = "Caverns of Time",
    [620472] = "Shattrath",
    [620467] = "Jade Forest",
    [620476] = "Bel'ameth",
    [620477] = "Azsuna",
    [620465] = "Boralus",
    [620479] = "Stormshield, Ashran",
    [206595] = "Tol Barad",
    [207687] = "Uldum",
    [207686] = "Twilight Highlands",
    [207688] = "Hyjal",
    [207689] = "Deepholm",

    -- Valdrakken > ...
    [376418] = "Orgrimar",
    [376417] = "Stormwind",

    -- Dornagal > ...
    [428729] = "Orgrimar",
    [428728] = "Stormwind",
    [415760] = "Earthen Teleporter",
    [474203] = "Arathi Highlands",
} 

local function DisplayTips(unit)
    if UnitExists(unit) then 
        GameTooltip_SetDefaultAnchor(GameTooltip,UIParent)
        GameTooltip:SetUnit(unit)
        GameTooltip:Show()
    end
end

local function DisplayPortalTips(unit)
    local _, _, _, _, _, id = strsplit("-", unit)
    local name = objects[tonumber(id)]
    if name then
        GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
        GameTooltip:SetText(name)
        GameTooltip:Show()
    else
        --print(id)
    end
end

local targetTips = CreateFrame("Frame")
    targetTips:RegisterEvent("PLAYER_ENTERING_WORLD")
    targetTips:RegisterEvent("PLAYER_TARGET_CHANGED")
    targetTips:RegisterEvent("PLAYER_SOFT_ENEMY_CHANGED")
    targetTips:RegisterEvent("PLAYER_SOFT_INTERACT_CHANGED")
    --targetTips:RegisterEvent("PLAYER_SOFT_FRIEND_CHANGED")

targetTips:SetScript("OnEvent", function(self, event, unit, softType)
    if event == "PLAYER_ENTERING_WORLD" then 
        GameTooltip:Hide()
    elseif event == "PLAYER_TARGET_CHANGED" and ActionMouseSettings.ActiveEnemyTips then
        DisplayTips("target")
    elseif event == "PLAYER_SOFT_INTERACT_CHANGED"then
        if unit then
            if string.find(unit, "^GameObject") and ActionMouseSettings.SoftPortalTips then
                DisplayPortalTips(unit)
            else
                if ActionMouseSettings.SoftInteractTips and UnitName("softinteract") then
                    DisplayTips("softinteract") 
                else
                    GameTooltip:Hide()
                end
            end
        else
            GameTooltip:Hide()
        end        
    elseif event == "PLAYER_SOFT_ENEMY_CHANGED" and ActionMouseSettings.SoftEnemyTips then
        if UnitName("softenemy") then
            DisplayTips("softenemy")
        else
            GameTooltip:Hide()
        end
    end
    --elseif event == "PLAYER_SOFT_FRIEND_CHANGED" and ActionMouseSettings.softfriend then
        --print("soft friend")
        --DistplayTips("softfriend") 
    --end
end)
