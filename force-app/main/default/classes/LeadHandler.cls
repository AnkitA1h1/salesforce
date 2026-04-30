public with sharing class LeadHandler {
    public LeadHandler() {

    }

    public static void leadDataNormalization(List<Lead> listLead){

        for(Lead lead : listLead){
            if(lead.Email != null){
                lead.Email = lead.Email.toLowerCase();
            }
            if(lead.Phone != null){
                lead.Phone = lead.Phone.replaceAll('[^0-9]', '');
            }

            if(lead.LastName != null){
                lead.LastName = toProperCase(lead.LastName);
            }
            if(lead.FirstName != null){
                lead.FirstName = toProperCase(lead.FirstName);
            }
        }

    }


    private static String toProperCase(String str){
        List<String> words = str.toLowerCase().split(' ');
        String properCaseStr = '';

        for(String word : words){
            if(word.length() > 0){
                properCaseStr += word.substring(0,1).toUpperCase() + word.substring(1)+' ';
            }
        }

        return properCaseStr.trim();
    }
}