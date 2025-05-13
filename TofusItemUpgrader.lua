
TofusItemUpgrader = {}

function TofusItemUpgrader:IsItemUpgradable(slotID)
    local i = ItemLocation:CreateFromEquipmentSlot(slotID)
    if i or i:IsValid() then
        if next(i) == nil then
            return false
        end
        return C_ItemUpgrade.CanUpgradeItem(i)
    end
    return false
end

function TofusItemUpgrader:AddMarksToEquippedItems()
    local slotIDs = {
        CharacterHeadSlot = 1,
        CharacterNeckSlot = 2,
        CharacterShoulderSlot = 3,
        CharacterBackSlot = 15,
        CharacterChestSlot = 5,
        CharacterWristSlot = 9,
        CharacterHandsSlot = 10,
        CharacterWaistSlot = 6,
        CharacterLegsSlot = 7,
        CharacterFeetSlot = 8,
        CharacterFinger0Slot = 11,
        CharacterFinger1Slot = 12,
        CharacterTrinket0Slot = 13,
        CharacterTrinket1Slot = 14,
        CharacterMainHandSlot = 16,
        CharacterSecondaryHandSlot = 17,
        CharacterRangedSlot = 18,
        CharacterAmmoSlot = 0
    }

    for key, slotID in pairs(slotIDs) do
        if type(slotID) == "number" then
            local slot = _G[key]
            if slot then
                local isUpgradable = TofusItemUpgrader:IsItemUpgradable(slotID)
                if isUpgradable then
                    TofusItemUpgrader:MarkEquipmentAtSlot(slot)
                end
            end
        end
    end
end

function TofusItemUpgrader:MarkEquipmentAtSlot(slot)
    local upgradeMe = slot:CreateTexture(nil, "OVERLAY", nil, 3)
    upgradeMe:SetSize(18, 18)
    upgradeMe:SetPoint("RIGHT", slot, 9, 6)
    upgradeMe:SetAtlas("CovenantSanctum-Renown-DoubleArrow-Hover")
    upgradeMe:SetTexCoord(0, 1, 1, 1, 0, 0, 1, 0)
    upgradeMe:SetDrawLayer("OVERLAY", 5)
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("BAG_UPDATE")
f:SetScript("OnEvent", function()
    PaperDollFrame:HookScript("OnShow", TofusItemUpgrader.AddMarksToEquippedItems)
    ContainerFrameCombinedBags:HookScript("OnShow", TofusItemUpgrader.AddMarksToBagItems)
end)
