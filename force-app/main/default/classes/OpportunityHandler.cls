public with sharing class OpportunityHandler {
    public OpportunityHandler() {

    }

    public static void validateOpportunityStageChange(Map<Id, Opportunity> newMap, Map<Id, Opportunity> oldMap) {
        for (Opportunity opp : newMap.values()) {
            Opportunity oldOpp = oldMap.get(opp.Id);
            if (opp.StageName == 'Closed Won' && oldOpp.StageName != 'Closed Won') {
                if (opp.Amount == null || opp.Amount == 0) {
                    opp.StageName.addError('Amount must be greater than zero when stage is Closed Won.');
                }
            }
        }
    }
}