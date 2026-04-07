trigger AccountAfterUpadteRelatedContactActive on Account (after update) {
    AccountHandler.UpdateRelatedContactActiveField(Trigger.newMap, Trigger.oldMap);
}