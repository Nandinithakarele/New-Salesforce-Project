public class ContactTriggerDispatcher {
    public static void dispatch(System.TriggerOperation operationType){
        switch on operationType{
            WHEN AFTER_INSERT{
                ContactTriggerHandler.handleAfterInsert((Map<Id, Contact>)Trigger.newMap);
            }
            WHEN AFTER_UPDATE{
                ContactTriggerHandler.handleAfterUpdate((Map<Id, Contact>)Trigger.newMap, (Map<Id, Contact>)Trigger.oldMap);
                //ContactTriggerHandler.handleAfterUpdateDescriptionFieldOnAcc((Map<Id, Contact>)Trigger.newMap, (Map<Id, Contact>)Trigger.oldMap);
                ContactTriggerHandler.handleAfterUpdateDescriptionFieldOnAcc2(Trigger.New, (Map<Id, Contact>)Trigger.oldMap);
            }
            WHEN AFTER_DELETE{
                ContactTriggerHandler.handleAfterDelete((Map<Id, Contact>)Trigger.oldMap);
            }
            WHEN AFTER_UNDELETE{
                ContactTriggerHandler.handleAfterUnDelete((Map<Id, Contact>)Trigger.newMap);
            }
            WHEN ELSE {
                
            }
            
     }
        
   }

}