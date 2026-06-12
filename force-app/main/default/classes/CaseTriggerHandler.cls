public class CaseTriggerHandler {
    public static Boolean runOnce = False;
    public static void afterInsertCase(List<Case> caseList){
        List<Case> caseToInsertList = new List<Case>();
        for(Case caseRecord : caseList){
            Case newcase = new Case();
            newCase.Status = caseRecord.Status;
            newCase.ContactId = caseRecord.ContactId;
            newCase.Origin = caseRecord.Origin;
            newCase.ParentId = caseRecord.Id;
            newCase.Subject = caseRecord.Subject;
            newCase.Description = caseRecord.Description;
            newCase.Priority = caseRecord.Priority;
            caseToInsertList.add(newCase);
            
       
        }
        runOnce = True;
        insert caseToInsertList;
        
    }
    public static void beforeUpdateOnlyTwoCaseWantRelToAcc(List<Case> caseList, Map<Id, Case> oldMap){
        for(Case cs : caseList){
            if(cs.AccountId != null){
                if(cs.Cases.size() > 0){
                    cs.addError('You can not create thirs case');
                }
            }
        }
    }
    public static void beforeUpdateStatusCanNotChangeCloseToOpen(List<Case> caseList, Map<Id, Case> oldMap){
        for(Case c : caseList){
            if(oldMap != null && c.Status != oldMap.get(c.Id).Status){
                if(oldMap.get(c.Id).Status == 'Closed' && c.Status == 'New'){
                c.Status.addError('status can not be changed from closed to open');
                }
            }
            
        }
    }
    public static void ifCaseDeletedUpdateFieldLastCaseWithTodaysdate(List<Case> caseList){
        for(Case cs : caseList){
            
        }
        
    }

}