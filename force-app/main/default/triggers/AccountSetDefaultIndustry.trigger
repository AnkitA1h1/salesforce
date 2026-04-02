trigger AccountSetDefaultIndustry on Account (before insert) {
    for(Account acc : Trigger.new){
        if(acc.Industry == null){
            acc.industry = 'Technology';
        }
    }

}