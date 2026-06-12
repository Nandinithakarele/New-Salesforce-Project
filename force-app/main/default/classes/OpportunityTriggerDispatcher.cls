public class OpportunityTriggerDispatcher {
     public static void dispatch(System.TriggerOperation operationType){
        switch on operationType{
            WHEN BEFORE_INSERT{
                OpportunityTriggerHandler.handleBeforeInsert(Trigger.New);
            }
            WHEN AFTER_INSERT{
                
            }
            WHEN BEFORE_UPDATE{
                OpportunityTriggerHandler.handleBeforeUpdate(Trigger.New, (Map<Id, Opportunity>)Trigger.oldMap);
            }
            wHEN AFTER_UPDATE{
                
            }
            WHEN ELSE {
                
            }
            
            }

}

}