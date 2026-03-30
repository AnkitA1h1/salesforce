trigger ContexTrigger on Case (before insert,after insert,before update,after update,before delete,after delete,after undelete) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            System.debug('Before Insert');
            for(Case c : Trigger.new){
                c.Description = 'before';
            }
        }
        else if(Trigger.isUpdate){
            System.debug('Before Update');
        }
        else if(Trigger.isDelete){
            System.debug('Before Delete');
        }
    }
    else if(Trigger.isAfter){
        if(Trigger.isInsert){
            System.debug('After Insert');
            List<Case> caseUpdate = new List<Case>();
            for(Case c : Trigger.new){
                caseUpdate.add(new Case(Id=c.Id, 
                    Description = c.Description+'after'));
            }
            update caseUpdate;
        }
        else if(Trigger.isUpdate){
            System.debug('After Update');
        }
        else if(Trigger.isDelete){
            System.debug('After Delete');
        }
    }
     else if(Trigger.isUndelete){
            System.debug('After Undelete');
     }

}