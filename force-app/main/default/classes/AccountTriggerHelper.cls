public class AccountTriggerHelper {
    
    public static void updateAccountShippingAddress(List<Account> accList){
        //1.1)when account is created set value of industry to education and if discription of account is blank then show 'Description was blank'
        for(Account acc : accList){
            acc.Industry = 'Education';
            if(acc.Description == null){
                acc.Description = 'Description was blank';
            }
        
        
        //1.2)when any account create or updated set the value of billing address to shipping address
        //Street,City,State,PostalCode,Country
        //ShippingStreet ---> standard field in account
        //1.3)when any account create or updated set the value of billing address to shipping address
        //now we need to only update billing address with shii=pping address when shipping address is null 
        
        
        acc.ShippingStreet = acc.BillingStreet;
        acc.ShippingCity = acc.BillingCity;
        acc.ShippingState = acc.BillingState;
        acc.ShippingPostalCode = acc.BillingPostalCode;
        acc.ShippingCountry = acc.BillingCountry;
        }
        
    }
    
    public static void checkDuplicateRecordsFromAccount(List<Account> newRecords){
        Set<String> nameAccountSet = new Set<String>();
        Set<String> ratingAccountSet = new Set<String>();
        
        for(Account acc: newRecords){
            nameAccountSet.add(acc.Name);
            ratingAccountSet.add(acc.Rating);
        }
        
        List<Account> ExingingAccountList = [SELECT ID, NAME, RATING FROM Account 
                                      WHERE NAME IN: nameAccountSet AND
                                      RATING IN :ratingAccountSet AND ID NOT IN :newRecords];
        
        
        for(Account acc : newRecords){
            for(Account exec : ExingingAccountList){
                if(acc.Name == exec.Name && acc.Rating == exec.Rating){
                    acc.addError('Already Duplicate account with name and rating');
                    acc.Name.addError('Already Duplicate account with name');
                    acc.Rating.addError('Already Duplicate account with rating');
                }
                
            }
            
        }
        
        
    }

}