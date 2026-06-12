public class ApexClass {
    
    private Integer noOfEmployees;
    
    public String name { get; set; }
    
    public Integer getEmployee(){
        return this.noOfEmployees;
    }
    
    public void setEmployee(Integer noOfEmployees){
        this.noOfEmployees = noOfEmployees;
        
    }

}