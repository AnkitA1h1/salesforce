trigger ContactAfterTrigger on Contact (after insert, after update, after delete, after undelete) {

    // Whenever a Contact is inserted, updated, or deleted
    // Update the Account field with total number of related Contacts

    ContactHandler.UpdateAccountFieldWithTotalNumberOfRelatedContacts(Trigger.new, Trigger.old, Trigger.isInsert, Trigger.isDelete, Trigger.isUndelete, Trigger.isUpdate);

}