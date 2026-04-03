trigger AccountUpdateRelatedContactsPhone on Account (after update) {
    if(Trigger.isAfter && Trigger.isUpdate){
        AccountHandler.updateRelatedContactsPhone(Trigger.newMap, Trigger.oldMap);
    }
}