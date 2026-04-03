public with sharing class ContactHandler {
    public ContactHandler() {

    }


    public static void ContactSetDescriptionBeforeInsert(List<Contact> contact){
        for(Contact con : contact){
            if(con.Description == null){
                con.Description = 'New Customer';
            }
        }
    }
}