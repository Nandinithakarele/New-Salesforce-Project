public class AccountTriggerDispatcher {
     public static void dispatch(System.TriggerOperation operationType){
        switch on operationType{
            WHEN BEFORE_INSERT{
                AccountTriggerHandler.handleBeforeInsert(Trigger.New);
            }
            WHEN AFTER_INSERT{
                AccountTriggerHandler.handleAfterInsert(Trigger.New);
            }
    
            WHEN BEFORE_UPDATE{
                AccountTriggerHandler.handleBeforeUpdate(Trigger.New);
            }
            wHEN AFTER_UPDATE{
                
            }
            WHEN ELSE {
                
            }
           
            }

}
    
}