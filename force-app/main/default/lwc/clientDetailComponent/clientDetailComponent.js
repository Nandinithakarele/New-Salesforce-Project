import { LightningElement } from 'lwc';
import getContacts from '@salesforce/apex/ContactController.getContactsUsingImperative';

export default class ClientDetailComponent extends LightningElement {
    firstName='';
    middleName='';
    lastName='';
    Phone='';
    Email='';
    handleFnameChangeEvent(event){
        this.firstName = event.detail.firstName;
        console.log('first name is '+this.firstName)
    }
    handleMnameChangeEvent(event){
        this.middleName = event.detail.middleName;
        console.log('middle name is '+this.middleName)
    }
    handleLnameChangeEvent(event){
        this.lastName = event.detail.lastName;
        console.log('last name is '+this.lastName)
    }
    handlePhoneChangeEvent(event){
        this.Phone = event.detail.Phone;
        console.log('Phone is '+this.Phone)
    }
    handleEmailChangeEvent(event){
        this.Email = event.detail.Email;
        console.log('Email is '+this.Email)
    }
     handleClick(){
        console.log(this.firstName);
        console.log(this.middleName);
        console.log(this.lastName);
        console.log(this.Phone);
        console.log(this.Email);

        getContacts({firstName:this.firstName, lastName: this.lastName, phone: this.Phone, email: this.Email})
        .then(result => {
            console.log('result :' + JSON.stringify(result));

        })
        .catch(error => {
            console.log(JSON.stringify(error));

        })

     }
    


}