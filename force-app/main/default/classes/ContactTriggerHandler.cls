public class ContactTriggerHandler {
    public static void handleAfterInsert(Map<Id, Contact> newRecordsMap){
        ContactTriggerHelper.countContact(newRecordsMap);
    }
     
    public static void handleAfterDelete(Map<Id, Contact> oldRecordsMap){
        ContactTriggerHelper.countContact(oldRecordsMap); 
    }
    public static void handleAfterUnDelete(Map<Id, Contact> newRecordsMap){
        ContactTriggerHelper.countContact(newRecordsMap);

    }
    public static void handleAfterUpdate(Map<Id, Contact> newRecordsMap, Map<Id, Contact> oldRecordsMap){
        Set<Id> accountIdSet = new Set<Id>();
        for(Contact newRecord : newRecordsMap.values()){
            Contact oldRecord = oldRecordsMap.get(newRecord.Id);
            if(oldRecord.accountId <> newRecord.accountId){
                accountIdSet.add(oldRecord.accountId);
                accountIdSet.add(newRecord.accountId);
                
            }
            
        }
        
         List<AggregateResult> agreegateList = [SELECT Count(Id) totalContact, accountId FROM Contact WHERE
                                              accountId IN : accountIdSet GROUP BY AccountId];
        //System.debug(agreegateList);
        List<Account> accountListToUpdate = new List<Account>();
        for(AggregateResult ag : agreegateList){
            String accountId = (String)ag.get('accountId');
            Integer totalContact = (Integer)ag.get('totalContact');
            Account accountRecord = new Account();
            accountRecord.Id = accountId;
            accountRecord.Total_Number_Of_Contacts__c = totalContact;
            accountListToUpdate.add(accountRecord);
            accountIdSet.remove(accountId);
        }
        if(accountIdSet.size() > 0){
            for(Id accountId : accountIdSet){
                Account accountRecord = new Account();
                accountRecord.Id = accountId;
                accountRecord.Total_Number_Of_Contacts__c = 0;
                accountListToUpdate.add(accountRecord);
            }
        }
        if(accountListToUpdate.size() > 0){
            update accountListToUpdate;
        }
        
        
        

        
    }
    //Write an Apex handler method that updates the parent Account’s Description field with the modified phone number whenever a 
    //Contact’s Phone or AccountId is updated.Using Trigger.New and Trigger.oldMap
    public static void handleAfterUpdateDescriptionFieldOnAcc2(List<Contact> conList, Map<Id, Contact> oldRecordsMap){
        Set<Id> accountIdSet = new Set<Id>();
        for(Contact newRecord : conList){
            contact oldRecord = oldRecordsMap.get(newRecord.Id);
            if(oldRecord.AccountId != newRecord.AccountId){
                if(oldRecord.AccountId != null){
                   accountIdSet.add(oldRecord.AccountId); 
                }
                if(newRecord.AccountId != null){
                    accountIdSet.add(newRecord.AccountId);
                }
            }else if(newRecord.Phone != oldRecord.Phone){
                if(newRecord.AccountId != null){
                    accountIdSet.add(newRecord.AccountId);
                }
            }
        }
        List<Account> accList = [SELECT Id, Description FROM Account WHERE Id IN: accountIdSet];
        List<Account> accountListToUpdate = new List<Account>();
        for(Account acc : accList){
            for(Contact con : conList){
                if(con.AccountId == acc.Id){
                    acc.Description = 'Contact Updated' + con.Phone;
                    accountListToUpdate.add(acc);
                }
            }
            
            
        }
        if(accountListToUpdate.size() > 0){
            update accountListToUpdate;
        }

        
    }
    
    //Write an Apex handler method that updates the parent Account’s Description field with the modified phone number whenever a 
    //Contact’s Phone or AccountId is updated.Using Trigger.NewMap and Trigger.oldMap
    public static void handleAfterUpdateDescriptionFieldOnAcc( Map<Id, Contact> newRecordsMap, Map<Id, Contact> oldRecordsMap){
    Set<Id> accountIdSet = new Set<Id>();

    for(Contact newRecord : newRecordsMap.values()){
        Contact oldRecord = oldRecordsMap.get(newRecord.Id);

        // Case 1: Account changed
        if(newRecord.AccountId != oldRecord.AccountId){
            if(newRecord.AccountId != null){
                accountIdSet.add(newRecord.AccountId);
            }
            if(oldRecord.AccountId != null){
                accountIdSet.add(oldRecord.AccountId);
            }
        }
        // Case 2: phone changed
        else if(newRecord.Phone != oldRecord.Phone){
            if(newRecord.AccountId != null){
                accountIdSet.add(newRecord.AccountId); 
            }
        }
    }

    List<Account> accountList = [
        SELECT Id, Description 
        FROM Account 
        WHERE Id IN :accountIdSet
    ];

    List<Account> accountListToUpdate = new List<Account>();

    // ❌ WRONG --> Map<Id, Contact> newRecordsMap1 = new Map<Id, Contact>();
    // ✔ RIGHT --> use newRecordsMap directly
    for(Account acc : accountList){
        for(Contact con : newRecordsMap.values()){
            if(con.AccountId == acc.Id){
                acc.Description = 'Contact phone updated with ' + con.Phone;
                accountListToUpdate.add(acc); // <-- ADD THIS!
            }
        }
    }

    if(!accountListToUpdate.isEmpty()){
        update accountListToUpdate;
    }
}

   

}