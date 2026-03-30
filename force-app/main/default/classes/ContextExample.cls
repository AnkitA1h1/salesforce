public with sharing class ContextExample {
    public ContextExample(String AccountName) {
        Account acc = new Account(Name = AccountName);
        insert acc;
    }
}