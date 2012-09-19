local WORK_COMPLETE = "Sound\\Creature\\Peon\\PeonBuildingComplete1.wav"
local WORK_WORK     = "Sound\\Creature\\Peon\\PeonYes3.wav"

local defaults, db = { playComplete = true, playWork = false }

local frame, checkForUpdate = CreateFrame("Frame"), nil

frame:SetScript("OnEvent", function(self, event, ...)
  if self[event] then return self[event](self, ...); end
end)

frame:RegisterEvent("QUEST_WATCH_UPDATE")
function frame:QUEST_WATCH_UPDATE(questIndex)
  checkForUpdate = questIndex
end

frame:RegisterEvent("QUEST_LOG_UPDATE")
function frame:QUEST_LOG_UPDATE(...)
  if checkForUpdate then
    local allComplete = 1
    for boardIndex = 1, GetNumQuestLeaderBoards(checkForUpdate) do
      local objComplete = select(3, GetQuestLogLeaderBoard(boardIndex, checkForUpdate))
      if not objComplete then allComplete = nil; end
    end
    if allComplete then
      if db.playComplete then PlaySoundFile(WORK_COMPLETE) end
    else
      if db.playWork then PlaySoundFile(WORK_WORK) end
    end
  end
  checkForUpdate = nil
end

frame:RegisterEvent("ADDON_LOADED")
function frame:ADDON_LOADED(addon)
  if addon:lower() ~= "apeonsburden" then return end

  APeonsBurdenDB = setmetatable(APeonsBurdenDB or {}, {__index = defaults})
  db = APeonsBurdenDB

  LibStub("tekKonfig-AboutPanel").new("A Peon's Burden", "APeonsBurden")

  self:UnregisterEvent("ADDON_LOADED")
  self.ADDON_LOADED = nil

  self:RegisterEvent("PLAYER_LOGOUT")
end

function frame:PLAYER_LOGOUT()
  for i,v in pairs(defaults) do if db[i] == v then db[i] = nil end end
end
