public class OpportunityTriggerHandler {
    public static void handleBeforeInsert(List<Opportunity> OpportunityList){
        for(Opportunity opp : OpportunityList){
            if(opp.Amount != null && opp.Discount__c != null){
                Decimal discount = (opp.Amount * opp.Discount__c) / 100;
                Decimal discountedAmount = opp.Amount - discount;
                
                opp.Discounted_Price__c = discount;
                opp.Price_After_Discount__c = discountedAmount;
            }
        }
        
    }
    
    public static void handleBeforeupdate(List<Opportunity> newRecords, Map<Id, Opportunity> oldRecordMap){
        for(Opportunity newRecord : newRecords){
            Opportunity oldRecord = oldRecordMap.get(newRecord.Id);
        if(newRecord.stageName == 'Closed Won' && oldRecord.stageName == 'Closed Won' && newRecord.Amount <>  oldRecord.Amount ){
            newRecord.Amount.addError('amount can not be change');
         }
        }
    }
    
    public static void handleAfterUpdate(List<Account> accList, Map<Id, Account> oldMap){
        Map<Id, Account> accIdMap = new Map<Id, Account>();
        for(Account acc : accList){
            if(oldMap != null && acc.Phone != oldMap.get(acc.Id).phone){
                accIdMap.put(acc.Id, acc);
            }
            
        }
        list<Opportunity> oppListToUpdate = new List<Opportunity>();
        for(Opportunity opp : [SELECT AccountId, Account_Phone__c FROM Opportunity WHERE AccountId In: accIdMap.keySet()]){
            if(accIdMap.containsKey(opp.AccountId)){
                opp.Account_Phone__c = oldMap.get(opp.AccountId).Phone;
                oppListToUpdate.add(opp);
            }
            
        }
        if(oppListToUpdate.size() > 0){
            update oppListToUpdate;
        }
        
    }
 }