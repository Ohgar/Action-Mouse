ActionMouse = ActionMouse or {}

ActionMouse.isBagOpen = false

--BAG DETECTION
local function OnBagsToggled(flag)
	if flag then
		ActionMouse.isBagOpen = true
		if ActionMouseSettings.AutoStopBags then
			ActionMouse.Deactivate()
		end
	else
		ActionMouse.isBagOpen = false
		if ActionMouseSettings.AutoStartBags then
			ActionMouse.Activate()
		end
	end
end

local function OnBackpackToggled()
	if IsBagOpen(0) then
		OnBagsToggled(true)
	else
		OnBagsToggled(false)
	end
end

local function OnBagToggled(bagID)
    if IsBagOpen(bagID) then
        OnBagsToggled(true)
    else
		OnBagsToggled(false)
	end
end

local function OnAllBagsToggled()
    for bagID = 0, NUM_BAG_SLOTS do
        if IsBagOpen(bagID) then
            OnBagsToggled(true)
        else
			OnBagsToggled(false)
		end
    end
end

hooksecurefunc("ToggleBackpack", OnBackpackToggled)
hooksecurefunc("ToggleBag", OnBagToggled)
hooksecurefunc("ToggleAllBags", OnAllBagsToggled)

hooksecurefunc("CloseAllBags", function()
	ActionMouse.isBagOpen = false
end);