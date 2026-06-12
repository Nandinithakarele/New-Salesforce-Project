public class AccountService {
    @testvisible
    private static Integer accountCounter;
    
    @testvisible
    private static Integer incrementCounter(){
        accountCounter++;
        return accountCounter;
    }
    public static void createAccount(){
        if(accountCounter > 6){
            System.debug('Hi');
        }
    }
    
}