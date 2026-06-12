/*Limitation of future method
 * we can not call one future from another
 * we can not use non premitive data type in future method
 * we can notbe tracked or monitor jobId in future method
 */
/*calling AccountQueueablenWHen Passing list in Constructor
 * List<Account> accRecordList = new List<Account>();
 * AccountQueueable queueable = new AccountQueueable(accRecordList);
 * Id jobId = System.enqueueJob(queueable);
 * System.debug('jobId' + jobId);
 * */
/*calling AccountQueueablenWHen Passing Se<Id> in Constructor Set Of Id will only make that object which is Queueable on object in these we mae accountIdSet
 * Set<Id> accountIdSet = new Set<Id>();
 * AccountQueueable queueable = new AccountQueueable(accountIdSet);
 * Id jobId = System.enqueueJob(queueable);
 * System.debug('jobId' + jobId);
 * */

public class AccountQueueable implements System.Queueable{
    /*
    //making contsructor // we are not passing non-premitive data type in queueable and future both because possibility of data loss so we need
    //to always use set<Id>
    public List<Account> accRecordList;
    public AccountQueueable(List<Account> accList){
        this.accRecordList = accList;
    }*/
    public Set<Id> accountIdSet;
    public AccountQueueable(Set<Id> accountIdSet){
        this.accountIdSet = accountIdSet;
    }
    
    public void execute(System.QueueableContext ctx){
        
        AccountQueueableHandler.prepareAccount(this.accountIdSet);
    
   }
}
//code without making handler class
/*
 public class AccountQueueable implements System.Queueable{
    /*
    //making contsructor // we are not passing non-premitive data type in queueable and future both because possibility of data loss so we need
    //to always use set<Id>
    public List<Account> accRecordList;
    public AccountQueueable(List<Account> accList){
        this.accRecordList = accList;
    }*/
   /*
    public Set<Id> accountIdSet;
    public AccountQueueable(Set<Id> accountIdSet){
        this.accountIdSet = accountIdSet;
    }
    
    public void execute(System.QueueableContext ctx){
        System.debug('Queueable executed');
        //when we use List<Account> accRecordList in Contsructor then we use these
        //System.debug(accRecordList);
        /*for(Account acc : accRecordList){
            
        }
       */
        /*
        //when we use set in constructor
        List<Account> accountRecordList = [SELECT Id, Name FROM Account WHERE Id IN: accountIdSet];
        for(Account acc : accountRecordList){
            
        }
        */
        
        /*ContactQueueable queueable = new ContactQueueable(10, accRecordList);
        Id jobId = System.enqueueJob(queueable);
        System.debug('Child jobId' + jobId);
        

         we can add only one job to parent job
         below code not possible
         ContactQueueable queueable1 = new ContactQueueable();
         Id jobId = System.enqueueJob(queueable1);
         System.debug('Child jobId' + jobId);*/
          /*ContactQueueable queueable2 = new ContactQueueable();
        Id jobId = System.enqueueJob(queueable2);
        System.debug('Child jobId' + jobId);
        */
        
        /*
        //we can call multiple future method from async apex in Queueable
        FutureMethodDemo.method2(); //calling future method in Queueable
        FutureMethodDemo.method2();// calling future method in Queueable 
        
        //use of System.QueueableContext
        Id jobId = ctx.getJobId();
        AsyncApexJob jobInfo = [SELECT Status, NumberOfErrors FROM AsyncApexJob WHERE Id =: jobId];
        
    }
    
}*/


        
        
       
        
        //we can call multiple future method from async apex in Queueable
        
        //FutureMethodDemo.method2(); //calling future method in Queueable
        //FutureMethodDemo.method3();// calling future method in Queueable 
        
    
    
    //Future method Limitations
    //1.can not be tracked or monitered - in Queueable we can track we have jobId 
    //2.can not pass non-premitive data type - in Queueable - Queueable is class so we can pass any data 
    //type to contructor and future apex is method thats why not possible
  
    //3.future is not allowed from future we can not call - in Queueable we can call Queueable from Queueable and future from 
    //queueable