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
}