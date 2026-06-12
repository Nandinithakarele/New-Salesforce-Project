public class StudentControllerWrapper {
    /*
     * Wrapper Class as a output
     StudentControllerWrapper wrap = new StudentControllerWrapper();
     System.debug(wrap.studentDetail('Account Test', 3560.78, 56, true, Date.newInstance(2035, 8,9)));
     or System.debug(wrap);
   */
    public AccountDetailWrapper studentDetail(String accountName, Decimal balance, Integer accountNum, Boolean isActive, Date obj){
        AccountDetailWrapper studentWrap = new AccountDetailWrapper();
        studentWrap.accountName = accountName;
        studentWrap.balance = balance;
        studentWrap.accountNum = accountNum;   
        studentWrap.isActive = isActive;
        return studentWrap;
        
    }
    
    public void getStudentDetail(AccountDetailWrapper studentWrap){
        System.debug(studentWrap.accountName);
        System.debug(studentWrap.accountNum);
        System.debug(studentWrap.balance);
        System.debug(studentWrap.isActive);
    }
    /*
     * StudentControllerWrapper wrap = new StudentControllerWrapper();
AccountDetailWrapper studentWrap = wrap.studentDetail('Account Test', 3560.78, 56, true, Date.newInstance(2035, 8,9));
wrap.getStudentDetail(studentWrap);
*/

}