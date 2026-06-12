public class AccountTriggerHandler {
    
    public static void handleBeforeInsert(List<Account> accList){
        AccountTriggerHelper.updateAccountShippingAddress(accList);
        AccountTriggerHelper.checkDuplicateRecordsFromAccount(accList);
          
    }
    
    
    
    public static void handleAfterInsert(List<Account> accList){
        //1.requrement 1
        List<Task> taskRecordToInsertList = new List<Task>();
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
        List<Account> newAccountList = [SELECT Id, OwnerId, Owner.Name, Owner.Email FROM Account WHERE Id IN : accList];
        for(Account acc : accList){
            if(acc.phone == null /* && (acc.Industry == null)*/){
                Task t = new Task();
                t.Subject = 'Email1';
                t.Status = 'Not Started';
                t.Priority = 'High';
                t.ActivityDate = System.Today().addDays(7);
                t.whatId = acc.Id;
                t.OwnerId = acc.OwnerId;
                taskRecordToInsertList.add(t);
                                   
            
            //2.requirement 2 send email when phone and industry is null in account send email to aacount owner with account name
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            
            email.setSubject('New Account' + acc.Name + 'Has been assigned');
            List<String> toAddress = new List<String>();
            toAddress.add(acc.OwnerId);
            email.setToAddresses(toAddress);
                
            List<String> bccAddress = new List<String>();
            bccAddress.add('thakrele2018@gmail.com');
            email.setBccAddresses(bccAddress);
            
            String emailBody = 'Dear' + acc.Owner.Name + '<br/><br/>' +
             'A new Account' + acc.Name + 'has been created in salesforce <br/><br/>' +
             'Thanks and Regards <br/><br/>'; 
            email.setHtmlBody(emailBody);    
            emailList.add(email);
                  
                  
         }
       }
        List<Messaging.sendEmailResult> sendEmailResults = Messaging.sendEmail(emailList, false);
        for(Messaging.sendEmailResult sr : sendEmailResults){
            Boolean isSuccess = sr.isSuccess(); // True or False
            if(isSuccess){
                System.debug('Email sent successfully');
            }else{
                System.debug('Facing error while sending email');
                List<Messaging.SendEmailError> errors = sr.getErrors();
                System.debug(errors);
            }
        }
        insert taskRecordToInsertList;
        
    }
    
    public static void handleBeforeUpdate(List<Account> accList){
          AccountTriggerHelper.updateAccountShippingAddress(accList);
          AccountTriggerHelper.checkDuplicateRecordsFromAccount(accList);
        
    }
    
     
    
    
    

}