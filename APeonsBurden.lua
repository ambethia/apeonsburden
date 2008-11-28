local f, checkForUpdate = CreateFrame("Frame"), nil
local WORK_COMPLETE = "Sound\\Creature\\Peon\\PeonBuildingComplete1.wav"

f:RegisterEvent("QUEST_WATCH_UPDATE")
f:RegisterEvent("QUEST_LOG_UPDATE")
f:SetScript("OnEvent", function(self, event, ...)
  if self[event] then return self[event](self, ...); end
end)

function f:QUEST_WATCH_UPDATE(questIndex)
  checkForUpdate = questIndex
end

function f:QUEST_LOG_UPDATE(...)
  if checkForUpdate then
    local allComplete = 1
    for boardIndex = 1, GetNumQuestLeaderBoards(checkForUpdate) do
      local objComplete = select(3, GetQuestLogLeaderBoard(boardIndex, checkForUpdate))
      if not objComplete then allComplete = nil; end
    end
    if allComplete then PlaySoundFile(WORK_COMPLETE); end
  end
  checkForUpdate = nil
end
