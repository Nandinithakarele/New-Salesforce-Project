/*
 * List<Account> accList = new List<Account>();
OpportunitiesBatchClass batchable = new OpportunitiesBatchClass('Hot', accList);
Id jobId = Database.executeBatch(batchable);
System.debug(jobId);
*/

public class OpportunitiesBatchClass implements Database.Batchable<sObject>{
    private String rating;
    private List<Account> accList;
    public OpportunitiesBatchClass(String Rating, List<Account> accountRecordList){
        this.rating = Rating;
        this.accList = accountRecordList;
        
    }
    public Database.QueryLocator start(Database.BatchableContext ctx){
        System.debug('start method executed');
        String rating;
        return Database.getQueryLocator('SELECT Id, Name FROM Account WHERE Rating =: rating');
    }
    public void execute(Database.BatchableContext ctx, List<sObject> sObjectList){
        List<Account> accList = (List<Account>)sObjectList;
        System.debug(acclist.size());
        System.debug('execute method executed');
    }
    public void finish(Database.BatchableContext ctx){
        System.debug('finish method executed');
        AccountsBatchable batchable = new AccountsBatchable('Hot', accList);
        Id jobId = Database.executeBatch(batchable, 1);
        System.debug(jobId);
    }

}