trigger OpportunityStageChangedBeforeUpdate on Opportunity (before update, after update) {
    OpportunityHandler.validateOpportunityStageChangeToClosedWon(Trigger.newMap, Trigger.oldMap,
                                                    Trigger.isBefore, Trigger.isAfter);
}