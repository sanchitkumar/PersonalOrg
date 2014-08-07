trigger mail on Bid__c (After insert, After update) {
    try
    {
        system.debug('---------');
        List<Id> productList = new List<Id>();
        list<Bid__c> b = new List<Bid__c>();
        List<Bid__c> bidList = new List<Bid__c>();
          /*  for(Bid__c bid : trigger.new){
            Id Productid = bid.Company_Product__c; 
            Decimal amount = bid.Bid_Amount__c;
            b = [select Bid_Amount__c, Contact__c,Contact__r.Email,  from Bid__c where Bid_Amount__c <= :amount and Company_Product__c = :Productid];
            System.debug(b);
        } */
        //Map<Id,Decimal> productmap = new Map<Id,Decimal>();
        for(Bid__c bid : trigger.new){
        system.debug('bid.Company_Product__c----------'+bid.Company_Product__c);
        productList.add(bid.Company_Product__c);
        }
       // Map<Bid__c,Bid_Amount__c > ;
        bidList = [select Bid_Amount__c, Contact__c,Contact__r.Email,Company_Product__c  from Bid__c where Company_Product__c in :productList];
        Map<Bid__c,List<Bid__c>> mainMap = new Map<Bid__c,List<Bid__c>>();
        for(Bid__c bid : trigger.new){
            List<Bid__c> TempBid= new List<Bid__c>();
            for(Bid__c sid : bidList){
                if((bid.Company_Product__c == sid.Company_Product__c) && (bid.Bid_Amount__c > sid.Bid_Amount__c )){
                    TempBid.add(sid);
                }
            mainMap.put(bid,TempBid);
            }
        }
        system.debug('bidList--------'+ bidList);
        EmailTemplate et = [SELECT id FROM EmailTemplate WHERE developerName = 'Auto_correct_bid_mail'];
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        for(bid__c bid : Mainmap.keyset()){
                List<Bid__c> keyset = Mainmap.get(bid);
                for(Bid__c newbid : keyset){
            Messaging.SingleEmailMessage m = new Messaging.SingleEmailMessage();
            m.setSenderDisplayName('Bid Administrator');
            m.setTemplateId(et.id);
            m.setTargetObjectId(newbid.Contact__c);
            m.setWhatId(trigger.new[0].id);
            m.ToAddresses=new String[] {newbid.Contact__r.Email};
            mails.add(m);
                 }
         }
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