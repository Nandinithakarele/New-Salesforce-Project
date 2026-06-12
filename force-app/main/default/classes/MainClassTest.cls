@isTest //annotation
public class MainClassTest {
    @isTest
    public static void addPositiveTest(){
        MainClass.add(3, 2);
    }
    public testmethod static void addNegativeTest(){
        MainClass.add(12, 2);
    }
    @isTest
    public static void checkNumberTest(){
        MainClass.num = 5;
        MainClass.checkNumber();
    }

}