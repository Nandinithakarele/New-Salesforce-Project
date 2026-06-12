public class AccountTrigger3Handler {
    public static void handleAfterInsert(List<Account> accList){
        List<Location__c> locListToBeInserted = new List<Location__c>();
        for(Account acc : accList){
            if(acc.NumberofLocations__c != null &&  acc.NumberofLocations__c > 0){
            for(Integer i = 1; i <= acc.NumberofLocations__c; i++){
                    Location__c loc = new Location__c();
                    loc.Name__c = acc.Name + '-Location ' + i;
                    loc.Location__c = acc.Id;
                    locListToBeInserted.add(loc);
                }
            
           }
        }
        if(!locListToBeInserted.isEmpty()){
            insert locListToBeInserted;
        }
        
    }
    public static void ifWeChangeOwnerOfTheAccountUpdateTheDesOnAccWithUpdatedOwner(List<Account> accList, Map<Id, Account> oldRecordsMap){
        List<Account> accListToUpdate = new List<Account>();
        for(Account newRecord : accList){
            Account oldRecord = oldRecordsMap.get(newRecord.Id);
            if(oldRecord.OwnerId != newRecord.OwnerId){
               Account accountRecord = new Account();
               accountRecord.Description = accountRecord.Owner.Name;
               accListToUpdate.add(accountRecord);
            }
        }
        if(accListToUpdate.size() > 0){
            update accListToUpdate;
        }
        
    }
    public static void updateAllRelAccConWithDescription(List<Account> newAccList, Map<Id, Account> oldMap){
        Map<Id, Account> accountIdMap = new Map<Id, Account>();
        for(Account acc : newAccList){
            if(oldMap != null && acc.Description != oldMap.get(acc.Id).Description){
            accountIdMap.put(acc.Id, acc);
        }
        }
        
        List<Contact> conListToUpdate = new List<Contact>();
        for(Contact con : [SELECT Id, Description FROM Contact WHERE AccountId IN: accountIdMap.keySet()]){
            if(accountIdMap.containsKey(con.AccountId)){
                con.Description = accountIdMap.get(con.AccountId).Description;
                conListToUpdate.add(con);
            }

            
        }
        if(conListToUpdate.size() > 0){
            update conListToUpdate;
        }
        
    }
    public static void checDuplicateNameAndRatingOfAcc(List<Account> accList){
        Set<String> accNameSet = new Set<String>();
        Set<String> accRatingSet = new Set<String>();
        for(Account acc : accList){
            if(acc.Name != null && acc.Rating != null){
                accNameSet.add(acc.Name);
                accRatingSet.add(acc.Rating);
            }
            
        }
        List<Account> existingAccList = [SELECT Id, Name, Rating FROM Account 
                                        WHERE Name IN: accNameSet
                                        AND Rating IN: accRatingSet];
        Set<String> existingAccNameSet = new Set<String>();
        Set<String> existingAccRatingSet = new Set<String>();
        for(Account acc : existingAccList){
            existingAccNameSet.add(acc.Name);
            existingAccRatingSet.add(acc.Rating);
        }
        for(Account acc : accList){
            if (acc.Name != null && acc.Rating != null) {
            if(existingAccNameSet.contains(acc.Name) &&
              existingAccRatingSet.contains(acc.Rating)){
                  //acc.Name.addError('Account Name Already exists');
                  //acc.Rating.addError('Account Rating Already exists');
                  acc.addError('Duplicate Account: same Name and Rating already exist.');
                
              }else{
                  existingAccNameSet.add(acc.Name);
                  existingAccRatingSet.add(acc.Rating);
              }
        }
        }
        
        
    }/*public static void checDuplicateNameAndRatingOfAcc(List<Account> accList) {

    Set<String> nameSet = new Set<String>();
    Set<String> ratingSet = new Set<String>();

    // Collect incoming Names and Ratings
    for (Account acc : accList) {
        if (acc.Name != null && acc.Rating != null) {
            nameSet.add(acc.Name);
            ratingSet.add(acc.Rating);
        }
    }

    // Query only records matching BOTH fields (same record)
    List<Account> existingAccList = [
        SELECT Id, Name, Rating
        FROM Account
        WHERE Name IN :nameSet
        AND Rating IN :ratingSet
    ];

    // Two sets for checking duplicates inside DB and inside same transaction
    Set<String> existingNameSet = new Set<String>();
    Set<String> existingRatingSet = new Set<String>();

    // Add combined records (only correct matches)
    for (Account acc : existingAccList) {
        existingNameSet.add(acc.Name);
        existingRatingSet.add(acc.Rating);
    }

    // Validate incoming records
    for (Account acc : accList) {

        if (acc.Name != null && acc.Rating != null) {

            // BOTH name & rating must match FROM SAME RECORD
            if (existingNameSet.contains(acc.Name) &&
                existingRatingSet.contains(acc.Rating)) {

                acc.addError('Duplicate Account: same Name and Rating already exist.');
            } else {
                // Add to track duplicates within same transaction
                existingNameSet.add(acc.Name);
                existingRatingSet.add(acc.Rating);
            }
        }
    }
}

*/
/*
 * public static void checDuplicateNameAndRatingOfAcc(List<Account> accList) {

    Set<String> nameSet = new Set<String>();
    Set<String> ratingSet = new Set<String>();

    // Collect incoming Names and Ratings
    for (Account acc : accList) {
        if (acc.Name != null && acc.Rating != null) {
            nameSet.add(acc.Name);
            ratingSet.add(acc.Rating);
        }
    }

    // Query only records matching BOTH fields
    List<Account> existingAccList = [
        SELECT Id, Name, Rating
        FROM Account
        WHERE Name IN :nameSet
        AND Rating IN :ratingSet
    ];

    // FIX: Use pair set
    Set<String> existingPairSet = new Set<String>();

    for (Account acc : existingAccList) {
        existingPairSet.add(acc.Name + '##' + acc.Rating);
    }

    // Validate incoming records
    for (Account acc : accList) {

        if (acc.Name != null && acc.Rating != null) {

            String pair = acc.Name + '##' + acc.Rating;

            if (existingPairSet.contains(pair)) {
                acc.addError('Duplicate Account: same Name and Rating already exist.');
            } else {
                existingPairSet.add(pair);
            }
        }
    }
}

 */
    public static void handlebeforeInsertPhone(List<Account> accList){
        for(Account acc : accList){
            if(acc.Phone == null){
                acc.Phone.addError('Phone number can not be null');
            }
        }
    }
    public static void beforeInsertUpdateBillingToShipping(List<Account> accList){
        for(Account acc : accList){
            
            
        }
    }
    public static void checkDuplicateEmail(List<Account> accList){
        Set<String> emailSet = new Set<String>();
        for(Account acc : accList){
            emailSet.add(acc.Email__c);
        }
        List<Account> existingAccList = [SELECT Id, Email__c FROM Account WHERE Email__c IN: EmailSet LIMIT 5000];
        if(existingAccList.size() > 0){
            for(Account acc : existingAccList){
                acc.addError('Email Already Exists');
            }
        }
        
    }
    
    public static void handleBeforeInsertForMinBalance(List<Account> accList){
        for(Account acc : accList){
            if(acc.Min_Balance__c < 500){
                acc.Min_Balance__c.addError('Balance should be greater than 500');
            }
           
        }
        
    }
    public static void handleBeforeInsertForConcatenetedAccNameWithsfdx(List<Account> accList){
        for(Account acc : accList){
            acc.Name += 'sfdx';
        }
    }
    
    public static void afterUpdate(List<Account> accList, Map<Id, Account> oldMap){
        Set<Id> accIds = new Set<Id>();
        for(Account acc : accList){
            if(oldMap != null && (acc.Phone != oldMap.get(acc.Id).Phone) || (acc.Fax != oldmap.get(acc.Id).Fax)){
                accIds.add(acc.Id);
            }
        }
        List<Contact> conListToUpdate = new List<Contact>();
        for(Account acc : [SELECT Id, Phone, Fax,(SELECT Id, Phone, Fax FROM Contacts) FROM Account WHERE Id IN :accIds]){
            if(acc.Contacts != null){
                for(Contact con : acc.Contacts){
                    con.Phone = acc.Phone;
                    con.Fax = acc.Fax;
                    conListToUpdate.add(con);
                }
            }
        }
        if(!conListToUpdate.isEmpty()){
            update conListToUpdate;
        }
        
    }
    
    public static void updateContactMailingAddress(List<Account> accList, Map<Id, Account> oldAccMap){
 
       
        Map<Id, Account> accountIdMap = new Map<Id, Account>();
        for(Account acc : accList){
            if(oldAccMap != null && 
             (acc.BillingCity != oldAccMap.get(acc.Id).BillingCity ||
              acc.BillingStreet != oldAccMap.get(acc.Id).BillingStreet ||
                acc.BillingState != oldAccMap.get(acc.Id).BillingState ||
                acc.BillingPostalCode != oldAccMap.get(acc.Id).BillingPostalCode ||
                acc.BillingCountry != oldAccMap.get(acc.Id).BillingCountry) ){
                  accountIdMap.put(acc.Id, acc);
              }
        }
        List<Contact> contactListToUpdate = new List<Contact>();
        for(Contact con : [SELECT Id, AccountId FROM Contact WHERE AccountId IN :accountIdMap.keySet()]){
            if(accountIdMap.ContainsKey(con.AccountId)){
                con.MailingCity = accountIdMap.get(con.AccountId).BillingCity;
                con.MailingCountry = accountIdMap.get(con.AccountId).BillingCountry;
                con.MailingStreet = accountIdMap.get(con.AccountId).BillingStreet;
                con.MailingState = accountIdMap.get(con.AccountId).BillingState;
                con.MailingPostalCode = accountIdMap.get(con.AccountId).BillingPostalCode;
                contactListToUpdate.add(con);
            }
        }
        if(!contactListToUpdate.isEmpty()){
            update contactListToUpdate;
        }
    

    }
    public static void updateContactMailingAddressUsingInnerQuery(List<Account> accList, Map<Id, Account> oldAccMap){
        Set<Id> accIds = new Set<Id>();
        for(Account acc : accList){
            if(oldAccMap != null && 
             (acc.BillingCity != oldAccMap.get(acc.Id).BillingCity ||
              acc.BillingStreet != oldAccMap.get(acc.Id).BillingStreet ||
                acc.BillingState != oldAccMap.get(acc.Id).BillingState ||
                acc.BillingPostalCode != oldAccMap.get(acc.Id).BillingPostalCode ||
              acc.BillingCountry != oldAccMap.get(acc.Id).BillingCountry)){
                  accIds.add(acc.Id);
              }
        }
        List<Contact> ContactListtoUpdate = new List<Contact>();
        for(Account acc : [SELECT Id,(SELECT Id FROM Contacts) FROM Account WHERE Id IN :accIds]){
            if(acc.Contacts != null){
                for(Contact con : acc.Contacts){
                    con.MailingCity = acc.BillingCity;
                    con.MailingCountry = acc.BillingCountry;
                    con.MailingState = acc.BillingState;
                    con.MailingStreet = acc.BillingStreet;
                    con.MailingPostalCode = acc.BillingPostalCode;
                    ContactListtoUpdate.add(con);
                }
                if(!ContactListtoUpdate.isEmpty()){
                    update ContactListtoUpdate;
                }
            }
        }
    }
    /*
    //As soon as the Account Description is updated updated the associated description field
    public static void updateAllRelAccConWithDescription1(List<Account> accList){
        Set<Id> accountIdSet = new Set<Id>();
        for(Account acc : accList){
            accountIdSet.add(acc.Id);
        }
        List<Contact> conList = [SELECT Id, Description FROM Contact WHERE AccountId IN: accountIdSet];
        List<Contact> conListToUpdate = new List<Contact>();
        for(Contact con : conList){
            con.Description = 'Account Related Contact has updated';
            conListToUpdate.add(con);
        }
        if(conListToUpdate.size() > 0){
            update conListToUpdate;
        }
    }
    //public static void updateAllRelAccConWithDescription1(
    Map<Id, Account> newMap, 
    Map<Id, Account> oldMap
){
    Set<Id> changedAccIds = new Set<Id>();

    // Step 1: Identify only Accounts where description changed
    for (Account acc : newMap.values()) {
        Account oldAcc = oldMap.get(acc.Id);

        if (acc.Description != oldAcc.Description) {
            changedAccIds.add(acc.Id);
        }
    }

    if (changedAccIds.isEmpty()) {
        return;
    }

    // Step 2: Query updated Accounts with Description
    Map<Id, Account> accMap = new Map<Id, Account>(
        [SELECT Id, Description FROM Account WHERE Id IN :changedAccIds]
    );

    // Step 3: Query related Contacts
    List<Contact> conList = [
        SELECT Id, AccountId, Description
        FROM Contact
        WHERE AccountId IN :changedAccIds
    ];

    List<Contact> conListToUpdate = new List<Contact>();

    // Step 4: Set Contact.Description = Account.Description
    for (Contact con : conList) {
        Account parentAcc = accMap.get(con.AccountId);

        con.Description = parentAcc.Description;   // ★ KEY LINE ★
        conListToUpdate.add(con);
    }

    if (!conListToUpdate.isEmpty()) {
        update conListToUpdate;
    }
}*/
/*
 * //As soon as the Account Description is updated updated the associated description field
 * public static void updateAllRelAccConWithDescription1(
    List<Account> accList, 
    Map<Id, Account> oldMap
){
    Set<Id> accountIdSet = new Set<Id>();

    // Collect only those account Ids where Description is changed
    for (Account acc : accList) {

        Account oldAcc = oldMap.get(acc.Id);

        if (acc.Description != oldAcc.Description) {
            accountIdSet.add(acc.Id);
        }
    }

    if (accountIdSet.isEmpty()) {
        return; // No need to query or DML
    }

    // Query related contacts
    List<Contact> conList = [
        SELECT Id, Description 
        FROM Contact 
        WHERE AccountId IN :accountIdSet
    ];

    List<Contact> conListToUpdate = new List<Contact>();

    for (Contact con : conList) {
        con.Description = 'Account Related Contact has updated';
        conListToUpdate.add(con);
    }

    // Update contacts
    if (!conListToUpdate.isEmpty()) {
        update conListToUpdate;
    }
}
*/
/*
 *
 * As soon as the Account Description is updated updated the associated description field  
    public static void updateAllRelAccConWithDescription(List<Account> newAccList, Map<Id, Account> oldMap){
        Map<Id, Account> accountIdMap = new Map<Id, Account>();
        for(Account acc : newAccList){
            if(oldMap != null && acc.Description != oldMap.get(acc.Id).Description){
            accountIdMap.put(acc.Id, acc);
        }
        }
        
        List<Contact> conListToUpdate = new List<Contact>();
        for(Contact con : [SELECT Id, Description FROM Contact WHERE AccountId IN: accountIdMap.keySet()]){
            if(accountIdMap.containsKey(con.AccountId)){
                con.Description = accountIdMap.get(con.AccountId).Description;
                conListToUpdate.add(con);
            }

            
        }
        if(conListToUpdate.size() > 0){
            update conListToUpdate;
        }
        
    }    
    */
    
}