public class RollUpSummaryCaseTriggerHandler {
    public static void handlerAfterInsert(Map<Id, Case> newRecordsMap){
        RollUpSummaryCaseTriggerHelper.countHighPriorityCases(newRecordsMap);
        
    }
    public static void handlerAfterDelete(Map<Id, Case> oldRecordsMap){
        RollUpSummaryCaseTriggerHelper.countHighPriorityCases(oldRecordsMap);
        
    }
    public static void handlerAfterUnDelete(Map<Id, Case> newRecordsMap){
        RollUpSummaryCaseTriggerHelper.countHighPriorityCases(newRecordsMap);
        
    }
    
    /*public static void handlerAfterUpdate(Map<Id, Case> newRecordsMap, Map<Id, Case> oldRecordsMap){
        Set<Id> accountIdSet = new Set<Id>();
        for(Case newRecord : newRecordsMap.values()){
            Case oldRecord = oldRecordsMap.get(newRecord.Id);
            if(oldRecord.AccountId != newRecord.AccountId){
                if(oldRecord.AccountId != null){
                    accountIdSet.add(oldRecord.AccountId);
                }
                if(newRecord.AccountId != null){
                    accountIdSet.add(newRecord.AccountId);
                }
                
                
            }else if(oldRecord.Priority != newRecord.Priority){
                if(newRecord.AccountId != null){
                    accountIdSet.add(newRecord.AccountId);
                }
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
        
    }*/
    public static void handlerAfterUpdate(Map<Id, Case> newRecordsMap, Map<Id, Case> oldRecordsMap){
    Set<Id> accountIdSet = new Set<Id>();

    // 1️⃣ Collect affected Account Ids
    for (Case newRecord : newRecordsMap.values()) {
        Case oldRecord = oldRecordsMap.get(newRecord.Id);

        // Case 1: Account changed
        if (oldRecord.AccountId != newRecord.AccountId) {
            if (oldRecord.AccountId != null) {
                accountIdSet.add(oldRecord.AccountId);
            }
            if (newRecord.AccountId != null) {
                accountIdSet.add(newRecord.AccountId);
            }
        }
        // Case 2: Priority changed
        else if (oldRecord.Priority != newRecord.Priority) {
            if (newRecord.AccountId != null) {
                accountIdSet.add(newRecord.AccountId);
            }
        }
    }

    // If nothing to update, exit early
    if (accountIdSet.isEmpty()) return;

    // 2️⃣ Query HIGH priority Case count for affected Accounts
    List<AggregateResult> aggList = [
        SELECT AccountId, COUNT(Id) CountOfCases
        FROM Case
        WHERE AccountId IN :accountIdSet
        AND Priority = 'HIGH'
        GROUP BY AccountId
    ];

    List<Account> accListToUpdate = new List<Account>();
    Set<Id> processedAccIds = new Set<Id>();

    // 3️⃣ Accounts that HAVE high priority cases
    for (AggregateResult ag : aggList) {
        Id accId = (Id) ag.get('AccountId');
        Integer totalHighPriorityCases = (Integer) ag.get('CountOfCases');

        Account acc = new Account();
        acc.Id = accId;
        acc.NumberOfHighPriorityCases__c = totalHighPriorityCases;

        accListToUpdate.add(acc);
        processedAccIds.add(accId);
    }

    // 4️⃣ Accounts that have ZERO high priority cases (including last case deleted)
    for (Id accId : accountIdSet) {
        if (!processedAccIds.contains(accId)) {
            Account acc = new Account();
            acc.Id = accId;
            acc.NumberOfHighPriorityCases__c = 0;

            accListToUpdate.add(acc);
        }
    }

    // 5️⃣ Final update
    if (!accListToUpdate.isEmpty()) {
        update accListToUpdate;
    }
}


}