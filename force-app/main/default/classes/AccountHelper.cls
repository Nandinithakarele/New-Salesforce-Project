public class AccountHelper {
    /*Create a class AccountHelper with a method getHighValueAccounts(Decimal minValue)
 that returns a list of Accounts with AnnualRevenue > minValue.*/
    
    public List<Account> getHighValueAccounts(Decimal minValue){
        
       List<Account> accList = [SELECT Id, Name, AnnualRevenue FROM Account WHERE AnnualRevenue > :minValue];
        return accList;
        
    }
    //Create a method updateAccountPhone(List<Account> accList, String phone) → update all Accounts’ phone.
    public void updateAccountPhone(List<Account> accList, String phone){
        
        List<Account> accListTOUpdate = new List<Account>();
        for(Account acc : accList){
            acc.Phone = phone;
            accListTOUpdate.add(acc);
        }
        update accListTOUpdate;
    }
    //AccountHelper a = new AccountHelper();
    //List<Account> accList = [SELECT Id, Name FROM Account ];
    //a.updateAccountPhone(accList, '123');
    
    /*
     * Create a method mapAccountToContacts(List<Account> accList) → return a Map<Id,List<Contact>>.*/
    public void mapAccountToContacts(List<Account> accList){
        Set<Id> accIds = new Set<Id>();
         Map<Id,List<Contact>> mapIdVsContact = new Map<Id,List<Contact>>();
        for(Account acc : accList){
            accIds.add(acc.Id);
            mapIdVsContact.put(acc.id, new List<Contact>());
        }
       
        for(Contact con : [Select Id, AccountId FROM Contact WHERE AccountId IN: accIds]){
            mapIdVsContact.get(con.AccountId).add(con);
        }
    }
    //List<Account> accs = [SELECT Id, Name FROM Account LIMIT 3];
    //Map<Id, List<Contact>> result = mapAccountToContacts(accs);

    //System.debug(result);
    //
    //Create method getOpportunitySumByAccount(List<Id> accIds) → return a Map<Id,
    //Decimal> where key = AccountId and value = SUM(Opportunity.Amount).
    public static Map<Id, Decimal> getOpportunitySumByAccount(List<Id> accIds) {
    Map<Id, Decimal> oppSumMap = new Map<Id, Decimal>();

    if (accIds == null || accIds.isEmpty()) {
        return oppSumMap;
    }

    // Aggregate Opportunity Amount by AccountId
    for (AggregateResult ar : [
        SELECT AccountId, SUM(Amount) sumAmt
        FROM Opportunity
        WHERE AccountId IN :accIds
        GROUP BY AccountId
    ]) {
        oppSumMap.put((Id) ar.get('AccountId'), (Decimal) ar.get('sumAmt'));
    }

    // Ensure all AccountIds exist in map (with zero if no opportunities)
    for (Id accId : accIds) {
        if (!oppSumMap.containsKey(accId)) {
            oppSumMap.put(accId, 0);
        }
    }

    return oppSumMap;
}
//Homework: Use this method to update a custom field Total_Opportunity_Amount__c on
//Account
    public static void updateAccountOpportunityAmount(List<Account> accList) {
    if (accList == null || accList.isEmpty()) {
        return;
    }

    // Collect Account Ids
    List<Id> accIds = new List<Id>();
    for (Account acc : accList) {
        accIds.add(acc.Id);
    }

    // Get the Opportunity sum per Account
    Map<Id, Decimal> oppSumMap = getOpportunitySumByAccount(accIds);

    // Update the custom field on Account
    for (Account acc : accList) {
        //acc.Total_Opportunity_Amount__c = oppSumMap.get(acc.Id);
    }

    update accList;
}




    
 
 

}