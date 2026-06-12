public class ContactTrigger1Handler {
    
    public static void method1(List<Contact> newList, Map<Id, Contact> oldMap){
        for(Contact con : newList){
            if(oldMap != null && con.Phone != oldMap.get(con.Id).Phone){
                con.Fax = con.Phone;
            }
            
        }
        
    }
    public static void ifAccDeletedRelContactDelete(Map<Id, Contact> oldRecordsMap){
        List<Contact> contactList = [SELECT Id FROM Contact WHERE AccountId IN: oldRecordsMap.keySet()];
        List<Contact> contactListToBeDeleted = new List<Contact>();
        for(Contact con : contactList){
            contactListToBeDeleted.add(con);
        }
        if(contactListToBeDeleted.size() > 0){
            delete contactListToBeDeleted;
        }
    }
    public static void beforeUpdateCalculateAgeField(List<Contact> conList, Map<Id, Contact> oldMap){
        for(Contact con : conList){
            if(oldMap != null && con.Birthdate != oldMap.get(con.Id).BirthDate){
                Integer birth = con.Birthdate.year();
                Date todayDate = Date.Today();
                Integer current = todayDate.year();
                Integer age = current - birth;
                con.Age__c = age;
            }

        }
    }
    public static void afterInsert(List<Contact> conList){
        List<Account> accList = new List<Account>();
        for(Contact con : conList){
            if(con.AccountId == null){
            Account acc = new Account();
                acc.Name = con.LastName;
                acc.Phone = con.Phone;
                accList.add(acc);
            }
        }
        if(!accList.isEmpty()){
            insert accList;
        }
    }
    
    public static void beforeInsertAndUpdate(List<Contact> conList, Map<Id, Contact> oldMap){
        for(Contact con : conList){
            if(con.Email == null){
                con.addError('email can not be null');
            }
            if(con.Phone == null){
                con.addError('Phone can not be null');
            }
        }
        
    }
    public static void preventUpdatingEmailField(List<Contact> conList, Map<Id, Contact> oldMap){
        for(Contact con : conList){
            if(oldMap != null && con.Email != oldMap.get(con.Id).Email){
                con.Email.addError('Email can not change');
            }
        }

        
    }
    /*There are two fields, one is description on account object and one is phone on contact object. Whenever the contact phone number changes, 
     * update the parent account field, description, contact field updated. use newmap oldmap*/
    public static void afterUpdateIfContactPhoneChangesUpdateAccDescription(Map<Id, Contact> newrecordsMap, Map<Id, Contact> oldRecordsMap){
        Set<Id> accountIdSet = new Set<Id>();
        for(Contact newRecord : newrecordsMap.values()){
            Contact oldRecord = oldRecordsMap.get(newRecord.Id);
            if(oldRecord.Phone != newRecord.Phone){
                if(newRecord.AccountId != null){
                    accountIdSet.add(newRecord.AccountId);
                }
            }
        }
        List<Account> accountListToUpdate = new List<Account>();
        for(Id accountId : accountIdSet){
            Account acc = new Account();
            acc.Id = accountId;
            acc.Description = 'Contact Phone Updated';
            accountListToUpdate.add(acc);
        }
        if(accountListToUpdate.size() > 0){
            update accountListToUpdate;
        }
        
    }
    /*
    public static void afterUpdateIfContactPhoneChangesUpdateAccDescription(
    Map<Id, Contact> newrecordsMap, 
    Map<Id, Contact> oldRecordsMap
){
    Set<Id> accountIdSet = new Set<Id>();

    // collect AccountIds where PHONE changed
    for (Contact newRecord : newrecordsMap.values()) {
        Contact oldRecord = oldRecordsMap.get(newRecord.Id);

        if (newRecord.AccountId != null &&
            newRecord.Phone != oldRecord.Phone)
        {
            accountIdSet.add(newRecord.AccountId);
        }
    }

    if (accountIdSet.isEmpty()) {
        return;
    }

    List<Account> accList = new List<Account>();
    for (Id accId : accountIdSet) {
        accList.add(new Account(
            Id = accId,
            Description = 'Contact Phone Updated'
        ));
    }

    update accList;
}

   */
    
    //using trigger.new and trigger.oldMap
    public static void afterUpdateIfContactPhoneChangesUpdateAccDescription1(List<Contact> conList , Map<Id, Contact> oldRecordsMap){
        Set<Id> accountIdSet = new Set<Id>();
        for(Contact newRecord : conList){
            Contact oldRecord = oldRecordsMap.get(newRecord.Id);
            if(oldRecord.Phone != newRecord.Phone){
                if(newRecord.AccountId != null){
                    accountIdSet.add(newRecord.AccountId);
                }
            }
        }
        List<Account> accountListToUpdate = new List<Account>();
        for(Account acc : [SELECT Id, Description FROM Account WHERE Id IN: accountIdSet]){
                acc.Description = 'Contact Phone Updated';
                accountListToUpdate.add(acc);
            
        }
        if(accountListToUpdate.size() > 0){
            update accountListToUpdate;
        }
    }
    //As sson as related contact description is updated update the associated Account description
    public static void AsRelConDescriptionUpdatedUpdateRelAccDescription(List<Contact> conList, Map<Id,Contact> oldRecordsMap){
        Set<Id> accountIdSet = new Set<Id>();
        for(Contact newRecord : conList){
            Contact oldRecord = oldRecordsMap.get(newRecord.Id);
            if(oldRecord.Description != newRecord.Description){
                if(newRecord.AccountId != null){
                    accountIdSet.add(newRecord.AccountId);
                }
            }
        }
        if (accountIdSet.isEmpty()) {
        return;
        }

        
        List<Account> accList = [SELECT Id, Description FROM Account WHERE Id IN: accountIdSet];
        List<Account> accListToUpdate = new List<Account>();
        for(Account acc : accList){
            acc.Description = 'Related contact description has Updated';
            accListToUpdate.add(acc);
        }
        if(accListToUpdate.size() > 0){
            update accListToUpdate;
        }
        /*
        List<Account> accListToUpdate = new List<Account>();
        for(Contact con : conList){
            if(con.AccountId != null && accountIdset.contains(con.AccountId)){
                Account acc = new Account();
                acc.Id = con.AccountId;
                acc.Descrption = con.Description;
                accListToUpdate.add(acc);
            }
        }
        if(accListToUpdate.size() > 0){
            update accListToUpdate;
        }*/

        
        
    }
/*
 * public static void AsRelConDescriptionUpdatedUpdateRelAccDescription(
    List<Contact> conList, 
    Map<Id,Contact> oldRecordsMap
){
    Set<Id> accountIdSet = new Set<Id>();

    // Step 1: find Contact records where Description changed
    Map<Id, String> accIdToConDescription = new Map<Id, String>();

    for (Contact newRecord : conList) {
        Contact oldRecord = oldRecordsMap.get(newRecord.Id);

        if (newRecord.Description != oldRecord.Description &&
            newRecord.AccountId != null)
        {
            accountIdSet.add(newRecord.AccountId);

            // store the NEW contact description for updating account later
            accIdToConDescription.put(newRecord.AccountId, newRecord.Description);
        }
    }

    if (accountIdSet.isEmpty()) {
        return;
    }

    // Step 2: Query the Accounts to update
    List<Account> accList = [
        SELECT Id, Description
        FROM Account
        WHERE Id IN :accountIdSet
    ];

    List<Account> accListToUpdate = new List<Account>();

    // Step 3: Update Account.Description = Contact.Description
    for (Account acc : accList) {

        // get the new description from related contact
        acc.Description = accIdToConDescription.get(acc.Id);

        accListToUpdate.add(acc);
    }

    if (!accListToUpdate.isEmpty()) {
        update accListToUpdate;
    }
}*/
     
        
}