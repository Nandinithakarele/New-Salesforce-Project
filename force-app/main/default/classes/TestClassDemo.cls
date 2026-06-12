@isTest
public class TestClassDemo {
    @isTest
    public static void insertAccountTest(){
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
            ProfileId = profile.Id
            );
        System.runAs(tempUser){
        Account accountRecord = new Account();
        accountRecord.Active__c = 'Yes';
        accountRecord.Industry = 'Education';
        accountRecord.AccountSource = '';
        accountRecord.AccountSource = '';
        insert as user accountRecord;
    }
       
    }
    
            

}