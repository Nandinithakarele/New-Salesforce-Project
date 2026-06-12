public class LoginController {
    @AuraEnabled
    public static Boolean fetchUserDetails(String username, String password){
        List<Credential__c> userDetails = [SELECT Id, UserName__c, Password__c FROM Credential__c
                                   WHERE UserName__c =: username AND Password__c =: password];
        Boolean userExists = false;
        if(!userDetails.isEmpty()){
            userExists = true;
        }
        return userExists;
        
    }

}