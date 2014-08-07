public with sharing class EmailMessageHandler {
    /*

    *@Description: On before insert event this method stops users from sending emails to the blocked email addresses stored in Blocked_Email_Addresses__c custom setting

    *@Date: 29-07-2014

    *@Parameters: List of new emails(Trigger.New)

    *@Author: Prateek Gandhi

    */

    public static void onBeforeInsert(final List<EmailMessage> newEmails) {

        List<String> recipients; //list of message recipients 

        Map<String,String> blockedEmailAddressMap = New Map<String,String>();// Map of blocked email ids

        //Getting the blocked email ids from Blocked_Email_Addresses__c custom setting

        for( Blocked_Email_Addresses__c emailAddress : Blocked_Email_Addresses__c.getall().values() ){

            if(!blockedEmailAddressMap.containsKey(emailAddress.Name)) blockedEmailAddressMap.put(emailAddress.Name, emailAddress.Name);

        }
        for(EmailMessage message: newEmails){

            recipients= new List<String>();

            if(!message.Incoming){// check should be for outgoing emails only

                // check for ToAddress 

                if(message.ToAddress!=null){

                    if(message.ToAddress.contains(';')){// multiple ToAddresses

                        recipients.addAll(message.ToAddress.Split(';'));

                    }else{

                        recipients.add(message.ToAddress.trim()); // single ToAddress

                    }

                }

                if(message.BccAddress!=null){

                    if(message.BccAddress.contains(';')){ // multiple BccAddress

                        recipients.addAll(message.BccAddress.Split(';'));

                    }else{ // single BccAddress

                        recipients.add(message.BccAddress.trim());

                    }
                }
                if(message.CcAddress!=null){

                    if(message.CcAddress.contains(';')){ // multiple CcAddress

                        recipients.addAll(message.CcAddress.Split(';'));

                    }else{  // single CcAddress

                        recipients.add(message.CcAddress.trim());

                    }

                }
                for(String emailAdress : recipients){

                    if(blockedEmailAddressMap.containsKey(emailAdress)){

                        message.addError('Email Id Blocked- Email cannot be sent to : '+emailAdress);

                    }

                }

            }

        }

    }

}