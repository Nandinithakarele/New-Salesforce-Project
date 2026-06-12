@isTest
public class AccountManagerTest {
    
    // Step 1: Create common test data
    @testSetup
    static void setupData() {
        Account acc = new Account(
            Name = 'SP',
            Industry = 'Banking'
        );
        insert acc;
    }

    // Step 2: Test updateAccountIndustry method
    @isTest
    static void testUpdateAccountIndustry() {

        // Get test data
        Account acc = [SELECT Id, Industry FROM Account WHERE Name = 'SP'];

        Test.startTest();
        AccountManager.updateAccountIndustry(acc.Id, 'Electronics');
        Test.stopTest();

        // Verify result
        Account updatedAcc = [SELECT Industry FROM Account WHERE Id = :acc.Id];
        System.assertEquals('Electronics', updatedAcc.Industry);
    }

    // Step 3: Test getAccountByName method
    @isTest
    static void testGetAccountByName() {

        Test.startTest();
        Account acc = AccountManager.getAccountByName('SP');
        Test.stopTest();

        // Verify result
        System.assertEquals('SP', acc.Name);
    }

}