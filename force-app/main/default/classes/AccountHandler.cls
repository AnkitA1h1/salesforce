public with sharing class AccountHandler {
    public AccountHandler() {

    }

    public static void preventDeletionOfAccountsWithContacts(List<Account> accountToCheck){
        Set<Id> accountsId = new Set<Id>();
        for(Account acc : accountToCheck){
            accountsId.add(acc.Id);
        }

        Map<Id,Integer> accountIdToContactCount = new Map<Id,Integer>();
        for(AggregateResult ar : [select AccountId, COUNT(Id) countId from Contact
        where AccountId IN :accountsId
        group by AccountId]){
            accountIdToContactCount.put((Id)ar.get('AccountId'), (Integer)ar.get('countId'));
        }


        for(Account acc : accountToCheck){
            if(accountIdToContactCount.containsKey(acc.Id) && accountIdToContactCount.get(acc.Id)>0){
                acc.addError('Cannot delete account with contacts');
            }
        }
    }


    public static void updateRelatedContactsPhone(Map<Id, Account> newMap,
                                             Map<Id, Account> oldMap){
        Set<Id> accountIds = new Set<Id>();

        for(Id accId : newMap.keySet()){
            Account newAcc = newmap.get(accId);
            Account oldAcc = oldMap.get(accId);
            if(newAcc.Phone != oldAcc.Phone){
                accountIds.add(newAcc.Id);
            }
        }

        // Query All Contacts related to these accounts
        List<Contact> contactsToUpdate = [select Id, AccountId, Phone from Contact
                                                where AccountId IN : accountIds];
        // Update phone number of all related contacts to match the account phone number
        for(Contact con : contactsToUpdate){
            con.Phone = newmap.get(con.AccountId).Phone;
        }
        
        if(!contactsToUpdate.isEmpty()){
            update contactsToUpdate;
        }
    }

    public static void createChildContactForNewAccount(List<Account> accountList){
        List<Contact> contactToInsert = new List<Contact>();
        for(Account acc : accountList){
            Contact con = new Contact(FirstName = acc.Name,
                                    LastName = 'Contact',
                                    AccountId = acc.Id);
            contactToInsert.add(con);
        }
        
        if(!contactToInsert.isEmpty()){
            insert contactToInsert;
        }
    }

    public static void UpdateRelatedContactActiveField(Map<Id,Account> newMap, Map<Id,Account> oldMap){
        Set<Id> accountIds = new Set<Id>();

        for(Account acc : newMap.values()){
            Account oldAcc = oldMap.get(acc.Id);
            if(oldAcc.Active__c != acc.Active__c &&
             !RecursionHandler.processedAccountIds.contains(acc.Id)){
                accountIds.add(acc.Id);
                RecursionHandler.processedAccountIds.add(acc.Id);
            }
        }

        List<Contact> contactsToUpdate = [select Id, AccountId, Active__c from Contact
                                        where AccountId IN : accountIds];
        for(Contact con : contactsToUpdate){
            con.Active__c = newMap.get(con.AccountId).Active__c ; 
            RecursionHandler.processedContactIds.add(con.Id);   
        }
        if(!contactsToUpdate.isEmpty()){
            update contactsToUpdate;
        }
    }
}