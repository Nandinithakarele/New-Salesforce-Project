public class CustomObjectsRollupSummaryTriggerHandler {
    public static void handleAfterInsert(Map<Id, Candidate__c> newRecordsMap){
        Set<Id> jobIdSet = new Set<Id>();
        for(Candidate__c newCad : newRecordsMap.values()){
            if(newCad.JobId__c != null){
                jobIdSet.add(newCad.JobId__c);
            }
        }
        List<AggregateResult> aggList1 = [SELECT JobId__c, COUNT(Id) CountOfPassCand FROM Candidate__c WHERE 
                                         (JobId__c IN: jobIdSet AND Status__c = 'Pass')
                                         GROUP BY JobId__c];
        List<Job__c> jobListToUpdate1 = new List<Job__c>();
        for(AggregateResult ag1 : aggList1){
            Id jobId = (Id)ag1.get('JobId__c');
            Integer totalPassCand = (Integer)ag1.get('CountOfPassCand');
            Job__c jobRecord1 = new Job__c();
            jobRecord1.Id = jobId;
            jobRecord1.Total_Number_Of_Pass_Candidate__c = totalPassCand;
            jobListToUpdate1.add(jobRecord1);
        }
        if(jobListToUpdate1.size() > 0){
            update jobListToUpdate1;
        }
        List<AggregateResult> aggList2 = [SELECT JobId__c, COUNT(Id) CountOfFailCand FROM Candidate__c WHERE 
                                         (JobId__c IN: jobIdSet AND Status__c = 'Fail')
                                         GROUP BY JobId__c];
        List<Job__c> jobListToUpdate2 = new List<Job__c>();
        for(AggregateResult ag2 : aggList2){
            Id jobId = (Id)ag2.get('JobId__c');
            Integer totalPassCand = (Integer)ag2.get('CountOfFailCand');
            Job__c jobRecord2 = new Job__c();
            jobRecord2.Id = jobId;
            jobRecord2.Total_Number_Of_Fail_Candidate__c = totalPassCand;
            jobListToUpdate2.add(jobRecord2);
        }
        if(jobListToUpdate2.size() > 0){
            update jobListToUpdate2;
        }
            
    }
    public static void handleAfterUpdate(Map<Id, Candidate__c> newRecordsMap, Map<Id, Candidate__c> oldRecordsMap){
        Set<Id> jobIdSet = new Set<Id>();
        for(Candidate__c newRecord : newRecordsMap.values()){
            Candidate__c oldRecord = oldRecordsMap.get(newRecord.Id);
            if(oldRecord.JobId__c != newRecord.JobId__c || oldRecord.Status__c != newRecord.Status__c){
                if(oldRecord.JobId__c != null){
                    jobIdSet.add(oldRecord.JobId__c);
                }
                if(newRecord.JobId__c != null){
                    jobIdSet.add(newRecord.JobId__c);
                }
            }
        }
        List<AggregateResult> aggList1 = [SELECT JobId__c, COUNT(Id) CountOfPassCand FROM Candidate__c WHERE 
                                         (JobId__c IN: jobIdSet AND Status__c = 'Pass')
                                         GROUP BY JobId__c];
        List<Job__c> jobListToUpdate1 = new List<Job__c>();
        for(AggregateResult ag1 : aggList1){
            Id jobId = (Id)ag1.get('JobId__c');
            Integer totalPassCand = (Integer)ag1.get('CountOfPassCand');
            Job__c jobRecord1 = new Job__c();
            jobRecord1.Id = jobId;
            jobRecord1.Total_Number_Of_Pass_Candidate__c = totalPassCand;
            jobListToUpdate1.add(jobRecord1);
        }
        if(jobListToUpdate1.size() > 0){
            update jobListToUpdate1;
        }
        List<AggregateResult> aggList2 = [SELECT JobId__c, COUNT(Id) CountOfFailCand FROM Candidate__c WHERE 
                                         (JobId__c IN: jobIdSet AND Status__c = 'Fail')
                                         GROUP BY JobId__c];
        List<Job__c> jobListToUpdate2 = new List<Job__c>();
        for(AggregateResult ag2 : aggList2){
            Id jobId = (Id)ag2.get('JobId__c');
            Integer totalPassCand = (Integer)ag2.get('CountOfFailCand');
            Job__c jobRecord2 = new Job__c();
            jobRecord2.Id = jobId;
            jobRecord2.Total_Number_Of_Fail_Candidate__c = totalPassCand;
            jobListToUpdate2.add(jobRecord2);
        }
        if(jobListToUpdate2.size() > 0){
            update jobListToUpdate2;
        }
    }

}