public class OppotunityTrigger3Handler {
    public static void beforeUpdate(List<Opportunity> oppList, Map<Id, Opportunity> oldMap){
        for(Opportunity opp : oppList){
            if(oldMap != null && opp.StageName != oldmap.get(opp.Id).StageName){
                if(opp.StageName == 'Closed Won' && opp.Amount == null){
                    opp.addError('Amount can not be null');
                }
                
            }
        }
    }
    //Write down if opportunity is deleted, then update the associated account with a field description with the 
    //opportunity of particular amount is deleted with updated amount.
    public static void afterDeleteIfOppAmountDelUpdateRelAccWithDes(Map<Id, Opportunity> oldRecordsMap){
        Set<Id> accountIdSet = new Set<Id>();
        for(Opportunity oldOpp : oldRecordsMap.values()){
            if(oldOpp.AccountId != null){
                accountIdSet.add(oldOpp.AccountId);
            }
            
            
        }
        List<Account> accListToUpdate = new List<Account>();
        for(Opportunity opp : oldRecordsMap.values()){
            if(opp.AccountId != null && accountIdSet.contains(opp.AccountId)){
                Account acc = new Account();
                acc.Id = opp.AccountId;
                acc.Description = 'Opportunity Amount updated' + opp.Amount;
                accListToUpdate.add(acc);
            }
        }
        if(accListToUpdate.size() > 0){
            update accListToUpdate;
        }
    }
    //Write down if opportunity is deleted, then update the associated account with a field description 
    //with the opportunity of particular amount is deleted with updated amount.
    public static void afterDeleteIfOppAmountDelUpdateRelAccWithDes1(List<Opportunity> oppList){
        Set<Id> accountIdSet = new Set<Id>();
        for(Opportunity oldOpp : oppList){
            if(oldOpp.AccountId != null){
                accountIdSet.add(oldOpp.AccountId);
            }
            
        }
        List<Account> accListToUpdate = new List<Account>();
        for(Opportunity opp : oppList){
            Account acc = new Account();
            acc.Id = opp.AccountId;
            acc.Description = 'Account Updated with' + opp.Amount;
            accListToUpdate.add(acc);
         
        }
        if(accListToUpdate.size() > 0){
            update accListToUpdate;
        }
    }

   
    public static void beforeDeleteIfOppStageIsColsed(List<Opportunity> oppList){
        for(Opportunity opp : oppList){
            if(opp.StageName == 'Closed Won' || opp.StageName == 'Closed Lost'){
                opp.addError('If Stage is Closed Won Opportunity can not be deleted');
            }
        }
    }
    public static void setIsDirectToTrueWhenStageFromOpenToClose(List<Opportunity> oppList, Map<Id, Opportunity> oldMap){
        for(Opportunity opp : oppList){
            if(oldMap != null && opp.StageName != oldMap.get(opp.Id).StageName){
                if(oldMap.get(opp.Id).StageName == 'Qualification' && opp.StageName == 'Closed Lost'){
                    opp.directIsClosed__c = True;
                    
                    opp.Description = 'StageName changed from open to closed lost directly';
                }
            }
        }
    }
    public static void preventChangingAmount(List<Opportunity> oppList, Map<Id, Opportunity> oldMap){
        for(Opportunity opp : oppList){
            if(oldMap != null && opp.Amount != oldMap.get(opp.Id).Amount){
                if(opp.StageName == 'Closed Lost' || opp.StageName == 'Closed Won'){
                opp.addError('Amount can not be changed');
                }
            }
        }
    }
    public static void beforeInsertPreventDuplicateRating(List<Opportunity> oppList){
        Set<String> ratingSet = new Set<String>();
        for(Opportunity opp : oppList){
            if(opp.Rating__c != null){
               ratingSet.add(opp.Rating__c);
            }
           
        }
        
        List<Opportunity> existingOppList = [SELECT Id, Rating__c FROM Opportunity WHERE Rating__c IN: ratingSet];
        Set<String> existingRatingSet = new Set<String>();
        for(Opportunity opp : existingOppList){
            existingRatingSet.add(opp.Rating__c);
            
        }
        for(Opportunity opp : oppList){
            if(opp.Rating__c != null){
            if(existingRatingSet.contains(opp.Rating__c)){
                opp.addError('Rating Already Exists On Opportunity');
            }else{
                existingRatingSet.add(opp.Rating__c);
            }
        }
       }
    }
    public static void updateAmount(List<Opportunity> oppList, Map<Id, Opportunity> oldMap){
        for(Opportunity opp : oppList){
            if(oldMap != null && opp.Amount != oldMap.get(opp.Id).Amount ){
                if(opp.Amount < 0 ){
                    opp.addError('Amount can not be negative');
                }
            }
        }
        
    }
    public static void beforeInsertAmountCheck(List<Opportunity> oppList){
        for(Opportunity opp : opplist){
            if(opp.Amount != null && opp.Amount == 100){
                opp.Rating__c = 'low';
            }else if(opp.Amount != null && opp.Amount == 500){
                opp.Rating__c = 'good';
            }else if(opp.Amount != null && opp.Amount == 1000){
                opp.Rating__c = 'Excellent';
            }
        }
    }
    public static void closeDateGreaterThanToday(List<Opportunity> oppList, Map<Id, Opportunity> oldMap){
        for(Opportunity opp : oppList){
            if((oldMap == null && opp.CloseDate != null) || (oldMap != null && opp.CloseDate != oldMap.get(opp.Id).CloseDate)){
                if(opp.CloseDate < System.Today()){
                    opp.addError('Closed date should be greater than today');
                }
            }
        }
        
    }
    public static void preventMovingFromBackword(List<Opportunity> oppList, Map<Id, Opportunity> oldMap){
         
                   
        for(Opportunity opp : oppList){
            if(oldMap != null && opp.StageName != oldmap.get(opp.Id).StageName){
                Map<String, Integer> stageOrder = new Map<String, Integer>();
                    
                    stageOrder.put('Prospecting',1);
                    stageOrder.put('Qualification',2);
                    stageOrder.put('Needs Analysis',3);
                      
                    stageOrder.put('Value Proposition',4);
                    stageOrder.put('Id. Decision Makers',5);
                    stageOrder.put('Perception Analysis',6);
                    stageOrder.put('Proposal/Price Quote',7);
                    stageOrder.put('Closed Won',8);
                    stageOrder.put('Closed Lost',9);
               Integer newStageOrder = stageOrder.get(opp.StageName);
               Integer oldStageOrder = stageOrder.get(oldMap.get(opp.Id).StageName);
                if(newStageOrder < oldStageOrder){
                    opp.addError('You can not move backword');
                }
                    
                
                   
                
            }
        }
        
    }
    //when opportunity is closed no one can delete opportunity except system administartor
    public static void beforeDeleteOpp(List<Opportunity> oppList){
        Profile adminProfile = [SELECT Id, Name FROM Profile WHERE Name = 'System Administrator' LIMIT 1];
        for(Opportunity opp : oppList){
            if((opp.StageName == 'Closed Won' || opp.StageName == 'Closed Lost')
               && userInfo.getProfileId() != adminProfile.Id){//userInfo.getProfileId() != adminProfile.Id
                opp.addError('You can not delete these opportunity');
            }
            
            
        }
        
    }
    public static void preventApportunityDelRelatedToAcc(List<Account> accList, Map<Id, Account> oldMap){
        Set<Id> accIds = new Set<Id>();
        for(Account acc : accList){
            accIds.add(acc.Id);
        }
        
        for(Account acc : [SELECT Id,(SELECT Id FROM Opportunities) FROM Account WHERE Id IN :accIds]){
            if(acc.Opportunities != null){
                Account accDontDelete = oldMap.get(acc.Id);
                accDontDelete.addError('account can not be deleted');
            }
            
        }
        
        
    }
    

}