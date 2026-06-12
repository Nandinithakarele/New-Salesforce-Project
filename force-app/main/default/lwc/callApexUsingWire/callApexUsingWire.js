import { LightningElement, wire } from 'lwc';
import getAllContacts from '@salesforce/apex/ContactController.getContactRecords';
const columns = [
    {label:'Name',fieldName:'Name'},
    {label:'Phone',fieldName:'Phone'},
    {label:'Email',fieldName:'Email'}
];

export default class CallApexUsingWire extends LightningElement {
    contacts=[];
    input = '';
    handleSearch(event){
        this.input = event.target.value;

    }
     
    /****wire as property****/
    /*
    @wire(getAllContacts,{searchName:'$input'})
    contactRecords;
    */

    @wire(getAllContacts,{searchName:'$input'})
    contactRecords(result){
        if(result.data){
            this.contacts = result.data;
            console.log('result :' + JSON.stringify(this.contacts));

        }
        if(result.error){
            console.log('error :' + error)

        }
    }
    /*
    contactRecords({data,error}){
        if(data){
            console.log('data is '+JSON.stringify(data))
        }
        if(error){
            console.log('error is '+JSON.stringify(error))
    }
    */
}