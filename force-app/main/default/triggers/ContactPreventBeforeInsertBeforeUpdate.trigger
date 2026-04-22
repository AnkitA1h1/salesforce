trigger ContactPreventBeforeInsertBeforeUpdate on Contact (before insert, before update) {
    ContactHandler.preventDublicateContactsWithSameEmail(Trigger.new);
}