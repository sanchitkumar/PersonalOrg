trigger fieldupdate on Bid__c (before insert, before update) {
    for(Bid__c bid:trigger.new){
        List<Innvoice__c> inn=[select id,Company_Product__c from innvoice__c where id=:Bid.Innvoice__c limit 1];
        Bid.Company_Product__c = inn[0].Company_Product__c ;
        system.debug('------------'+inn[0].Company_Product__c);
    }
}