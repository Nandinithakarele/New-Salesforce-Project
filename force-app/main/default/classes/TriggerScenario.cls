public class TriggerScenario { 
    //Create a trigger that updates the "Last Modified Date" field of an Account record whenever a
     //related Contact record is updated
    public static void afterUpdateHandler(List<Contact> conList, Map<Id, Contact> oldRecordsMap){
        Set<Id> accountIdSet = new Set<Id>();
        for(Contact newRecord : conList){
            if(newRecord.AccountId != null){
                accountIdSet.add(newRecord.AccountId);
            }
            }
        
        List<Account> accList = [SELECT Last_Modified_Date__c, Id, Name FROM Account WHERE Id IN: accountIdSet];
        List<Account> accListToUpdate = new List<Account>();
        for(Account acc : accList){
            acc.Last_Modified_Date__c = Date.Today();
            accListToUpdate.add(acc);
        }
        if(accListToUpdate.size() > 0){
            update accListToUpdate;
        }
    }

}