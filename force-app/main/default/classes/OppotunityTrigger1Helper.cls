public class OppotunityTrigger1Helper {
    public static void totalSumOfAmountOnOpp(Map<Id, Opportunity> newRecordsMap){
        Set<Id> accountIdSet = new Set<Id>();
        for(Opportunity opp : newRecordsMap.values()){
            if(opp.AccountId != null){
                accountIdSet.add(opp.AccountId);
            }
        }
        List<AggregateResult> aggList = [SELECT AccountId, SUM(Amount) SumOfAmount FROM Opportunity WHERE AccountId IN: accountIdSet 
                                        GROUP BY AccountId];
        List<Account> accountListToToUpdate = new List<Account>();
        for(AggregateResult ag : aggList){
            Id accountId = (Id)ag.get('AccountId');
            Decimal totalSumOfAmount = (Decimal)ag.get('SumOfAmount');
            Account accountRecord = new Account();
            accountRecord.Id = accountId;
            accountRecord.SumOfOpportunityAmount__c = totalSumOfAmount;
            accountListToToUpdate.add(accountRecord);
            accountIdSet.remove(accountId);
        }
        if(accountIdSet.size() > 0){
            for(Id accountId : accountIdSet){
                Account accountRecord = new Account();
                accountRecord.Id = accountId;
                accountRecord.SumOfOpportunityAmount__c = 0;
                accountListToToUpdate.add(accountRecord);
                accountIdSet.remove(accountId);
                
            }
        }
        if(accountListToToUpdate.size() > 0){
            update accountListToToUpdate;
        }
        

        
    }

}