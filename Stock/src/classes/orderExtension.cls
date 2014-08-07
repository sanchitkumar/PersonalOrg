public class orderExtension {

  private final Bid__c Bid;

  public orderExtension (ApexPages.StandardController stdController) {
    Bid = (Bid__c) stdController.getRecord();
  }
}