public class ContactsBatchable implements Database.Batchable<sObject>{
    public Database.QueryLocator start(Database.BatchableContext context){
        System.debug('Start Method');
        return Database.getQueryLocator('SELECT Id, Name FROM Contact WHERE AccountId != null');
    }
    
    public void execute(Database.BatchableContext context, List<sObject> sObjectList){
        List<Contact> contactList = (List<Contact>)sObjectList;
        for(Contact con : (List<Contact>)sObjectList){
            System.debug(con.Id);
            System.debug(contactList.size());
        }
        System.debug('Execute Method');
        
    }
    public void finish(Database.BatchableContext context){
        System.debug('Finish Method');
        
    }

}