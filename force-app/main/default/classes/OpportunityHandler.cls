public with sharing class OpportunityHandler {
    public OpportunityHandler() {

    }

    public static void validateOpportunityStageChangeToClosedWon(Map<Id, Opportunity> newMap, 
                                                            Map<Id, Opportunity> oldMap,
                                                            Boolean isBefore,
                                                            Boolean isAfter){


        if(isBefore){
            for (Opportunity opp : newMap.values()) {
            Opportunity oldOpp = oldMap.get(opp.Id);
            if (opp.StageName == 'Closed Won' && oldOpp.StageName != 'Closed Won') {
                if (opp.Amount == null || opp.Amount == 0) {
                    opp.StageName.addError('Amount must be greater than zero when stage is Closed Won.');
                }
            }
            }
        }

        if(isAfter){

            List<Task> tasksToCreate = new List<Task>();
            List<Messaging.SingleEmailMessage> emailsToSend = new List<Messaging.SingleEmailMessage>();
            for(Opportunity opp : newMap.values()){
                Opportunity oldOpp = oldMap.get(opp.Id);
                if(opp.StageName == 'Closed Won' && oldOpp.StageName != 'Closed Won'){
                    // Task to be created
                    Task t = new Task(Subject = 'Follow up on Closed Won Opportunity',
                                    WhatId = opp.Id,
                                    OwnerId = opp.OwnerId,
                                    Status = 'Not Started',
                                    Priority = 'High');
                    tasksToCreate.add(t);

                    // Send email to Opportunity owner
                    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                    email.setSubject('Opportunity Closed Won: ' + opp.Name);
                    email.setPlainTextBody('Opportunity '+opp.Name + ' is Closed Won');
                    //email.setTargetObjectId(opp.OwnerId);
                    email.setToAddresses(new String[]{'ankit.ankush98@gmail.com'});
                    emailsToSend.add(email);
                }
            }

            if(!tasksToCreate.isEmpty()){
                insert tasksToCreate;
            }
            if(!emailsToSend.isEmpty()){
                Messaging.sendEmail(emailsToSend);
            }

        }
    }
}