//FirstClass f1 = new FirstClass('Roshan', 24);
//FirstClass f2 = new FirstClass('Roshan');
public class FirstClass {
    public String name;
    public Integer age;
    //whatever values we are defining inside class that will automaticall assigned while calling default constructor
    //and default constucor already we are making while making instance of class
    
    public FirstClass(){//default constructor
        
    }
    
    /*public FirstClass(String fname, Integer currentAge){//paremeterized constructor
        this.name = fname;//this keyword refers to the current class
        this.age = currentAge;//we are storing constructor variable value inside class variable
        System.debug(this.name);
        System.debug(age);
    }*/
    public FirstClass(String name, Integer age){//paremeterized constructor
        this.name = name;//this keyword refers to the current class
        this.age = age;//we are storing constructor variable value inside class variable
        System.debug(this.name);
        System.debug(this.age);
    }
    public FirstClass(String fname){
        this.name = fname;
    }
    
    public void createAccCon(List<Account> accList){
        List<Contact> conList = new List<Contact>();
        
    }
    //create a method which accepts number of times Account record should be created
    public void createNoOfAccount(Integer noOfAcc){
        List<Account> accList = new List<Account>();
        for(Integer i = 1; i<= noOfAcc; i++){
            Account acc = new Account();
            acc.Name = 'Accountmethod' + i;
            accList.add(acc);
        }
        if(!accList.isEmpty()){
            insert accList;
        }
        
    }
    //create a method which accepts accountId fetch all the contacts related to that account
    public void fetchContact(Id accountId, String accName){
        List<Contact> conList = [SELECT Id, Name, accountId FROM Contact WHERE accountId =:accountId AND Name =: accName];//whenever we are using variable in SOQL we use colon
        System.debug(conList);
    }
    //create a method which accepts a character query all the contacts which have that character in their name 
    //also the contact should have account associate 
    public void fetchAllConRelatedToAcc(String character){
        String str = '%'+ Character + '%';
        List<Contact> conList = [SELECT Id, Name FROM Contact WHERE Name LIKE: str AND accountId != null];
        System.debug(conList);
        
    }
    //create a method which accepts list of account for each account create a related contact
    public void createAccRelatedContact(List<Account> accList){
        List<Contact> conList = new List<Contact>();
        for(Account acc : accList){
            Contact con = new Contact();
            con.AccountId = acc.Id;
            con.LastName = acc.Name;
            conList.add(con);
        }
        insert conList;
        System.debug(conList);
        
    }
    //List<Account> accList = [SELECT Id, Name FROM Account LIMIT 5];
    //FirstClass c = new FirstClass();
    //c.createAccRelatedContact(accList);
    //
    //
    //create a method which accepts list of city name fetch all the client address which are not from that city
    public void fetchClientAddress(List<String> cityList){
        List<Client_Address__c> clAdList = [SELECT Id, Name, City__c FROM Client_Address__c WHERE City__c Not IN:cityList];
        System.debug(clAdList);
        //List<String> cityList = new List<String>();
        //cityList.add('pune');
        //cityList.add('Nagpur');
        //FirstClass c = new FirstClass();
        //c.fetchClientAddress(cityList);
        
    }
    //create a method which accepts list of clients who are major for each client create a client address of Nagpur
    public void createclAddresses(List<Client__c> clientsList){
        List<Client_Address__c> clientcityList = new List<Client_Address__c>();
        for(Client__c c : clientsList){
            Client_Address__c clAdd = new Client_Address__c();
            clAdd.City__c = 'Nagpur';
            clAdd.Client__c = c.Id;
            clientcityList.add(clAdd);
            
        }
        insert clientcityList;
        System.debug(clientcityList);
        
    }
    //create a method which accepts list of accounts inside method delete those accounts if they are not active
    public void delNonActiveAcc(List<Account> accList){
        List<Account> accountList = new List<Account>();
        for(Account acc : acclist){
            if(acc.Active__c == 'No'){
                accountList.add(acc);
            }
        }
        delete accountList;
        
    }
    //create a method which accepts contacts that are related to a account for these contacts change lastname to 'CloudIntellect'
    public void conRelToAcc(List<Contact> conList){
        List<Contact> contactlist = new List<Contact>();
        for(Contact con : conList){
            if(con.AccountId != null){
                con.LastName = 'CloudIntellect';
                contactlist.add(con);
            }
            update contactlist;
               
        }
        
    }
    
    //write a method query 10 Account record do  loop on account create set and stored account id query associated opportunity 
    public void cearateOpp(){
        List<Account> accList = [SELECT Id, Name FROM Account LIMIT 10];
        Set<Id> accIds = new Set<Id>();
        for(Account acc : accList){
            accIds.add(acc.Id);
        }
        List<Opportunity> oppList = [SELECT Id, Name, AccountId,Amount FROM Opportunity WHERE AccountId IN: accIds and Amount != null];
        Map<Id, Decimal> idVsAmountMap = new Map<Id, Decimal>();
        for(Opportunity opp : oppList){
            idVsAmountMap.put(opp.Id, opp.Amount);
           
        }
    }
    
    //create a method which accepts list of account, inside method create a map of accound id vs list of contact associated to that id
    
// create a method query 10 contact related to account created set and stored account id
// //write down the method that take input parameter as Id of Account check whether account has 
// //associated to contact or not if contact is not there create associated contact with that account
    public void create(Id accIds){
        
        
        List<Account> accList = [SELECT Id, Name,(SELECT Id, AccountId FROM Contacts) FROM Account WHERE Id =: accIds];
        for(Account acc : accList){
            List<Contact> conList = new List<Contact>();
            if(acc.Contacts.isEmpty()){
                Contact con = new Contact();
                con.lastName = 'lastName forthose contact which arte not related to account';
                con.AccountId = acc.Id;
                conList.add(con);
                
            }
            if(!conList.isEmpty()){
                insert conList;
            }
            
        }
    }
    
    
    public void createConRelToAcc(Id accIds){
        
    }
    public void createdConAndOpp(String accountName){
        Account newAccount = new Account();
        newAccount.Name = accountName;
        insert newAccount;
        
        Contact newContact = new Contact(
            FirstName = 'Primary',
            LastName = 'Contact',
            AccountId = newAccount.Id
            
        );
        insert newContact;
        
        Opportunity newOpportunity = new Opportunity(
            Name = accountName + ' - Initial Opportunity',
            AccountId = newAccount.Id,
            StageName = 'Prospecting', 
            CloseDate = Date.today().addMonths(3) // Example close date
        );
        insert newOpportunity;
        
        
    }
    /*
     * Create method getContactCountByAccount(List<Id> accIds) → return a Map<Id, Integer>
where key = AccountId and value = COUNT(Contact).
*/
    public Map<Id, Integer> getContactCountByAccount(List<Id> accIds){
        Map<Id, Integer> IdVsIntegerMap = new Map<Id, Integer>();
        List<AggregateResult> AggregateList = [SELECT COUNT(Id) countContact, AccountId FROM Contact WHERE AccountId IN: accIds GROUP By AccountId];
        for(AggregateResult sr : AggregateList){
           IdVsIntegerMap.put((Id)sr.get('AccountId'),
               (Integer)sr.get('countContact'));
                             
        }
        return IdVsIntegerMap;
    }

//query 10 account record stored account id into set use the set to query accounts and contact by using inner query.    
    public void createMe1(){
        List<Account> accList = [SELECT Id FROM Account LIMIT 10];
        Set<Id> accIds = new Set<Id>();
        for(Account acc : accList){
            accIds.add(acc.Id);
        }
        
        List<Account> accountList = [SELECT Id, (SELECT Id, AccountId FROM Contacts) FROM Account WHERE Id IN: accIds];
    }
    //write down a method that will query 10 account records stored the account id into set use the set to do inner query
    //on account and opportunities put down a loop on it. and create the map of account id vs list of opportunity
    public void createMap(){
        List<Account> accList = [SELECT Id, Name FROM Account LIMIT 10];
        Set<Id> accIds = new Set<Id>();
        for(Account acc : accList){
            accIds.add(acc.Id);
        }
        List<Account> accountList = [SELECT Id, Name,(SELECT Id, AccountId FROM Opportunities) FROM Account WHERE Id IN: accIds];
        Map<Id, List<Opportunity>> IdVsListOfOppMap = new  Map<Id, List<Opportunity>>();
        for(Account acc1 : accountList){
            IdVsListOfOppMap.put(acc1.Id, acc1.Opportunities);
        }
    }
    /*
     * by using only one query
     * public void createMap(){
    List<Account> accountList = [
        SELECT Id, Name, (SELECT Id, AccountId FROM Opportunities)
        FROM Account
        LIMIT 10
    ];
    
    Map<Id, List<Opportunity>> IdVsListOfOppMap = new Map<Id, List<Opportunity>>();
    
    for(Account acc : accountList){
        IdVsListOfOppMap.put(acc.Id, acc.Opportunities);
    }
}*/
    //write down a method query account records create  a map of account id vs no. of contacts associate to it.
    
    public void createMapOfAccAndRelContacts(){
        
        List<Account> accList = [SELECT Id, Name,(SELECT Id, Name FROM Contacts) FROM Account LIMIT 10];
        Map<Id,Integer> IdVsListOfConMap = new Map<Id,Integer>();
        for(Account acc : accList){
            IdVsListOfConMap.put(acc.Id, acc.Contacts.size());
        }
        
        System.debug(IdVsListOfConMap);
    }

    /*
    
public void createMapOfAccAndRelContacts() {
    
    List<Account> accList = [
        SELECT Id, Name, (SELECT Id, Name FROM Contacts)
        FROM Account
        LIMIT 10
    ];
     
    
    Map<Id, List<Contact>> IdVsListOfConMap = new Map<Id, List<Contact>>();
    
    for (Account acc : accList) {
        IdVsListOfConMap.put(acc.Id, acc.Contacts);
    }
    
    System.debug(IdVsListOfConMap);
}
*/
    /*
     * List<AggregateResult> aggList = [SELECT AccountId, Count(Id) countOfContact FROM Contact GROUP BY AccountId];
for(AggregateResult ag: aggList){
    System.debug(ag.get('AccountId'));
    System.debug(ag.get('countOfContact'));
}
*/
    
    //write a method that will create a map of account id vs sum of amount on opportunity.
    public void createMapOfAccIdvsOppAm(){
        List<AggregateResult> aggList = [SELECT AccountId, Sum(Amount) sumOfOpportunityAmount FROM Opportunity Group By AccountId];
        Map<Id,Decimal> mapOfIdVsAmount = new Map<Id,Decimal>();
        for(AggregateResult ag : aggList){
            //System.debug(ag.get('AccountId'));
            //System.debug(ag.get('sumOfOpportunityAmount'));
            Id accId = (Id)ag.get('AccountId');
            Decimal totalAmount = (Decimal)ag.get('sumOfOpportunityAmount');
            mapOfIdVsAmount.put(accId, totalAmount);
        }
    }
    
    //write down a method to create map of account id vs max amount on opportunity
    public void createMapOfMaxAmOnOpp(){
        List<AggregateResult> aggList = [SELECT AccountId, Max(Amount) oppAmountMax FROM Opportunity GROUP BY AccountId];
        Map<Id,Decimal> mapOfMaxAmOnOpp = new Map<Id,Decimal>();
        for(AggregateResult ag : aggList){
            Id accId = (Id)ag.get('AccountId');
            Decimal maxAmount = (Decimal)ag.get('oppAmountMax');
            mapOfMaxAmOnOpp.put(accId, maxAmount);
            
        }
    }
    
    //write the method to find account id vs count of contact associated to it by using aggregate query.
    public void findAccId(){
        List<AggregateResult> aggList = [SELECT AccountId, Count(Id) countOfContact FROM Contact GROUP By AccountId];
        Map<Id,Integer> mapOfIdVsCountOfCon = new Map<Id,Integer>();
        for(AggregateResult ag : aggList){
            Id accId = (Id)ag.get('AccountId');
            Integer totalContact = (Integer)ag.get('countOfContact');
            mapOfIdVsCountOfCon.put(accId, totalContact);
            System.debug(mapOfIdVsCountOfCon);
        }
        
    }
    
    //write the method to find account id vs count of opportunity associated to it by using aggregate query.
    public void findAccIdVsCountOfOpp(){
        List<AggregateResult> aggList = [SELECT AccountId, Count(Id) countOfOpportunity FROM Opportunity GROUP BY AccountId];
        Map<Id,Integer> mapOfIdVsCountOfOpp = new Map<Id,Integer>();
        for(AggregateResult ag : aggList){
            Id accId = (Id)ag.get('AccountId');
            Integer totalOpportunity = (Integer)ag.get('countOfOpportunity');
            mapOfIdVsCountOfOpp.put(accId, totalOpportunity);
            System.debug(mapOfIdVsCountOfOpp);
        }
    }
    
    //write the method to find client id vs count of Addresses associated to it by using aggregate query.
    public void findClVsCountOfClAdd(){
        List<AggregateResult> aggList = [SELECT count(Id) countOfAddresses, Client__c clientIdAlias FROM Client_Address__c GROUP BY Client__c];
        Map<Id,Integer> mapOfIdVsCountOfAddresses = new  Map<Id,Integer>();
        for(AggregateResult ag : aggList){
            Id ClientId = (Id)ag.get('clientIdAlias');
            Integer totalAddresses = (Integer)ag.get('countOfAddresses');
            mapOfIdVsCountOfAddresses.put(ClientId, totalAddresses);
            System.debug(mapOfIdVsCountOfAddresses);
        }
    }
    /*
     * write down a method that will Query 10 account record store the account id into set use the set to do aggregate query and get the no.
     * of associate contact to it. There is one field Number_of_Contacts_associate_to_account__c on Account update that field with querying no. Of 
      contacts*/
    
    public void conAssociateToAcc(){
        List<Account> accList = [SELECT Id FROM Account LIMIT 10];
        Set<Id> accIds = new Set<Id>();
        for(Account acc : accList){
            accIds.add(acc.Id);
        }
        
        List<AggregateResult> aggList = [SELECT AccountId, Count(Id) countOfContact FROM Contact WHERE AccountId IN: accIds GROUP BY AccountId];
        List<Account> accountListToUpdate = new List<Account>();
        for(AggregateResult ag : aggList){
            Id accId = (Id)ag.get('AccountId');
            Integer totalContact = (Integer)ag.get('countOfContact');
            Account accountRecord = new Account();
            accountRecord.Id = accId;
            accountRecord.Number_of_Contacts_associate_to_account__c =  totalContact;
            accountListToUpdate.add(accountRecord);
            
        }
        if(accountListToUpdate.size() > 0){
            update accountListToUpdate;
        }
        
    }
    

    /*
     * write down a method that will Query 10 account record store the account id into set use the set to do aggregate query and get the no.
     * of associate contact to it. There is one field Number_of_Contacts_associate_to_account__c on Account update that field with querying no. Of 
      contacts do it with inner query*/
    public void countRelContactToAcc(){
        List<Account> accList = [SELECT Id, Name FROM Account LIMIT 10];
        Set<Id>accIdsSet = new Set<Id>();
        for(Account acc : accList){
            accIdsSet.add(acc.Id);
        }
        List<Account> accountList = [SELECT Id, Name,(SELECT Id, Name FROM Contacts) FROM Account WHERE Id In: accIdsSet];
        List<Account> accListToUpdate = new List<Account>();
        for(Account acc1 : accountList){
            Account accountRecord = new Account();
            accountRecord.Id = acc1.Id;
            accountRecord.Number_of_Contacts_associate_to_account__c = acc1.Contacts.size();
            accListToUpdate.add(accountRecord);
        }
        if(accListToUpdate.size() > 0){
            update accListToUpdate;
        }
    }
     /*
     * write down a method that will Query 10 account record store the account id into set use the set to do aggregate query and get the no.
     * of associate opportunity to it. There is one field  on Account update that field with querying no. Of 
      opportunity*/
    public void countRelatedOppwithAcc(){
        List<Account> accList = [SELECT Id, Name FROM Account LIMIT 10];
        Set<Id> accIdsSet = new Set<Id>();
        for(Account acc : accList){
            accIdsSet.add(acc.Id);
        }
        List<AggregateResult> aggList = [SELECT AccountId, Count(Id) countNoOfOpportunity FROM Opportunity WHERE AccountId IN:
                                        accIdsSet GROUP BY AccountId];
        List<Account> accListToUpdate = new List<Account>();
        for(AggregateResult ag : aggList){
            Id accIds = (Id)ag.get('AccountId');
            Integer totalOpportunity = (Integer)ag.get('countNoOfOpportunity');
            Account accountRecord = new Account();
            accountRecord.Id = accIds;
            accountRecord.CountAllOpportunityRelToAcc__c = totalOpportunity;
            accListToUpdate.add(accountRecord);
        }
        if(accListToUpdate.size() > 0){
            update accListToUpdate;
        }
    }
    /*
     * Write down a method that will Query 10 account record store the account id into set use the set to do aggregate query and get sum 
     * of amount on opportunity associate to it. update that field with total sum of amount of opportunity of account object with
      the sum of associated opportunity */
    
    public void oppAssociateToAcc(){
        List<Account> accList = [SELECT Id FROM Account LIMIT 10];
        Set<Id> accIds = new Set<Id>();
        for(Account acc : accList){
            accIds.add(acc.Id);
        }
        
        List<AggregateResult> aggList = [SELECT AccountId, Sum(Amount) totalOppAmount FROM Opportunity WHERE AccountId IN: accIds GROUP BY AccountId];
        List<Account> accountListToUpdate = new List<Account>();
        for(AggregateResult ag : aggList){
            Id accId = (Id)ag.get('AccountId');
            Decimal totalAmount = (Decimal)ag.get('totalOppAmount');
            Account accountRecord = new Account();
            accountRecord.Id = accId;
            accountRecord.SumOfOpportunityAmount__c = totalAmount;
            accountListToUpdate.add(accountRecord);
            
        }
        if(accountListToUpdate.size() > 0){
            update accountListToUpdate;
        }
        
    }
    //Write down the method to query 10 account records calculate the maximum amount of opportunity associate to an 
    //account and update the field on account called max amount of opportunity.
    public void maxOppAmountAssociateToAcc(){
        List<Account> accList = [SELECT Id, Name FROM Account LIMIT 10];
        Set<Id> accIdsSet = new Set<Id>();
        for(Account acc : accList){
            accIdsSet.add(acc.Id);
        }
        List<AggregateResult> aggList = [SELECT AccountId, Max(Amount) maxAmountOnRelatedOpportunity FROM Opportunity WHERE AccountId 
                                         IN: accIdsSet GROUP BY AccountId];
         List<Account> accListToUpdate = new List<Account>();                               
        for(AggregateResult ag : aggList){
            Id accId = (Id)ag.get('AccountId');
            Decimal maxOfOppAmount = (Decimal)ag.get('maxAmountOnRelatedOpportunity');
            Account accountRecord = new Account();
            accountRecord.Id = accId;
            accountRecord.MaxOpportunityAmount__c = maxOfOppAmount;
            accListToUpdate.add(accountRecord);
        }
        if(accListToUpdate.size() > 0){
            update accListToUpdate;
        }
    }
    //Write down a method that will query 10 account record stored the account id into set use the set to do aggregate query
    //to get no. of high priority cases for account and update the field no. of high priority cases on Account object.
    public void updateNoOfCasesAssociateToAccount(){
        List<Account> accList = [SELECT Id, Name FROM Account LIMIT 10];
        Set<Id> accIdsSet = new Set<Id>();
        for(Account acc : accList){
            accIdsSet.add(acc.Id);
        }
        List<AggregateResult> aggList = [SELECT AccountId, Count(Id) countOfCases FROM Case WHERE AccountId IN: accIdsSet GROUP BY AccountId];
        List<Account> accountListToUpdate = new List<Account>();
        for(AggregateResult ag : aggList){
            Id accId = (Id)ag.get('AccountId');
            Integer totalCases = (Integer)ag.get('countOfCases');
            Account accountRecord = new Account();
            accountRecord.Id = accId;
            accountRecord.NumberOfHighPriorityCases__c = totalCases;
            accountListToUpdate.add(accountRecord);
        }
        if(accountListToUpdate.size() > 0){
            update accountListToUpdate;
        }
    }
    
    //count all client addresses related to client using inner query
    public void countRelClAdd(){
        List<Client__c> clientList = [SELECT Id FROM Client__c LIMIT 10];
        Set<Id> clIdsSet = new Set<Id>();
        for(Client__c cl : clientList){
            clIdsSet.add(cl.Id);
        }
        
        List<Client__c> clientList1 = [SELECT Id, Name, (SELECT Id, Name FROM Client_Addresses__r) FROM Client__c WHERE Id IN: clIdsSet];
        List<Client__c> clientListToUpdate = new List<Client__c>();
        for(Client__c c : clientList1){
            Client__c c1 = new Client__c();
            c1.Id = c.Id;
            c1.CountOfClientAddresses__c = c.Client_Addresses__r.size();
            clientListToUpdate.add(c1);
    
        }
        if(clientListToUpdate.size() > 0){
            update clientListToUpdate;
        }
    }
    //count all client addresses related to client using aggregate query
    ///*
    //Client__c → is the API name of the field on Client_Address__c that holds the parent record’s Id (the master-detail or lookup reference).
    //clientIdAlias → is your alias, i.e., a name you choose to refer to Client__c in Apex.
    //*/


    public void countClAddressesRelToClient(){
        List<Client__c> clientList = [SELECT Id, Name FROM Client__c LIMIT 10];
        Set<Id> clientIdsSet = new Set<Id>();
        for(Client__c cl : clientList){
            clientIdsSet.add(cl.Id);
        }
        
        List<AggregateResult> aggList = [SELECT count(Id) countOfAddresses, Client__c clientIdAlias FROM Client_Address__c 
                                          WHERE Client__c IN: clientIdsSet GROUP BY Client__c];
        List<Client__c> clListToUpdate = new List<Client__c>();
        for(AggregateResult ag : aggList){
            Id clientId = (Id)ag.get('clientIdAlias');
            Integer totalAddresses = (Integer)ag.get('countOfAddresses');
            Client__c clientRecord = new Client__c();
            clientRecord.Id = clientId;
            clientRecord.CountOfClientAddresses__c = totalAddresses;
            clListToUpdate.add(clientRecord);
        }
        if(clListToUpdate.size() > 0){
            update clListToUpdate;
        }
    }
    //Write down a method query the contact Where Account is not present if associated account is not there assign a default account to it
    public void createDefaultAcc(){
        List<Contact> conList = [SELECT Id, AccountId, LastName FROM Contact LIMIT 10];
        List<Account> accListToInsert = new List<Account>();
        for(Contact con : conList){
            if(con.AccountId == null){
                Account acc = new Account();
                acc.Name = con.LastName;
                accListToInsert.add(acc);
            }
        }
        if(accListToInsert.size() > 0){
            insert accListToInsert;
        }
        // Assign new account to same contact list
    for(Integer i = 0; i < conList.size(); i++){
        conList[i].AccountId = accListToInsert[i].Id;
    }

    update conList; // updating same list
}
    //write down a method query 10 job record stored job Id into set use the set to query count of pass candidate and count of
    //failed candidate and update the field on job object no. of pass candidate and no.of fail candidate 
    //we have 2 object job and candidate where job related to candidate with jobId
    /*
    public void countPassAndFailCandidate(){
        List<Job__c> jobList = [SELECT Id FROM Job__c LIMIT 10];
        Set<Id> jobIdSet = new Set<Id>();
        for(Job__c job : jobList){
            jobIdSet.add(job.Id);
        }
        List<AggregateResult> aggList1 = [SELECT jobId, count(Id) countOfPassCand FROM Candidate__c WHERE (jobId IN: jobIdSet 
                                       AND status = 'Pass') GROUP BY jobId];
           List<Job__c> jobListToUpdate1 = new List<Job__c>();                                                                                   
          for(AggregateResult ag1 : aggList1){
                                                                                                                          
                Id jId = (Id) ag1.get('jobId');
                Integer tpotalPasscand = (Integer)ag1.get('countOfPassCand');
                Job__c jRecord1 = new Job__c();
                jRecord1.Id = jId;
                jRecord1.No_of_Pass_Candi__c = tpotalPasscand;
                jobListToUpdate1.add(jRecord1);
          } 
            if(jobListToUpdate1.size() > 0) {
                Update jobListTodate1;                                                                                              
              }   
                                                                                                           
         List<AggregateResult> aggList2 = [SELECT jobId, count(Id) countOfFailCand FROM Candidate__c WHERE (jobId IN: jobIdSet 
                                       AND status = 'Fail') GROUP BY jobId];
           List<Job__c> jobListToUpdate = new List<Job__c>();                                                                                   
          for(AggregateResult ag2 : aggList2){
                                                                                                                          
                Id jId = (Id) ag2.get('jobId');
                Integer tpotalPasscand = (Integer)ag2.get('countOfPassCand');
                Job__c jRecord2 = new Job__c();
                jRecord2.Id = jId;
                jRecord2.No_of_Pass_Candi__c = tpotalPasscand;
                jobListToUpdate2.add(jRecord2);
          } 
            if(jobListToUpdate2.size() > 0) {
                Update jobListTodate2;                                                                                              
              }                                                                                                                                                                                                           
                                                                                                          
        
    }
    */
    //write down a method query 10 job record stored job Id into set use the set to query count of pass candidate and count of
    //failed candidate and update the field on job object no. of pass candidate and no.of fail candidate 
    //we have 2 object job and candidate where job related to candidate with jobId solve using Inner query
    /*
    public void counJobtRelCand(){
        List<Job__c> jobList = [SELECET Id FROM Job__c LIMIT 10];
        Set<Id> jobIdSet = new Set<Id>();
        for(Job__c job : jobList){
            jobIdSet.add(job.Id);
        }
        List<Job__c> jList1 = [SELECT Id,No_of_Pass_Candi__c, (SELECT Id, status, jobId FROM Candidate__c WHERE Status = 'Pass') 
                              FROM Job__c WHERE Id IN: jobIdSet];
        List<Job__c> jobListToUpdate1 = new List<Job__c>();
        for(Job__c j1 : jList1){
            Job__c jRecord1 = new Job__c();
            jRecord1.Id = j1.Id;jobListToUpdate
            jRecord1.No_of_Pass_Candi__c = j1.Cadidates__r.size();
            jobListToUpdate1.add(jRecord1);
        }
        if(jobListToUpdate1.size() > 0){
            update jobListToUpdate1;
        }
        List<Job__c> jList2 = [SELECT Id,No_of_Fail_Candi__c, (SELECT Id, status, jobId FROM Candidate__c WHERE Status = 'Fail') 
                              FROM Job__c WHERE Id IN: jobIdSet];
        List<Job__c> jobListToUpdate2 = new List<Job__c>();
        for(Job__c j2 : jList1){
            Job__c jRecord2 = new Job__c();
            jRecord2.Id = j2.Id;jobListToUpdate
            jRecord2.No_of_Pass_Candi__c = j2.Cadidates__r.size();
            jobListToUpdate2.add(jRecord2);
        }
        if(jobListToUpdate2.size() > 0){
            update jobListToUpdate2;
        }
    }
 
    

    
    */
    //write down the method that updates the minimum balance 500 .pass Id to as parameter query that account and update the field.
    public void updateMinBalance(Id accId){
        List<Account> accList = [SELECT Id, Name FROM Account WHERE Id =: accId LIMIT 10];
       
        for(Account acc : accList){
            if(acc.Min_Balance__c < 500){
                acc.Min_Balance__c = 500;
               
            }
        }
        if(accList.size() > 0){
            update accList;
        }
        
    }
    public void countRelContactToAcc1(){
        List<Account> accList = [SELECT Id, Name FROM Account LIMIT 10];
        Set<Id> accIdSet = new Set<Id>();
        for(Account acc : accList){
            accIdSet.add(acc.Id);
        }
        List<AggregateResult> aggList = [SELECT AccountId, count(Id) countOfContact FROM Contact WHERE AccountId In: accIdSet
                                        GROUP BY AccountId];
        List<Account> accListToUpdate = new List<Account>();
        for(AggregateResult ag: aggList){
            Id accId = (Id)ag.get('AccountId');
            Integer totalContact = (Integer)ag.get('countOfContact');
            Account accountRecord = new Account();
            accountRecord.Id = accId;
            accountRecord.Number_of_Contacts_associate_to_account__c = totalContact;
            accListToUpdate.add(accountRecord);
        }
        if(accListToUpdate.size() > 0){
            update accListToUpdate;
        }
    }
    
    public void countRelConUsingInnerQuery(){
        List<Account> accList = [SELECT Id, Name FROM Account LIMIT 10];
        Set<Id> accIdSet = new Set<Id>();
        for(Account acc : accList){
            accIdSet.add(acc.Id);
        }
        
        List<Account> accountList = [SELECT Id, Name, (SELECT Id, AccountId FROM Contacts	) FROM Account WHERE Id IN: accIdSet];
        List<Account> accListToUpdate = new List<Account>();
        for(Account acc1 : accountList){
            Account acc2 = new Account();
            acc2.Id = acc1.Id;
            acc2.Number_of_Contacts_associate_to_account__c = acc1.Contacts.size();
            accListToUpdate.add(acc2);
        }
        if(accListToUpdate.size() > 0){
            update accListToUpdate;
        }
    }

    
    
    
    

    
    
   
    
    
        
}