public class ContactTriggerHelper {
    
    public static void countContact(Map<Id, Contact> newRecordsMap){
        set<Id> accountIdSet = new Set<Id>();
        for(Contact con : newRecordsMap.values()){
            if(con.AccountId <> null){
                accountIdSet.add(con.AccountId);
            }
            
        }
        
        List<AggregateResult> agreegateList = [SELECT Count(Id) totalContact, accountId FROM Contact WHERE
                                              accountId IN : accountIdSet GROUP BY AccountId];
        //System.debug(agreegateList);
        List<Account> accountListToUpdate = new List<Account>();
        for(AggregateResult ag : agreegateList){
            String accountId = (String)ag.get('accountId');
            Integer totalContact = (Integer)ag.get('totalContact');
            Account accountRecord = new Account();
            accountRecord.Id = accountId;
            accountRecord.Total_Number_Of_Contacts__c = totalContact;
            accountListToUpdate.add(accountRecord);
            accountIdSet.remove(accountId);
        }
        if(accountIdSet.size() > 0){
            for(Id accountId : accountIdSet){
                Account accountRecord = new Account();
                accountRecord.Id = accountId;
                accountRecord.Total_Number_Of_Contacts__c = 0;
                accountListToUpdate.add(accountRecord);
            }
        }
        if(accountListToUpdate.size() > 0){
            update accountListToUpdate;
        }
        
        
        
    }

}