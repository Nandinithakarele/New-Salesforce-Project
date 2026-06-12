//we can not access method variable in anonymous code that will be accessible within curly braces
//we can only access class variable using dot notation with instance variable

public class Calculator {
    //whatever values we are defining inside class that will automatically assigned while calling default constructor
    //and default constucor already we are making while making instance of class
    /*(1)
     // Calculator c = new Calculator();
     // c.addition(4, 3);
    public Integer num1;
    public Integer num2;
    public Integer sum;
    
    public Integer addition(Integer num1, Integer num2){
        Integer sum = num1 + num2; 
        return sum;
         
    }
    */
    /*(2)
     // Calculator c = new Calculator();
     // c.addition(4, 3);
    public void addition(Integer num1, Integer num2){
        Integer sum = num1 + num2;
        System.debug(sum);
    }
    */
    public void addition(Integer num1 , Integer num2){
        Integer sum = num1 + num2;
        System.debug(sum);
        //Calculator c = new Calculator();
        //c.addition(4, 5);
        
        
    }
    public Integer addition2(Integer a, Integer b){
        Integer sum = a + b;
        return sum;
        //System.debug(sum);
        
    }
    public void Calculate(Integer n1, Integer n2, String operation){
        Integer sum;
        if(operation == 'add'){
            sum = n1 + n2;
        }else if(operation == 'sub'){
            sum = n1 - n2;
        }else if(operation == 'mul'){
            sum = n1 - n2;
        }else{
            sum = n1 / n2;
        }
        System.debug(sum);
        
    }
    //Calculator c = new Calculator();
    //c.Calculate(4, 2, 'sub');
    
    public void createFullName(String fName, String lName){
        String fullName = fName + ' '+ lName;
        System.debug(fullName);
        
    }
    //Calculator c = new Calculator();
    //c.createFullName('Nandini', 'Thakarele');
    public void createAccount(String accName){
        Account acc = new Account();
        acc.Name = accName;
        insert acc;
        System.debug(acc.Name);
    }
    //Calculator c = new Calculator();

   //c.createAccount('Account1');
   
        
    
     
     


}