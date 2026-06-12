public class MainClass {
    @testvisible
    static Integer num;
    @testvisible //exposes the method only for testclass
    private static integer add(Integer num1, Integer num2){ //Through dummy data
        Integer result;
        System.debug(num1);
        if(num1 > 10){
            result = num1 + num2;
        }else{
            result = num1 - num2; //result = num1/0 for failing test cases
        }
        System.debug('result = ' + result);
        return result;
    }
     
    public static void checkNumber(){
        if(num == 5){
            System.debug('Hello');
        }
    }
    /*
    public static integer add(Integer num1, Integer num2){ //Through dummy data
        Integer result;
        System.debug(num1);
        if(num1 > 10){
            result = num1 + num2;
        }else{
            result = num1 - num2;
        }
        System.debug('result = ' + result);
        return result;
    }
*/
    //MainClass wrap = new MainClass();
    //System.debug(wrap.testWrapper());
    //wrapper class related code
    public AccountDetails testWrapper(){
        Account acc = [SELECT Id, Name, Active__c, Balance__c, accountNumber FROM Account LIMIT 1];
        
        AccountDetails wrapper = new AccountDetails();
        wrapper.accountName = acc.Name;
        wrapper.accountNum = acc.accountNumber;
        wrapper.balance = acc.Balance__c;
        wrapper.isActive = Boolean.valueOf(acc.Active__c);
        List<Contact> conDetails = [SELECT Id, Name FROM Contact WHERE AccountId =: acc.Id];
        wrapper.conList = conDetails;
        List<Opportunity> oppDetails = [SELECT Id, Name FROM Opportunity WHERE AccountId =: acc.Id];
        wrapper.oppList = oppDetails;
        return wrapper;
        //if I am returning acc then in method my return type should be Account
        //if I am returning accList then in method my return type should be List<Account>
        //if I am returning instance of a class in method then my return type should be instance class name
    }
    /*
     * // Wrapper class related code
public AccountDetails testWrapper() {

    // Query single Account → return type must support a single Account if returned
    Account acc = [SELECT Id, Name, Active__c, Balance__c, accountNumber 
                   FROM Account LIMIT 1];

    // Creating wrapper class instance → return type must be AccountDetails if returned
    AccountDetails wrapper = new AccountDetails();
    wrapper.accountName = acc.Name;
    wrapper.accountNum = Integer.valueOf(acc.accountNumber);
    wrapper.balance = acc.Balance__c;
    wrapper.isActive = Boolean.valueOf(acc.Active__c);

    // Query list of Contacts → return type must be List<Contact> if returned
    List<Contact> conDetails = [SELECT Id, Name FROM Contact];
    wrapper.conList = conDetails;

    // Returning wrapper instance → method return type must be AccountDetails
    return wrapper;

    /*
     * CORRECT COMMENT SUMMARY:
     *
     * - If I return `acc` → method return type must be `Account`.
     * - If I return `conDetails` → method return type must be `List<Contact>`.
     * - If I return `wrapper` → method return type must be `AccountDetails`.
     *
     * Meaning:  
     * The method return type must always match the type of the value returned.
     *
}
*/

}