/*public class PracticeCode {
}*/
/*get 10 acc record which are inactive and update their status to Inactive to active 
List<Account> accList = new List<Account>();
accList = [SELECT Id, Active__c FROM Account WHERE Active__c == 'NO'];
for(Account acc : accList){
    acc.Active__c = 'Yes'
}
update accList;
*/
public class PracticeCode {
    public static void demo(){
        //quey all account related to contacts
        /*List<Account> accList = new List<Account>();
        accList = [SELECT Id, phone, Name,(SELECT Id, FROM Contacts) FROM Account WHERE phone != null];
        for(Account acc : accList){
            System.debug(acc.Name + 'Account Name has' + acc.Contacts.size() + 'related');
        }*/
        //query all account related to opportunities
        /*List<Account> accList = new List<Account>();
        accList = [SELECT Id, phone, Name, (SELECT Id FROM Opportunities) FROM Account Where phone != null];
        for(Account acc : accList){
            System.debug(acc.Name + 'has' + acc.Opportunities.size() );
            
        }*/
        //query all account related to opportunities give all opportunityAmountsum
        /*List<Account> accList = new List<Account>();
        accList = [SELECT Id, phone, Name, (SELECT Id, Amount FROM Opportunities) FROM Account Where phone != null];
        for(Account acc : accList){
            decimal total = 0;
            for(Opportunity opp : acc.opportunities){
                if(opp.Amount != null){
                total += opp.Amount
               }
            }
            System.debug(acc.Name + 'has' + total + 'worth opportunities' );
            
        }*/
        
        /*List<Opportunity> oppList = new <Opportunity>();
        oppList = [SELECT Id, StageName, Createdate FROM Oppotunity WHERE Createdate = THIS_YEAR];
        for(Opportunity opp : oppList){
            if(opp.StageName == ''){
               opp.Description = ''; 
            }else if(opp.StageName == ''){
                opp.Description = ''; 
            }else{
                opp.Description = ''; 
            }
        }
        If(!oppList.isEmpty()){
            update oppList
        }*/
        /*List<Account> accList = new List<Account>();
        accList = [SELECT Id, Total_Contacts__c,  (SELECT Id FROM Contacts) FROM Account WHERE  Createdate = THIS_YEAR];
        for(Account acc : accList){
            List<Contact> conList = acc.Contacts;
            if(conList.size() == 0){
                acc.Total_Contacts__c = 0;
            }else {
                acc.Total_Contacts__c = conList.size();
            }
        }*/
        /*
        
        //query all contact related to account
        List<Contact> conList = new List<Contact>();
        conList = [SELECT Id, AccountId, Account.Name FROM Contact WHERE AccountId != null];
        for(Contact con : conList){
            System.debug(con.Account.Name);
            
        } 
        
        }
        
        public static void scenario1(){
            List<Account> accList = new List<Account>();
            for(Integer i = 1; i <= 5; i++){
                Account acc = new Account();
                acc.Name = 'test' + i;
                acc.Phone = '12345';
                accList.add(acc);
            }
            insert accList;
            System.debug(accList);
        }
    public static void scenario2(){
        
        Account acc = new Account();
        acc.Name = 'test';
        insert acc;
        Contact con = new Contact();
        con.LastName = 'con';
        con.AccountId = acc.Id;
        insert con;
    }
    
    public static void scenario3(){
        List<Opportunity> oppList = new List<Opportunity>();
        oppList = [SELECT Id, StageName, Amount FROM Opportunity WHERE Stagename IN('Closed Won', 'Closed Lost')
                  AND Amount != null];
        for(Opportunity opp : oppList){
            Decimal oppClosedAtotal = 0;
            if(opp.StageName == 'Closed Won'){
                oppClosedAtotal += opp.Amount;
                System.debug(oppClosedAtotal);
            }
            Decimal oppClosedBtotal = 0;
            if(opp.StageName == 'Closed Lost'){
                oppClosedBtotal += opp.Amount;
                System.debug(oppClosedBtotal);
            }
        }
        
        
    }
*/
    }
    
        
}