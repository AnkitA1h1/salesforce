trigger ContactAfterUpdateFieldAccountActive on Contact (after update) {
    ContactHandler.UpdateAccountActiveStatusBasedOnContactActive(Trigger.newMap, Trigger.oldMap);

}