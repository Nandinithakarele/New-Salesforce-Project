public class ContactQueueable implements System.Queueable{
    
    public Integer noOfContacts;
    public List<Account> accountList;
    public ContactQueueable(Integer noOfContacts, List<Account> accountList){
        this.noOfContacts = noOfContacts;
        this.accountList = accountList;
        
    }
    public void execute(System.QueueableContext ctx){
        System.debug('Child queuable executed');
        Integer no = this.noOfContacts;
        System.debug(no);
    }

}