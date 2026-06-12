public class ContactController {
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactRecords(String searchName){
        String name = '%' + searchName + '%';
        List<Contact> conList = [SELECT Id, Name, FirstName, LastName FROM Contact WHERE Name LIKE :name];
        return conList;
    }
    
    @AuraEnabled
    public static void getContactsUsingImperative(String firstName, String lastName, String phone, String email){
        Contact contact = new Contact();
        contact.FirstName = firstName;
        contact.LastName = lastName;
        contact.Phone = phone;
        contact.Email = email;
        insert contact;
        
    }
    
    @AuraEnabled
    public static List<Account> getAccountRecords(String accountName){
        return [SELECT Id, Name FROM Account WHERE Name LIKE :('%' + accountName + '%') LIMIT 10];
    }

}