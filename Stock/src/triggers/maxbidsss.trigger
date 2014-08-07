trigger maxbidsss on Company_Product__c (before update) {
    try{
        list<Company__c> productList=new List<Company__c>();
        Innvoice__c invMail;
        //list<Innvoice__c> inv=new List<Innvoice__c>();
   //     list<Innvoice__c> invList=new List<Innvoice__c>();
            for(Company_Product__c inv:trigger.new){
               invMail= [select id,Key_Contact__c,Key_Contact__r.Email, Total_Bid_amt__c from Innvoice__c where Company_Product__c = :inv.id order by Total_Bid_amt__c desc limit 1];
               System.debug(invMail.id + '--'+invMail.Total_Bid_amt__c);
             }
             
    
    EmailTemplate et = [SELECT id FROM EmailTemplate WHERE developerName = 'Winner_Email'];
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
            Messaging.SingleEmailMessage m = new Messaging.SingleEmailMessage();
            m.setSenderDisplayName('Bid Administrator');
            m.setTemplateId(et.id);
            m.setTargetObjectId(invMail.Key_Contact__c);
            m.setWhatId(trigger.new[0].id);
            m.ToAddresses=new String[] {invMail.Key_Contact__r.Email};
            mails.add(m);
        
       if(mails != null && mails.size()>0){
                for(Integer i=0; i<= mails.size()/10;i++){
                    List<Messaging.SingleEmailMessage> mailBatch = new List<Messaging.SingleEmailMessage>();
                    for(Integer j=10*i;((j<10*(i+1))&&(j<mails.size()));j++){
                        mailBatch.add(mails[j]);
                    }
                    if(mailBatch != null && mailBatch.size()>0)
                        Messaging.sendEmail(mailBatch);
               }
       } 
     }
     catch(Exception e){
             System.debug('======'+e.getMessage());
     }
     }