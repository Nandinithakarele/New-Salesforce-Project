public class AccountTrigger1Dispatcher {
    public static void dispatch(System.TriggerOperation operationType){
        switch on operationType{
            WHEN BEFORE_INSERT{
                AccountTrigger1Handler.handleBeforeInsert(Trigger.New);
            }
            WHEN BEFORE_UPDATE{
                AccountTrigger1Handler.handleBeforeUpdate(Trigger.New);
            }
            WHEN AFTER_INSERT{
                AccountTrigger1Handler.handleAfterInsert(Trigger.New);
            }
            WHEN AFTER_UPDATE{
                AccountTrigger1Handler.handleAfterUpdate(Trigger.New);
            }
            WHEN AFTER_DELETE{
               // AccountTrigger1Handler.handleAfterDelete(Trigger.New);
            }
            WHEN AFTER_UNDELETE{
                AccountTrigger1Handler.handleAfterUnDelete(Trigger.New);
            }
            WHEN ELSE {
                
            }
            
     }
        
   }
    
}