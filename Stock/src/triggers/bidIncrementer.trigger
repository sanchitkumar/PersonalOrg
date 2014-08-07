trigger bidIncrementer on Bid__c (before insert, after insert) {
    
    if(trigger.isAfter && trigger.isInsert){
        bidIncrementerHandler.incrementBid(Trigger.New);
    }
  
}