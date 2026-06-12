@isTest
public class AccountServiceTest {
    @isTest
    public static void incrementCounterTest(){
        AccountService.accountCounter = 0;
        Test.StartTest();
        AccountService.incrementCounter();
        Test.StopTest();
        System.assertEquals(1, AccountService.accountCounter);
    }
    @isTest
    public static void createAccountTest(){
        AccountService.accountCounter = 7;
        Test.StartTest();
        AccountService.createAccount();
        Test.StopTest();
        System.assertEquals(7, AccountService.accountCounter);
    }

}