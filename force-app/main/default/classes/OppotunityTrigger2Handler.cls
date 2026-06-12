public class OppotunityTrigger2Handler {
    public static void afterInsert(List<Opportunity> oppList){
        List<Task> taskRecordToInsertList = new List<Task>();
        for(Opportunity opp : oppList){
            if(opp.AccountId == null){
                Task taskRecord = new Task();
                taskRecord.WhatId = opp.Id;
                taskRecord.OwnerId = opp.OwnerId;
                taskRecord.Subject = 'Opportunity is created Without Account';
                taskRecord.ActivityDate = System.today().addDays(7);
                taskRecord.Priority = 'High';
                taskRecord.Status = 'Not Started';
                taskRecord.Description = 'Opportunity is created';
                taskRecordToInsertList.add(taskRecord);
                    
                    
                }
                
                 
            }
            insert taskRecordToInsertList;
            
    }

}