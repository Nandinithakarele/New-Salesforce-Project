public class AccountTrigger2Handler {
    public static void handleBeforeUpdate(List<Account> newList, Map<Id, Account> oldMap){
        for(Account acc : newList){
            if(oldMap != null && acc.phone != oldMap.get(acc.Id).phone){
                acc.Description = 'Phone is modified on account';
            }
        }
        
    }
    
    public static void handleAfterUpdate(List<Account> newList, Map<Id, Account> oldMap){
        Map<Id, Account> accIdToAccountMap = new Map<Id, Account>();
             
        for(Account acc : newList){
            if(oldMap != null && acc.phone != oldMap.get(acc.Id).phone){
                accIdToAccountMap.put(acc.id, acc);
            }
        }
        
        List<Opportunity> oppListToBeUpdated = new List<Opportunity>() ;  
        for(Opportunity opp : [SELECT Id, Account_Phone__c, AccountId FROM Opportunity WHERE AccountId IN :accIdToAccountMap.keySet()]){
            
            if(accIdToAccountMap.containsKey(opp.AccountId)){
                
                opp.Account_Phone__c = accIdToAccountMap.get(opp.AccountId).phone;
                oppListToBeUpdated.add(opp);
            }
        }
        
        if(!oppListToBeUpdated.isEmpty()){
            update oppListToBeUpdated;
        }
        
    }

}