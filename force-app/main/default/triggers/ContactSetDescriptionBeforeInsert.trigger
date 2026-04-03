trigger ContactSetDescriptionBeforeInsert on Contact (before insert) {
    ContactHandler.ContactSetDescriptionBeforeInsert(Trigger.new);
}