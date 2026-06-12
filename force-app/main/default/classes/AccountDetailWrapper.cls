/*
AccountDetailWrapper wrapper = new AccountDetailWrapper();
wrapper.accountName = 'Account Test';
wrapper.balance = 89.767;
wrapper.accountNum = 123;
wrapper.obj=Date.newInstance(2025, 08, 09);
System.debug(wrapper);
*/




public class AccountDetailWrapper {
    public String accountName;
    public Decimal balance;
    public Integer accountNum;
    public Boolean isActive;
    public Date obj;
    List<Contact> contactList;

}