public class OppotunityTrigger1Handler {
    public static void handleAfterInsert(Map<Id, Opportunity> newRecordsMap){
        OppotunityTrigger1Helper.totalSumOfAmountOnOpp(newRecordsMap);
    }
    public static void handleAfterUpdate(Map<Id, Opportunity> newRecordsMap, Map<Id, Opportunity> oldRecordsMap){
        Set<Id> accountIdSet = new Set<Id>();
        for(Opportunity newRecord : newRecordsMap.values()){
            Opportunity oldRecord = oldRecordsMap.get(newRecord.Id);
            // CASE 1: Account changed
            if(oldRecord.AccountId != newRecord.AccountId){
                if(oldRecord.AccountId != null){
                    accountIdSet.add(oldRecord.AccountId);
                }
                if(newRecord.AccountId != null){
                    accountIdSet.add(newRecord.AccountId);
                 
                }
            }
            // CASE 2: Account same but Amount changed
            else if(oldRecord.Amount != newRecord.Amount){
                    if(newRecord.AccountId != null){
                    accountIdSet.add(newRecord.AccountId);
                    }
                }
        }
        List<AggregateResult> aggList = [SELECT AccountId, SUM(Amount) SumOfAmount FROM Opportunity WHERE AccountId IN: accountIdSet 
                                        GROUP BY AccountId];
        List<Account> accountListToToUpdate = new List<Account>();
        //Set<Id> processedAccId = new Set<Id>();
        for(AggregateResult ag : aggList){
            Id accountId = (Id)ag.get('AccountId');
            Decimal totalSumOfAmount = (Decimal)ag.get('SumOfAmount');
            Account accountRecord = new Account();
            accountRecord.Id = accountId;
            accountRecord.SumOfOpportunityAmount__c = totalSumOfAmount;
            accountListToToUpdate.add(accountRecord);
            accountIdSet.remove(accountId);
           // processedAccId.add(accountId);
        }
        if(accountIdSet.size() > 0){
            for(Id accountId : accountIdSet){
                //if(!processedAccId.Contains(accountId)){
                Account accountRecord = new Account();
                accountRecord.Id = accountId;
                accountRecord.SumOfOpportunityAmount__c = 0;
                accountListToToUpdate.add(accountRecord);
                
                
            }
        }
        if(accountListToToUpdate.size() > 0){
            update accountListToToUpdate;
        }
        

        
        
    }
    public static void handleAfterDelete(Map<Id, Opportunity> oldRecordsMap){
        OppotunityTrigger1Helper.totalSumOfAmountOnOpp(oldRecordsMap);
    }
    public static void handleAfterUnDelete(Map<Id, Opportunity> newRecordsMap){
        OppotunityTrigger1Helper.totalSumOfAmountOnOpp(newRecordsMap);
    }

}