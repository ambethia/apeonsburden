local frame = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
frame.name = "A Peon's Burden"
frame:Hide()

frame:SetScript("OnShow", function(self)
  local GAP, EDGEGAP = 8, 16
  local tekcheck = LibStub("tekKonfig-Checkbox")

  local title, subtitle = LibStub("tekKonfig-Heading").new(self, "A Peon's Burden", "Toggle which sounds are played.")

  local playComplete = tekcheck.new(self, nil, "Work Complete!", "TOPLEFT", subtitle, "BOTTOMLEFT", -2, -GAP)
  playComplete.tiptext = "Play this sound when all quest objective are completed."
  playComplete:SetChecked(APeonsBurdenDB.playComplete)
  local checksound = playComplete:GetScript("OnClick")
  playComplete:SetScript("OnClick", function(self)
    checksound(self)
    APeonsBurdenDB.playComplete = not APeonsBurdenDB.playComplete
  end)

  local playWork = tekcheck.new(self, nil, "Work Work.", "TOPLEFT", playComplete, "BOTTOMLEFT", 0, -GAP)
  playWork.tiptext = "Play this sound when each quest objective is completed."
  playWork:SetChecked(APeonsBurdenDB.playWork)
  local checksound = playWork:GetScript("OnClick")
  playWork:SetScript("OnClick", function(self)
    checksound(self)
    APeonsBurdenDB.playWork = not APeonsBurdenDB.playWork
  end)

  self:SetScript("OnShow", nil)
end)

InterfaceOptions_AddCategory(frame)
