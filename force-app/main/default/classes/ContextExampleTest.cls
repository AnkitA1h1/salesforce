@isTest
private class ContextExampleTest {

    @isTest
    static void myUnitTest() {
        // TO DO: implement unit test

        Account acc = new Account(Name = 'Test Account');
        
        Test.startTest();
        insert acc;
        //ContextExample example = new ContextExample('Test Account');
        
        Test.stopTest();

        Account a = [SELECT Name FROM Account WHERE Name = 'Test Account' LIMIT 1];
        System.assertEquals('Test Account', a.Name, 'Expected account name to be "Test Account"');   
    }
}