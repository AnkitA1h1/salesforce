trigger AccountPreventDeletion on Account (before delete)  {
    if(Trigger.isBefore && Trigger.isDelete){
        AccountHandler.preventDeletionOfAccountsWithContacts(Trigger.old);
    }
}