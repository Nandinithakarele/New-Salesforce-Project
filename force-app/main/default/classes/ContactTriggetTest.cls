@isTest
public class ContactTriggetTest {
    @TestSetup
    private static void setupData(){
         //inserting parent(due to lokkup field)
        Account accountRecord = new Account(Name = 'Rollup Summary Trigger', Phone = '123', Industry = 'Education', Rating = 'Cold');
        insert accountRecord;
        //When the account inserted we get Id of the Account
        
        Contact contactRecord = new Contact();
        contactRecord.FirstName = 'Nandini';
        contactRecord.LastName = 'Thakarele';
        //contactRecord.Phone = '123';
        contactRecord.Email = 'nandini@gmail.com';
        contactRecord.AccountId = accountRecord.Id;
        insert contactRecord;
        }
    @isTest
    private static void insertTest(){
        List<Account> accList = [SELECT Id, Name, Number_of_Contacts_associate_to_account__c,(SELECT Id FROM Contacts)
                                 FROM Account WHERE Name = 'Rollup Summary Trigger' LIMIT 10];
        Assert.isNotNull(accList, 'no record found');
        for(Account acc : accList){
            List<Contact> conList = acc.Contacts;
            if(conList != null && conList.size() > 0){
                Assert.areEqual(1, conList.size(), 'The total contact count not match');
            }
            
        }
        if(accList != null && accList.size() > 0){
            Account accountRecord = accList.get(0);
            Assert.areEqual(1, accountRecord.Number_of_Contacts_associate_to_account__c, 'The total contact count not match');
        }
    }
   
    /*
     * @isTest
private static void updateTest(){

    // 1️⃣ Create new Account for update test
    Account newAcc = new Account(
        Name = 'Summary Account',
        Rating = 'Cold'
    );
    insert newAcc;

    // 2️⃣ Get the existing contact created in @TestSetup
    List<Contact> conList = [
        SELECT Id, Email, AccountId
        FROM Contact
        WHERE Email = 'nandini@gmail.com'
    ];

    // 3️⃣ Change AccountId to new account
    for(Contact con : conList){
        con.AccountId = newAcc.Id;
    }

    Test.startTest();
    update conList;
    Test.stopTest();

    // 4️⃣ Now validate both accounts
    List<Account> accList = [
        SELECT Id, Name, Number_of_Contacts_associate_to_account__c,
               (SELECT Id FROM Contacts)
        FROM Account 
        WHERE Name IN ('Summary Account', 'Rollup Summary Trigger')
    ];

    System.assert(!accList.isEmpty(), 'No accounts found');

    for(Account acc : accList){

        if(acc.Name == 'Summary Account'){
            System.assertEquals(
                1,
                acc.Number_of_Contacts_associate_to_account__c,
                'Summary Account should now have 1 contact'
            );
        }

        if(acc.Name == 'Rollup Summary Trigger'){
            System.assertEquals(
                0,
                acc.Number_of_Contacts_associate_to_account__c,
                'Old account should now have 0 contacts'
            );
        }
    }
}

   */
     @isTest
    private static void updateTest(){
        Account accountRecord = new Account(Name = 'Summary Account', Industry = 'Education', Phone = '123');
        insert accountRecord;
        List<Contact> conList = [SELECT Id, Email FROM Contact WHERE Email = 'nandini@gmail.com'];
        update conList;
        for(Contact con : conList){
            con.AccountId = accountRecord.Id;
        }
        test.startTest();
        update conList;
        test.stopTest();
        List<Account> accList = [SELECT Id, Name, Number_of_Contacts_associate_to_account__c,(SELECT Id FROM Contacts)
                                 FROM Account WHERE Name IN ('Summary Account', 'Rollup Summary Trigger')];
        //Rollup Summary Trigger - old Account - have count 1- updated to 0
        //Summary Account - new Account - have count 0- updated to 1
        
        Assert.isNotNull(accList, 'no record found');
        for(Account acc : accList){
            List<Contact> contactList = acc.Contacts;
            if(conList != null && contactList.size() > 0){
                Assert.areEqual(1, contactList.size(), 'The total contact count not match');
            }
            if(acc.Name == 'Summary Account'){
                Assert.areEqual(1, acc.Number_of_Contacts_associate_to_account__c, 'The total contact count not match');
            }
            if(acc.Name == 'Rollup Summary Trigger'){
                Assert.areEqual(0, acc.Number_of_Contacts_associate_to_account__c, 'The total contact count not match');
            }
            
        }
        
    }
    @isTest
    private static void deleteTest(){
         List<Contact> conList = [SELECT Id, Email FROM Contact WHERE Email = 'nandini@gmail.com'];
         delete conList;
        List<Account> accList = [SELECT Id, Name, Number_of_Contacts_associate_to_account__c,(SELECT Id FROM Contacts)
                                 FROM Account WHERE Name = 'Rollup Summary Trigger'];
        for(Account acc : accList){
            if(acc.Name == 'Rollup Summary Trigger'){
                Assert.areEqual(0, acc.Number_of_Contacts_associate_to_account__c, 'The total contact count not match');
            }
        }
    }
    
    @isTest
    private static void UnDeleteTest(){
        List<Contact> conList = [SELECT Id, Email FROM Contact WHERE Email = 'nandini@gmail.com'];
         delete conList;
        List<Account> accList = [SELECT Id, Name,  Number_of_Contacts_associate_to_account__c,(SELECT Id FROM Contacts)
                                 FROM Account WHERE Name = 'Rollup Summary Trigger'];
        for(Account acc : accList){
            if(acc.Name == 'Rollup Summary Trigger'){
                Assert.areEqual(0, acc.Number_of_Contacts_associate_to_account__c, 'The total contact count not match');
            }
        }
        Test.startTest();
        Undelete conList;
        Test.stopTest();
        
        List<Account> accountList = [SELECT Id, Name, Number_of_Contacts_associate_to_account__c,(SELECT Id FROM Contacts)
                                 FROM Account WHERE Name = 'Rollup Summary Trigger'];
        for(Account acc : accountList){
            if(acc.Name == 'Rollup Summary Trigger'){
                Assert.areEqual(1, acc.Number_of_Contacts_associate_to_account__c, 'The total contact count not match');
            }
        }
        
    }
      
    
        
    

}