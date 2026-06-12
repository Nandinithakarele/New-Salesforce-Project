public class ContactTrigger3Handler {
    public static void beforeInsertCheckDuplicateEmailInConWithAssociateAcc(List<Contact> newContacts){
        Set<Id> accountIds = new Set<Id>();
        Set<String> emails = new Set<String>();

        // Step 1: Collect AccountIds and Emails
        for (Contact con : newContacts) {
            if (con.AccountId != null && con.Email != null) {
                accountIds.add(con.AccountId);
                emails.add(con.Email.toLowerCase());
            }
        }

        if (accountIds.isEmpty()) return;

        // Step 2: Query existing Contacts
        Map<Id, Set<String>> accountEmailMap = new Map<Id, Set<String>>();

        for (Contact existingCon : [
            SELECT AccountId, Email
            FROM Contact
            WHERE AccountId IN :accountIds
            AND Email IN :emails
        ]) {
            if (!accountEmailMap.containsKey(existingCon.AccountId)) {
                accountEmailMap.put(existingCon.AccountId, new Set<String>());
            }
            accountEmailMap.get(existingCon.AccountId)
                           .add(existingCon.Email.toLowerCase());
        }

        // Step 3: Validate duplicates
        for (Contact con : newContacts) {
            if (con.AccountId != null && con.Email != null) {

                if (accountEmailMap.containsKey(con.AccountId) &&
                    accountEmailMap.get(con.AccountId)
                                   .contains(con.Email.toLowerCase())) {

                    con.Email.addError(
                        'Duplicate Email already exists for this Account.'
                    );
                }
            }
        }
    }
    

    /*
     Interview Question 
     When Contact is inserted/6created email should be unique in lead and contact.
   */

    public static void beforeInsert(List<Contact> newList){
        Set<String> conEmailSet = new Set<String>();
        //Set<String> leadEmailSet = new Set<String>();
        for(Contact con : newList){
            if(con.Email != null){
                conEmailSet.add(con.Email);
            }
        }
        List<Contact> existingConList = [SELECT Id, Email FROM Contact WHERE Email IN: conEmailSet];
        Set<String> existingEmailSet = new Set<String>();
        for(Contact con : existingConList){
            existingEmailSet.add(con.Email);
        }
        List<Lead> existingLeadList = [SELECT Id, EMail FROM Lead WHERE Email IN: conEmailSet];
        for(Lead ld : existingLeadList){
            existingEmailSet.add(ld.Email);
        }
        for(Contact con : newList){
            if(con.Email != null){
                if(existingEmailSet.contains(con.Email)){
                    con.Email.addError('Email Already exists in Contact ##');
                }else{
                    existingEmailSet.add(con.Email);
                }
                
            }
        }
    }
    public static void afterInsert(Map<Id, Contact> newRecordsMap){
        Set<Id> accountIdSet = new Set<Id>();
        for(Contact con : newRecordsMap.values()){
            if(con.AccountId != null){
                accountIdSet.add(con.AccountId);
            }
            
        }
        List<AggregateResult> aggList = [SELECT AccountId, Count(Id) CountOfContact FROM Contact WHERE AccountId IN: accountIdSet 
                                        GROUP BY AccountId];
        List<Account> accListToUpdate = new List<Account>();
        for(AggregateResult ag : aggList){
            Id accountId = (Id)ag.get('AccountId');
            Integer totalContact = (Integer)ag.get('CountOfContact');
            Account accountRecord = new Account();
            accountRecord.Id = accountId;
            accountRecord.Number_of_Contacts_associate_to_account__c = totalContact;
            accListToUpdate.add(accountRecord);
            
        }
        if(accListToUpdate.size() > 0){
            update accListToUpdate;
        }
        
    }
    public static void afterUpdate(Map<Id, Contact> newRecordsMap, Map<Id, Contact> oldRecordsMap){
        Set<Id> accountIdSet = new Set<Id>();
        for(Contact newRecord : newRecordsMap.values()){
            Contact oldRecord = oldRecordsMap.get(newRecord.Id);
            if(oldRecord.AccountId != newRecord.AccountId){
                if(newRecord.AccountId != null){
                   accountIdSet.add(newRecord.AccountId);
                }
                if(oldRecord.AccountId != null){
                    accountIdSet.add(oldRecord.AccountId);
                }
                
            } else if (oldRecord.Phone != newRecord.Phone){
                if(newRecord.AccountId != null){
                       accountIdSet.add(newRecord.AccountId);
                }
            }
        } 
        List<AggregateResult> aggList = [SELECT AccountId, Count(Id) CountOfContact FROM Contact WHERE AccountId IN: accountIdSet 
                                        GROUP BY AccountId];
        List<Account> accListToUpdate = new List<Account>();
        for(AggregateResult ag : aggList){
            Id accountId = (Id)ag.get('AccountId');
            Integer totalContact = (Integer)ag.get('CountOfContact');
            Account accountRecord = new Account();
            accountRecord.Id = accountId;
            accountRecord.Number_of_Contacts_associate_to_account__c = totalContact;
            accListToUpdate.add(accountRecord);
            
        }
        if(accListToUpdate.size() > 0){
            update accListToUpdate;
        }
        
        
    }

}