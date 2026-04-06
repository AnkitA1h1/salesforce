@isTest
private class OpportunityHandlerTest {
    @isTest
    static void testClosedWonWithInvalidAmount(){
        Opportunity opp = new Opportunity(Name = 'Test Opportnity',
                                        StageName = 'Prospecting',
                                        Discount_Percent__c = 40,
                                        CloseDate = Date.today().addDays(10)
                                        );

        insert opp;

        // updating stage to Closed Won without setting amount
        opp.StageName = 'Closed Won';   
        opp.Amount = 0;

        Test.startTest();
        try {
            update opp;
            System.assert(false, 'Expected DmlException was not thrown');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('Amount must be greater than zero when stage is Closed Won.'));
        }
        
        Test.stopTest();
    }

    @isTest
    static void testClosedWonWithValidAmount(){
        Opportunity opp = new Opportunity(Name = 'Test Opportunity1',
                                        StageName = 'Prospecting',
                                        Discount_Percent__c = 30,
                                        CloseDate = Date.today().addDays(10)
                                        );

        insert opp;

        // updating stage to Closed Won with valid amount
        opp.StageName = 'Closed Won';   
        opp.Amount = 5000;

        Test.startTest();
        try {
            update opp;
            System.assert(true, 'Update should succeed without errors');
        } catch (DmlException e) {
            System.assert(false, 'Did not expect DmlException to be thrown: ' + e.getMessage());
        }
        
        Test.stopTest();
    }
}