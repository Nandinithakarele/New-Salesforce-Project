public class OpportunityTrigger1Dispatcher {
    public static void dispatch(System.TriggerOperation operationType){
        switch on operationType{
            WHEN AFTER_INSERT{
                OpportunityTrigger1Handler.handleAfterInsert((List<Opportunity>)Trigger.New);
            }
            WHEN ELSE{
                
            }
                
     }
        
   }
    
}