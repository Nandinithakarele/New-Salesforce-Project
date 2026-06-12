//To call Apex From flow

public class AccountUtility {
    
   @InvocableMethod
   public static List<String> getAccountNames(List<Id> accIds) {
       
   List<String> accountNames = new List<String>();
       
   for (Account acc : [SELECT Name FROM Account WHERE Id IN :accIds]) {
      accountNames.add(acc.Name);
   }
   return accountNames;
   }

}