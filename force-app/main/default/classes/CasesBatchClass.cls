public class CasesBatchClass implements Database.Batchable<sObject>{
    public Database.QueryLocator start(Database.BatchableContext batchContext){
        return Database.getQueryLocator('SELECT Id, Name FROM Account LIMIT 10');
    }
    public void execute(Database.BatchableContext batchContext, List<sObject> sObjectList){
        List<Account> accList = (List<Account>)sObjectList;
        for(Account acc : accList){
            acc.Name = acc.Name + 'Processed';
        }
        if(accList.size() > 0){
            update accList;
        }
    }
    public void finish(Database.BatchableContext batchContext){
        System.debug('Finish method executed successfully');
    }

}