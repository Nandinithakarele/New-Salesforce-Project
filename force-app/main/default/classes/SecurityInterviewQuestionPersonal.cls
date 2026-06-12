public class SecurityInterviewQuestionPersonal {

    /*
1. Opportunity → Account (MOST COMMON)
1️⃣ Closed Won – Account Inactive

When Opportunity Stage is Closed Won, prevent save if the related Account is Inactive.

2️⃣ Closed Lost – Account On Hold

Prevent Opportunity from being marked Closed Lost if Account Status = On Hold.

3️⃣ Opportunity Amount Validation

When Opportunity Amount > 1,000,000, Account Type must be Customer.

4️⃣ Opportunity Close Date

Do not allow Closed Won if Close Date is in the future and Account Tier = Gold.
   */
    /*𝐖𝐡𝐞𝐧 𝐭𝐡𝐞 𝐒𝐭𝐚𝐠𝐞𝐍𝐚𝐦𝐞 𝐨𝐧 𝐎𝐩𝐩𝐨𝐫𝐭𝐮𝐧𝐢𝐭𝐲 '𝐂𝐥𝐨𝐬𝐞𝐝 𝐖𝐨𝐧’ 𝐭𝐡𝐞𝐧 𝐜𝐡𝐞𝐜𝐤 𝐢𝐟 𝐀𝐜𝐜𝐨𝐮𝐧𝐭'𝐬 𝐀𝐜𝐭𝐢𝐯𝐞 = '𝐍𝐨' 𝐚𝐧𝐝 𝐎𝐰𝐧𝐞𝐫𝐬𝐡𝐢𝐩 = '𝐏𝐫𝐢𝐯𝐚𝐭𝐞'.
     *  𝐚𝐛𝐨𝐯𝐞 𝐜𝐨𝐧𝐝𝐢𝐭𝐢𝐨𝐧𝐬 𝐚𝐫𝐞 𝐭𝐫𝐮𝐞 𝐭𝐡𝐞𝐧 𝐭𝐡𝐫𝐨𝐰 𝐚𝐧 𝐞𝐫𝐫𝐨𝐫 𝐰𝐢𝐭𝐡 𝐦𝐞𝐬𝐬𝐚𝐠𝐞 -> 
     * "𝐎𝐩𝐩𝐨𝐫𝐭𝐮𝐧𝐢𝐭𝐲 𝐜𝐚𝐧𝐧𝐨𝐭 𝐛𝐞 𝐮𝐩𝐝𝐚𝐭𝐞𝐝 𝐭𝐨 𝐂𝐥𝐨𝐬𝐞𝐝 𝐖𝐨𝐧 𝐟𝐨𝐫 𝐈𝐧𝐚𝐜𝐭𝐢𝐯𝐞 𝐀𝐜𝐜𝐨𝐮𝐧𝐭" 𝐟𝐨𝐫 𝐛𝐨𝐭𝐡 𝐢𝐧𝐬𝐞𝐫𝐭𝐢𝐨𝐧 𝐚𝐧𝐝 𝐮𝐩𝐝𝐚𝐭𝐢𝐨𝐧
     * 
    //When Opportunity Stage is Closed Won, prevent save if the related Account is Inactive.
    Trigger OpportunityTrigger on Opportunity(after insert, after update){
        if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
            OpportunityTriggerHandler.handleAfterUpdate(Trigger.New, Trigger.oldMap);
        }
    }
    public class OpportunityTriggerHandler{
        public static void handleAfterUpdate(List<Opportunity> oppList, Map<Id, Opportunity> oldMap){
        Set<Id> accountIdSet = new Set<Id>();
        for(Opportunity opp : oppList){
            if(opp.AccountId != null && opp.StageName == 'Closed Won' && (oldMap == null || opp.StageName != oldMap.get(opp.Id).StageName)){
                accountIdSet.add(opp.AccountId);
            }
        }
        Map<Id, Account> accountIdMap = new Map<Id, Account>(SELECT Id, Active__c, OwnerShip FROM Account WHERE Id IN: accountIdSet);
        for(Opportunity opp : oppList){
            if(opp.AccountId != null && opp.StageName == 'Closed Won' && accountIdMap.containsKey(opp.AccountId)){
                Account acc = accountIdMap.get(opp.AccountId);
                if(acc.Ownership == 'Private' && acc.Active__c = 'No'){
                  opp.StageName.addError('Opportunity can not be Updated to Closed Won for Inactive accounts.');  
                }
                
            }
            
        }
     }
    }*/
    
    /*
    //Prevent Opportunity from being marked Closed Lost if Account Status = On Hold.
    Trigger OpportunityTrigger on Opportunity(after insert, after update){
        if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
            OpportunityTriggerHandler.handleAfterUpdate(Trigger.New, Trigger.oldMap);
        }
    }
    public class OpportunityTriggerHandler{
        public static void handleAfterUpdate(List<Opportunity> oppList, Map<Id, Opportunity> oldMap){
        Set<Id> accountIdSet = new Set<Id>();
        for(Opportunity opp : oppList){
            if(opp.AccountId != null && opp.StageName == 'Closed Lost' && oldMap == null || opp.StageName != oldMap.get(opp.Id).StageName){
                accountIdSet.add(opp.AccountId);
            }
        }
        Map<Id, Account> accountIdMap = new Map<Id, Account>(SELECT Id, Status__c FROM Account WHERE Id IN: accountIdSet);
        for(opportunity opp : oppList){
            if(opp.AccountId != null && opp.StageName == 'Closed Lost' && accountIdMap.containsKey(con.AccountId)){
                Account acc = accountIdMap.get(opp.AccountId);
                if(acc.Status__c == 'On Hold'){
                    opp.StageName.addError('Opportunity can not be updated to closed Lost for on hold Accounts');
                }
            }
        }
    }
}
*/
    /*
     * 3️⃣ Opportunity Amount Validation

     When Opportunity Amount > 1,000,000, Account Type must be Customer.
   Key Concept (Interview Explanation)

oldMap == null → Insert

oldMap != null → Update

On update, compare old vs new values

Works in before insert, before update*/
    /*
    
    Trigger OpportunityTrigger on Opportunity(before insert, before update){
        
            OpportunityTriggerHandler.handleBeforeUpdate(Trigger.New, Trigger.oldMap);
        
    }
    public class OpportunityTriggerHandler{
        public static void handleBeforeUpdate(List<Opportunity> oppList, Map<Id, Opportunity> oldMap){
        Set<Id> accountIdSet = new Set<Id>();
        for(Opportunity opp : oppList){
            if(opp.AccountId != null && opp.Amount != null && opp.Amount > 1000000 && (oldMap == null || opp.Amount != oldMap.get(opp.Id).Amount)){
                accountIdSet.add(opp.AccountId);
            }
        }
        Map<Id, Account> accountIdMap = new Map<Id, Account>(SELECT Id, Type FROM Account WHERE Id IN: accountIdSet);
        
        for(Opportunity opp : oppList){
            if(opp.AccountId != null && opp.Amount != null && opp.Amount > 1000000 && accountIdMap.containsKey(opp.AccountId)){
                Account acc = accountIdMap.get(opp.AccountId);
                if(acc.Type != 'Customer'){
                    opp.addError('if opportunity amount exceeds 1000000 then account type must be customer');
                }
                
            }
         }
           
        
        }
    }
    */
    /*
    //Opportunity Close Date

//Do not allow Closed Won if Close Date is in the future and Account Tier = Gold.
    Trigger OpportunityTrigger on Opportunity (before Update){
        OpportunityTriggerHandler.beforeUpdate(Trigger.New, Trigger.oldMap);
    }
    
    public class OpportunityTriggerHandler{
        public static void beforeUpdate(List<Opportunity> oppList , Map<Id, Opportunity> oldMap){
            Set<Id> accountIdSet = new Set<Id>();
            for(Opportunity opp : oppList){
                if(opp.AccountId != null && opp.StageName != null && opp.StageName == 'Closed Won'&& 
                   oldMap.get(opp.Id).StageName == 'Closed Won'
                    && opp.CloseDate > Date.today()){
                   accountIdSet.add(opp.AccountId);
                }
            }
            Map<Id, Account> accountIdMap = new Map<Id, Account>(SELECT Id, Tire__c FROM Account WHERE Id IN: accountIdSet);
            for(Opportunity opp : oppList){
                if(opp.AccountId != null && opp.StageName != null && opp.StageName == 'Closed Won'&& 
                   
                     opp.CloseDate > Date.today() && accountIdMap.containsKey(opp.AccountId)){
                        Account acc = accountIdMap.get(opp.AccountId);
                        if(acc.Tire__c == 'Gold'){
                            opp.addError('Opportunity can not be closed Won for Tire gold Account');
                        }
                    }
            }
        }
    }
    
    
    
    
    
    
    
    
}  
*/
    

/*
//When Account is activated, at least one Contact must exist.
trigger AccountTrigger on Account (before update) {
    AccountTriggerHandler.validateActivation(
        Trigger.new,
        Trigger.oldMap
    );
}

public class AccountTriggerHandler {

    public static void validateActivation(List<Account> newList,
                                          Map<Id, Account> oldMap) {

        Set<Id> accountIdSet = new Set<Id>();

        // Step 1: Identify accounts getting activated
        for (Account acc : newList) {
            Account oldAcc = oldMap.get(acc.Id);

            if (acc.Is_Activated__c == true &&
                oldAcc.Is_Activated__c == false) {

                accountIdSet.add(acc.Id);
            }
        }

        if (accountIdSet.isEmpty()) {
            return;
        }

        // Step 2: Get contact count per account
        Map<Id, Integer> accToContactCountMap = new Map<Id, Integer>();

        for (AggregateResult ar : [
            SELECT AccountId accId, COUNT(Id) cnt
            FROM Contact
            WHERE AccountId IN :accountIdSet
            GROUP BY AccountId
        ]) {
            accToContactCountMap.put(
                (Id) ar.get('accId'),
                (Integer) ar.get('cnt')
            );
        }

        // Step 3: Validation (NO ternary)
        for (Account acc : newList) {
            if (accountIdSet.contains(acc.Id)) {

                Integer contactCount = 0;

                if (accToContactCountMap.containsKey(acc.Id)) {
                    contactCount = accToContactCountMap.get(acc.Id);
                }

                if (contactCount == 0) {
                    acc.addError(
                        'Account must have at least one Contact before activation.'
                    );
                }
            }
        }
    }
}
*/
    /*
     * 📌 Requirement

When an Opportunity is created, ensure the related Account has at least one Primary Contact.

Assumption:

Is_Primary__c (Checkbox) on Contact

✅ Trigger (Before Insert)
trigger OpportunityTrigger on Opportunity (before insert) {
    OpportunityTriggerHandler.validatePrimaryContact(
        Trigger.new
    );
}

✅ Handler Class (Using MAP + Aggregate Query)
public class OpportunityTriggerHandler {

    public static void validatePrimaryContact(List<Opportunity> oppList) {

        Set<Id> accountIdSet = new Set<Id>();

        // Step 1: Collect Account Ids
        for (Opportunity opp : oppList) {
            if (opp.AccountId != null) {
                accountIdSet.add(opp.AccountId);
            }
        }

        if (accountIdSet.isEmpty()) {
            return;
        }

        // Step 2: Aggregate query to get Accounts with Primary Contacts
        Map<Id, Integer> accIdVsPrimaryContactMap = new Map<Id, Integer>();

        for (AggregateResult ar : [
            SELECT AccountId accId, COUNT(Id) cnt
            FROM Contact
            WHERE AccountId IN :accountIdSet
            AND Is_Primary__c = true
            GROUP BY AccountId
        ]) {
            accIdVsPrimaryContactMap.put(
                (Id) ar.get('accId'),
                (Integer) ar.get('cnt')
            );
        }

        // Step 3: Validate Opportunities using MAP
        for (Opportunity opp : oppList) {
            if (opp.AccountId != null &&
                !accIdVsPrimaryContactMap.containsKey(opp.AccountId)) {

                opp.addError(
                    'Account must have a Primary Contact before creating an Opportunity.'
                );
            }
        }
    }
}

🧠 Interview One-Line Explanation

“I used an aggregate SOQL query to build a map of AccountId to primary-contact count and validated Opportunity
creation using map lookup to ensure at least one Primary Contact exists.”
*/
    /*
//Prevent Opportunity creation if all Contacts are inactive.
trigger OpportunityTrigger on Opportunity (before insert) {
    OpportunityTriggerHandler.validateActiveContacts(Trigger.new);
}
public class OpportunityTriggerHandler {

    public static void validateActiveContacts(List<Opportunity> oppList) {

        Set<Id> accountIdSet = new Set<Id>();

        // Step 1: Collect Account Ids from Opportunities
        for (Opportunity opp : oppList) {
            if (opp.AccountId != null) {
                accountIdSet.add(opp.AccountId);
            }
        }

        if (accountIdSet.isEmpty()) {
            return;
        }

        // Step 2: Aggregate query to find Accounts with ACTIVE Contacts
        Map<Id, Integer> accIdVsActiveContactMap = new Map<Id, Integer>();

        for (AggregateResult ar : [
            SELECT AccountId accId, COUNT(Id) cnt
            FROM Contact
            WHERE AccountId IN :accountIdSet
            AND Is_Active__c = true
            GROUP BY AccountId
        ]) {
            accIdVsActiveContactMap.put(
                (Id) ar.get('accId'),
                (Integer) ar.get('cnt')
            );
        }

        // Step 3: Validate Opportunities
        for (Opportunity opp : oppList) {
            if (opp.AccountId != null &&
               !accIdVsActiveContactMap.containsKey(opp.AccountId)) {

                opp.addError(
                    'Opportunity cannot be created because all Contacts on the Account are inactive.'
                );
            }
        }
    }
}
*/
    /*
    //Wen account Industry changes Update all related opportunity
    Trigger AccountTrigger on Account(after insert, after update){
        if(Trigger.isAfter && Trigger.isUpdate){
            
            AccountTriggerHandler.afterUpdate(Trigger.New, Trigger.oldMap);
        }
    }
    public class AccountTriggerHandler{
        public static void (List<Account> accList, Map<Id, Account> oldMap){
            Map<Id, Account> accountIdMap = new Map<Id, Account>();
            for(Account acc : accList){
                if(oldMap != null && (oldMap == null || acc.Industry != oldMap.get(acc.Id).Industry)){
                    accountIdMap.put(acc.Id, acc);
                }
            }
            List<Opportunity> oppListToUpdate = new List<Opportunity>();
            for(Opportunity opp : [SELECT AccountId, Industry__c FROM Opportunity WHERE AccountId IN: accountIdMap.KeySet()]){
                if(accountIdMap.containsKey(opp.AccountId)){
                    opp.Industry__c = accountIdMap.get(opp.AccountId).Industry;
                    oppListToUpdate.add(opp);
                }
            }
            if(oppListToUpdate.size() > 0){
                update oppListToUpdate;
            }
        }
    }
*/
    /*
    //“Write a bulk-safe after-update trigger on Opportunity that, when an Opportunity is marked Closed Lost,
    // automatically marks all related Opportunities older 
    //than 30 days under the same Account as Closed Lost, excluding Closed Won records.”
    Trigger OpportunityTrigger on Opportunity (after update){
        if(Trigger.isAfter && Trigger.isUpdate){
            OpportunityTriggerHandler.afterUpdate(Trigger.New, Trigger.oldMap);
        }
    }
    public class OpportunityTriggerHandler{
        public static void afterUpdate(List<Opportunity> accList, Map<Id, Opportunity> oldMap){
            Set<Id> accountIdSet = new Set<Id>();
            for(Opportunity opp : oppList){
                if(opp.AccountId != null && oldMap != null 
                  && opp.StageName != oldMap.get(opp.Id).StageName && opp.StageName == 'Close Lost'
                   && opp.StageName != 'Close won'){
                      accountIdSet.add(opp.AccountId);
                   }
            }
            Map<Id, Account> accountIdMap = new Map<Id, Account>(SELECT Id, Name FROM Account WHERE Id IN: accountIdSet);
            List<Opportunity> oppListToUpdate = new List<Opportunity>();
            for(Opportunity opp : oppList){
                if(accountIdMap.containsKey(opp.AccountId)){
                    if(opp.Createdate > 30 && opp.StageName != 'Close Won'){
                        opp.StageName = 'Close Lost';
                        oppListToUpdate.add(opp);
                    }
                }
            }
            if(oppListToUpdate.size() > 0){
                update oppListToUpdate;
            }
            
        }
    }
*/
    //INTERVIEW QUESTION STARTED
    /****************************/
    
    /*
*********
*  4    *
*       *
*********
    4)Update Parent by child
    If the contact description is updated, then its parent account description should also get updated by it.
        Trigger ContactTrigger on Contact (after update){
            ContactTriggerHandler.afterUpdate(Trigger.New, Trigger.oldMap);
        }
    
    public class ContactTriggerHandler{
        public static void afterUpdate(List<Contact> conList, Map<Id, Contact> oldMap){
            Set<Id> accountIdSet = new Set<Id>();
            for(Contact con : conList){
                if(con.AccountId != null && con.Description != oldMap.get(con.Id).Description){
                   accountIdSet.add(con.AccountId); 
                }
                
            }
            if (!accountIdSet.isEmpty()){
            List<Account> accListToUpdate = new List<Account>();
            Map<Id, Account> accMap = new Map<Id, Account>(SELECT Id, Description FROM Account WHERE Id IN: accountIdSet);
            for(Contact con : conList){
                if(con.AccountId != null && accMap.containsKey(con.AccountId)){
                    Account acc = accMap.get(con.AccoountId);
                    acc.Description = con.Description;
                    accListToUpdate.add(acc);
                }
            }
            if(accListToUpdate.size() > 0){
                update accListToUpdate;
            }
        }
    }
  }
*/
    /*
*********
*  9    *
*       *
*********
Write a trigger on account when the account is updated. Check all opportunities related to the account.
Update all opportunities staged to close last if an opportunity 
created date is greater than 30 days from today and stage not equals to close one.
    Trigger AccountTrigger on Account(after update){
        AccountTriggerHandler.afterUpdate(Trigger.New, Trigger.oldMap);
    }
    public class AccountTriggerHandler{
        public static void afterUpdate(List<Account> accList, Map<Id, Account> oldMap){
            Set<Id> accIdSet = new Set<Id>();
            for(Account acc : accList){
                accIdSet.add(acc.Id);
            }
            if(!accIdSet.isEmpty()){
            List<Opportunity> oppList = [SELECT Id, AccountId, StageName, CreatedDate FROM Opportunity WHERE AccountId IN: accIdSet];
            List<Opportunity>oppListToUpdate = new List<Opportunity>();
            for(Opportunity opp : oppList){
                if(opp.AccountId != null && opp.StageName != 'Closed Won' && opp.CreatedDate < Date.Today().addDays(-30)){
                    opp.StageName = 'Closed Lost';
                    oppListToUpdate.add(opp);
                }
            }
            if(!oppListToUpdateisEmpty()){
                update oppListToUpdate;
            }
        }
    }
  }
*/
    /*
*********
* 12    *
*       *
*********
    When a case is inserted on any account, 
    put the latest case number on the account 
    in the LatestCaseInserted field.
    Trigger CaseTrigger on Case (after insert){
        CaseTriggerHandler.afterInsert(Trigger.New);
    }
    public class CaseTriggerHandler{
        public static void afterInsert(List<Case> caseList){
            Set<Id> accIdSet = new Set<Id>();
            for(Case caseObj : caseList){
                if(caseObj.AccountId != null){
                    accIdSet.add(caseObj.AccountId);
                }
            }
            Map<Id,Account> mapToUpdate = new Map<Id, Account>();
            Map<Id, Account> accMap = new Map<Id, Account>(SELECT Id, Latest_Case_Inserted__c FROM Account WHERE Id IN: accIdSet);
            for(Case caseRcd : caseList){
                if(caseRcd.AccountId != null && accMap.containsKey(caseRcd.AccountId)){
                    Account acc = accMap.get(caseRcd.AccountId);
                    if(acc.Latest_Case_Inserted__c != caseRcd.CaseNumber){
                        acc.Latest_Case_Inserted__c = caseRcd.CaseNumber;
                        mapToUpdate.put(acc.Id, acc);
                    }
                }
            }
            if(!mapToUpdate.isEmpty){
                update mapToUpdate.values();
            }
        }
    }
*/
    /*
*********
* 16    *
*       *
*********
    trigger OpportunityTrigger on Opportunity (after update) {
    OpportunityTriggerHandler.afterUpdate(Trigger.newMap, Trigger.oldMap);
}

public class OpportunityTriggerHandler {

    public static void afterUpdate(
        Map<Id, Opportunity> newRecordsMap,
        Map<Id, Opportunity> oldRecordsMap
    ) {

        Set<Id> accIdSet = new Set<Id>();

        for (Opportunity newRecord : newRecordsMap.values()) {
            Opportunity oldRecord = oldRecordsMap.get(newRecord.Id);

            // If Account is changed OR Amount is changed
            if (
                newRecord.AccountId != oldRecord.AccountId ||
                newRecord.Amount != oldRecord.Amount
            ) {
                if (newRecord.AccountId != null) {
                    accIdSet.add(newRecord.AccountId);
                }
                if (oldRecord.AccountId != null) {
                    accIdSet.add(oldRecord.AccountId);
                }
            }
        }

        if (accIdSet.isEmpty()) return;

        // Get max Amount per Account
        List<AggregateResult> aggList = [
            SELECT AccountId accId, MAX(Amount) maxAmt
            FROM Opportunity
            WHERE AccountId IN :accIdSet
            GROUP BY AccountId
        ];

        // Map Account → Max Amount
        Map<Id, Decimal> accToMaxAmt = new Map<Id, Decimal>();
        for (AggregateResult ag : aggList) {
            accToMaxAmt.put(
                (Id) ag.get('accId'),
                (Decimal) ag.get('maxAmt')
            );
        }

        // Get Opportunity name with highest Amount
        List<Opportunity> oppList = [
            SELECT Id, Name, Amount, AccountId
            FROM Opportunity
            WHERE AccountId IN :accIdSet
            AND Amount IN :accToMaxAmt.values()
        ];

        Map<Id, String> accToOppName = new Map<Id, String>();
        for (Opportunity opp : oppList) {
            if (accToMaxAmt.get(opp.AccountId) == opp.Amount) {
                accToOppName.put(opp.AccountId, opp.Name);
            }
        }

        // Update Account
        List<Account> accListToUpdate = new List<Account>();
        for (Id accId : accToOppName.keySet()) {
            Account acc = new Account();
            acc.Id = accId;
            acc.Name =
                accToOppName.get(accId) +
                ' has the highest Amount ' +
                String.valueOf(accToMaxAmt.get(accId));
            accListToUpdate.add(acc);
        }

        if (!accListToUpdate.isEmpty()) {
            update accListToUpdate;
        }
    }
}

    ________________________________________________________________________________________________
    Trigger OpportunityTrigger on Opportunity(after Update){
        OpportunityTrigger.afterUpdate(Trigger.NewMap, Trigger.OldMap);
    }
    public class OpportunityTrigger{
        public static void afterUpdate(Map<Id, Opportunity> newRecordsMap, Map<Id, Opportunity> oldRecordsMap){
            Set<Id> accIdSet = new Set<Id>();
            for(Opportunity newRecord : newRecordsMap.values()){
                Opportunity oldRecord = oldRecordsMap.get(newRecord.Id);
                if(newRecord.AccountId != oldRecord.AccountId){
                    if(newRecord.AccountId != null){
                        accIdSet.add(newRecord.AccountId);
                    }
                    if(oldRecord.AccountId != null){
                        accIdSet.add(oldRecord.AccountId);
                    }
                }else if(newRecord.Amount != oldRecord.Amountd){
                    if(newRecord.AccountId != null){
                        accIdSet.add(newRecord.AccountId);
                    }
                }
            }
            List<Account> accListToUpdate = new List<Account>();
            List<AggregateResult> aggList = [SELECT Name, AccountId, Max(Amount) MaxOppAmount FROM Opportunity
                                             WHERE AccountId IN: accIdSet GROUP BY AccountId];
            Map<Id, String> accToOppName = new Map<Id, String>();
            
            for(AggregateResult ag : aggList){
                Id accId = (Id)ag.get('AccountId');
                Decimal maxAmount = (Decimal)ag.get('MaxOppAmount');
                Account accountRecord = new Account();
                accountRecord.Id = accId;
                accountRecord.Name =  + 'has the highest Amount' + String.valueOf(maxAmount);
                accListToUpdate.add(accountRecord);
            }
            if(!accListToUpdate.isEmpty()){
                update accListToUpdate;
            }
        }
    }
*/

    /*
    //Trigger to count the number of opportunitylineitems associated with an opportunity
    // and display the count of accounts custom filled.
*********
* 20    *
*       *
*********
    Trigger OpportunityLineItemTrigger on OpportunityLineItem(after insert, after delete){
        if(Trigger.isAfter && Trigger.isInsert){
            OpportunityLineItemTriggerHandler.afterInsert(Trigger.New);
        }
        if(Trigger.isAfter && Trigger.isDelete){
            OpportunityLineItemTriggerHandler.afterDelete(Trigger.Old);
        }
    }
    
    public class OpportunityLineItemTriggerHandler{
        public static void afterInsert(List<OpportunityLineItem> oliList){
            if(!oliList.isEmpty()){
                Set<Id> oppIds = new Set<Id>();
                for(OpportunityLineItem oliObj : oliList){
                    if(oliObj.OpportunityId != null){
                        oppIds.add(oliObj.OpportunityId);
                    }
                }
            }
            Map<Id, Decimal> oliMap = new Map<Id, Decimal>();
            List<Opportunity> oppList = [SELECT Id, AccountId FROM Opportunity WHERE Id IN: oppIds];
            for(Opportunity opp : oppList){
                oliMap.put(opp.AccountId, 0);
            }
            
            for(AggregateResult ag : [SELECT Count(Id) oliCount, Opportunity.AccountId FROM OpportunityLineItem WHERE 
                                      Opportunity.AccountId IN: oliMap.keySet() GROUP BY Opportunity.AccountId]){
                 oliMap.put((Id)ag.get('AccountId'), (Decimal)ag.get('oliCount'));                        
             }
            List<Account> accListToUpdate = new List<Account>();
            for(Id accIds : oliMap.keySet()){
                Account acc = new Account();
                acc.Id = accIds;
                acc.Count_of_Products__c = oliMap.get(accIds);
                accListToUpdate.add(acc);
            }
            if(!accListToUpdate.isEmpty()){
                try{
                    update accListToUpdate;
                }catch(Exception ex){
                    System.debug('Can not update accListToUpdate' + ex.getMessage());
                }
        }
    }
*/
        
    


}