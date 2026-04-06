trigger OpportunityStageChangedBeforeUpdate on Opportunity (before update) {
    OpportunityHandler.validateOpportunityStageChange(Trigger.newMap, Trigger.oldMap);
}