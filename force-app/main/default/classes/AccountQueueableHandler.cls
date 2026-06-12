public class AccountQueueableHandler {
    public static Account prepareAccount(Set<Id> accountIdSet){
       Account accountRecord = new Account();
        System.debug('Queueuable executed');
        List<Account> accountRecordList = [SELECT Id, Name FROM Account WHERE Id IN: accountIdSet];
        for(Account acc : accountRecordList){
            
        }
        ContactQueueable queueable = new ContactQueueable(10, accountRecordList);
        Id jobId = System.enqueueJob(queueable);
        System.debug('Child jobId' + jobId);
        
        ContactQueueable queueable1 = new ContactQueueable(10, accountRecordList);
        Id jobId1 = System.enqueueJob(queueable);
        System.debug('Child jobId' + jobId1);


        
       return accountRecord;
    }

}