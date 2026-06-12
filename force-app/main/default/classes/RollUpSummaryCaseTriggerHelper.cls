public class RollUpSummaryCaseTriggerHelper {
    public static void countHighPriorityCases(Map<Id, Case> newRecordsMap){
        Set<Id> accountIdSet = new Set<Id>();
        for(Case cs : newRecordsMap.values()){
            if(cs.AccountId != null){
                accountIdSet.add(cs.AccountId);
            }
        }
        List<AggregateResult> aggList = [SELECT AccountId, Count(Id) CountOfCases FROM Case WHERE (AccountId IN: accountIdSet 
                                         AND Priority = 'HIGH') GROUP BY AccountId];
        List<Account> accListToUpdate = new List<Account>();
        for(AggregateResult ag : aggList){
            Id accId = (Id)ag.get('AccountId');
            Integer totalHighPriorityCases = (Integer)ag.get('CountOfCases');
            Account accountRecord = new Account();
            accountRecord.Id = accId;
            accountRecord.NumberOfHighPriorityCases__c = totalHighPriorityCases;
            accListToUpdate.add(accountRecord);
            accountIdSet.remove(accId);
        }
        if(accountIdSet.size() > 0){
            for(Id accId : accountIdSet){
                Account accountRecord = new Account();
                accountRecord.Id = accId;
                accountRecord.NumberOfHighPriorityCases__c = 0;
                accListToUpdate.add(accountRecord);
                accountIdSet.remove(accId);
            }
        }
        if(accListToUpdate.size() > 0){
            update accListToUpdate;
        }
        
    }

}