/* 
 * AccountsBatchable batchable = new AccountsBatchable();
   Id jobId = Database.executeBatch(batchable, 1);//here 1 is our batch size or chuk size calculation no. of record / chunk size
*/
/*
 * List<Account> accountList = new List<Account> ();
AccountsBatchable batchable = new AccountsBatchable('Hot', accountList);
Id jobId = Database.executeBatch(batchable, 1);
*/
//for taking input in a batch firstly we need to create constructor 



public class AccountsBatchable implements Database.Batchable<sObject>{
    private String rating;
    private List<Account> accountList;
    public AccountsBatchable(String rating, List<Account> accountList){
    this.rating = rating;
    this.accountList = accountList;
    
    }
    public  Database.QueryLocator start(Database.BatchableContext batchContext){
        System.debug('Start Method');
        //String rating = 'Hot';//hard coded rating for fixing it we are creating constructor
        return Database.getQueryLocator('SELECT Id, Name FROM Account WHERE Rating =:rating');
        //if we try to call batch from start method then it will compilation error not  runtime error
        //ContactsBatchable batchJob = new ContactsBatchable();
        //Id jobId = Database.executeBatch(batchJob);
        
    }
    
    public void execute(Database.BatchableContext batchContext, List<sObject> sObjectList){
        List<Account> accountList = (List<Account>)sObjectList;
        System.debug('Execute Method' + accountList);
        //if we try to call batch from start method then it will compilation error not  runtime error
        //ContactsBatchable batchJob = new ContactsBatchable();
        //Id jobId = Database.executeBatch(batchJob);
        
    }
    
    public void finish(Database.BatchableContext batchContext){
        System.debug('Finish Method');
        //calling batch from another batch possible in finish method only
        ContactsBatchable batchJob = new ContactsBatchable();
        Id jobId = Database.executeBatch(batchJob);//if we arepassing 2nd parameter that is our batch size or chunk size and batchsize which is instace 
        //represents no of records so it will calculate like no. of recordes / batch size or chunk size which will give output in chunk handler
        //minimum batch size is 1 if we put zero then error occur
    }
    // write down method that will query 10 account record put loop on it and store acc id in set use the set to associate use the query assosiated contacts 
    //and print it
     public  void processAccountsAndContacts() {
        // Query up to 10 Account records
        List<Account> accounts = [SELECT Id, Name FROM Account LIMIT 10];

        // Store Account IDs in a Set
        Set<Id> accountIds = new Set<Id>();
        for (Account acc : accounts) {
            accountIds.add(acc.Id);
        }

        // Query associated Contacts using the Set of Account IDs
        List<Contact> contacts = [SELECT Id, FirstName, LastName, AccountId 
                                  FROM Contact 
                                  WHERE AccountId IN :accountIds];

        // Print the associated Contacts
        System.debug('Associated Contacts:');
        for (Contact con : contacts) {
            System.debug('Contact Name: ' + con.FirstName + ' ' + con.LastName + ', Account ID: ' + con.AccountId);
        }
    }
    
    
    

}