public class AccountTrigger1Handler {
    public static void handleBeforeInsert(List<Account> accList){
        for(Account acc : accList){
            if(acc.Industry == 'Banking' || acc.Industry == 'Healthcare'){
                acc.Rating = 'Hot';
            }
        }
        
    }
    
    public static void handleBeforeUpdate(List<Account> accList){
        
        
    }
    
    public static void handleAfterInsert(List<Account> accList){
        
    }
    public static void handleAfterUpdate(List<Account> accList){
        
    }
    public static void handleAfterDelete(Map<Id, Account> oldMap){
        
    }
    public static void handleAfterUnDelete(List<Account> accList){
        
    }

}