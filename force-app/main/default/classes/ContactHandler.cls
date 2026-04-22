public with sharing class ContactHandler {
    public ContactHandler() {

    }


    public static void ContactSetDescriptionBeforeInsert(List<Contact> contact){
        for(Contact con : contact){
            if(con.Description == null){
                con.Description = 'New Customer';
            }
        }
    }

    public static void UpdateAccountActiveStatusBasedOnContactActive(Map<Id,Contact> newMap, 
                                Map<Id,Contact> oldMap){
        Set<Id> accountIds = new Set<Id>();
        List<Account> accountToUpdates = new List<Account>();                           
        for(Contact con : newMap.values()){
            Contact oldCon = oldMap.get(con.Id);
            if(oldCon.Active__c != con.Active__c &&
             !RecursionHandler.processedContactIds.contains(con.Id)){
                RecursionHandler.processedContactIds.add(con.Id);
                accountIds.add(con.AccountId);
                Account acc = new Account(Id = con.AccountId);
                acc.Active__c = con.Active__c;
                accountToUpdates.add(acc);
                RecursionHandler.processedAccountIds.add(con.AccountId);
            }

        }
        if(!accountToUpdates.isEmpty()){
            update accountToUpdates;
        }
    }


    public static void UpdateAccountFieldWithTotalNumberOfRelatedContacts(
            List<Contact> newList, 
            List<Contact> oldList,
            Boolean isInsert,
            Boolean isDelete,
            Boolean isUndelete,
            Boolean isUpdate){

        Set<Id> accountIds = new Set<Id>();

        if(isInsert || isUpdate || isUndelete){
            for(Contact con : newList){
                if(con.AccountId != null){
                    accountIds.add(con.AccountId);
                }
            }
        }

        if(isDelete || isUpdate){
            for(Contact con : oldList){
                if(con.AccountId != null){
                    accountIds.add(con.AccountId);
                }
            }
        }

        if(accountIds.isEmpty()) return;

        Map<Id, Integer> accountIdToContactCount = new Map<Id, Integer>();

        for(AggregateResult ar : [select AccountId, COUNT(Id) totalContacts from Contact
                                    where AccountID IN : accountIds
                                    group by AccountId]){
            
            accountIdToContactCount.put((Id)ar.get('AccountId'), (Integer)ar.get('totalContacts'));
        }

        List<Account> accountsToUpdate = new List<Account>();

        for(Id accId: accountIds){
            Account acc = new Account(Id = accId);
            acc.Number_of_Contacts__c = accountIdToContactCount.containsKey(accId) ? accountIdToContactCount.get(accId) : 0;
            accountsToUpdate.add(acc);
        }
        if(!accountsToUpdate.isEmpty()){
            update accountsToUpdate;
        }
        
    }

    public static void preventDublicateContactsWithSameEmail(List<Contact> listContact){
        Set<String> emailsList = new Set<String>();

        for(Contact con : listContact){
            if(con.Email != null){
                emailsList.add(con.Email);
            }
        }

        List<AggregateResult> result = [Select Email, COUNT(Id) emailCount from Contact
                                        where Email IN: emailsList
                                        group by Email
                                        having COUNT(Id) >0];

        Set<String> duplicateEmails = new Set<String>();

        for(AggregateResult ar : result){
            duplicateEmails.add((String)ar.get('Email'));
        }

        for(Contact con : listContact){
            if(duplicateEmails.contains(con.Email)){
                con.Email.addError('Duplicate email found: ' + con.Email);
            }
        }
    }
}