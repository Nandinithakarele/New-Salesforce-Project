@isTest
public class AccountTriggerTest {
    @isTest
    public static void updateContactMailingAddress(){
        List<Account> accList = new List<Account>();
        List<Contact> conList = new List<Contact>();
        for(Integer i=1; i<=5; i++){
            Account acc = new Account();
            acc.Name = 'Account' + i;
            acc.BillingCity = 'TestCity';
            acc.BillingCountry ='TestCountry';
            acc.BillingState='TestState';
            acc.BillingPostalCode = '1234';
            acc.BillingStreet = 'TestStreet';
            accList.add(acc);
        }
        test.startTest();
        insert accList;
        
        for(Account acc : accList){
            Contact con = new Contact();
            con.LastName = acc.Name;
            con.AccountId = acc.Id;
            conList.add(con);
        }
        insert conList;
        
        for(Account acc : accList){
            acc.BillingCity = 'Mumabai';
        }
        update accList;
        
        test.stopTest();
        
        List<Contact> updatedConList = [SELECT Id, MailingCity FROM Contact WHERE Id =: conList[0].Id];
        System.assertEquals('Mumabai', updatedConList[0].MailingCity);
        
    }

}