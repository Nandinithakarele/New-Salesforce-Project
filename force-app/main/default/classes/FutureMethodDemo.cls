public class FutureMethodDemo {
    
    public static void run(){
        //step1: create Account //NoN-Setup Object
        //step2: create user //Setup object
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        Account accRecord = new Account(
            Name = 'Salesforce.org' + randomInt,
            Rating = 'Hot'
     
        );
        insert accRecord;
        //step2: create user //Setup object
        createUser();//createUser() these is our future method it will insert user in future.
        //while calling future method which is our async method if I get error in 2nd or 3rd line after
        //future method then future method will stop running we says it as rollback
        //and if we handle these exception then error will not occur.
        try{
            Integer i = 100/0;//handled mathException
            
        }catch(System.exception ex){
            
        }
    }
    
    @future
    public static void method2(){
        
    }
    
    //when we give role while creating user then only mixed dml error will ocuur
    //to handle these we make our method createUser which is setup object we make  it as future 

    
    @future
    public static void createUser(){
       
        UserRole role = [SELECT Id FROM UserRole WHERE Name = 'COO'];
        Profile profile = [SELECT Id FROM Profile WHERE Name = 'Minimum Access - Salesforce'];
        String orgId = UserInfo.getOrganizationId();
        String dateString =
        String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        User tempUser = new User(
        FirstName = 'Nandini',
        LastName = 'Thakarele',
        email = uniqueName + '@sfdc' + orgId + '.org',
        Username = uniqueName + '@sfdc' + orgId + '.org',
        EmailEncodingKey = 'ISO-8859-1',
        Alias = uniqueName.substring(18, 23),
        TimeZoneSidKey = 'America/Los_Angeles',
        LocaleSidKey = 'en_US',
        LanguageLocaleKey = 'en_US',
        ProfileId = profile.Id,
        UserRoleId = role.Id
    );
        insert tempUser;
        
        
    }  

}