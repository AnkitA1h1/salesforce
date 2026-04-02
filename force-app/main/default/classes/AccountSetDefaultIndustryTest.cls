@isTest
private class AccountSetDefaultIndustryTest {
    @isTest
    static void testDefaultIndustry(){
        Account acc = new Account(Name = 'Test Account',
                    AccountNumber = '12345678'
                    //Industry = null
        );
        Test.startTest();
        insert acc;
        Test.stopTest();

        Account a = [SELECT Name ,Industry From Account where Name = 'Test Account' LIMIT 1];
        System.assertEquals('Technology', a.Industry, 'Expected Industry to be "Technology"');
    }
}