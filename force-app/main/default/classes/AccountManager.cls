public class AccountManager {
    public static void updateAccountIndustry(Id accountId, String newIndustry) {
      
        Account acc = [SELECT Id, Industry FROM Account WHERE Id = :accountId LIMIT 1];
        
        acc.Industry = newIndustry;
        
        update acc;
    }

    public static Account getAccountByName(String accountName) {
     
        return [SELECT Id, Name, Industry FROM Account WHERE Name = :accountName LIMIT 1];
    }

}