import { LightningElement } from 'lwc';

export default class ContactComponent extends LightningElement {
    phoneNumber;
    email;
    handlePhoneChange(event){
        this.phoneNumber = event.target.value;
        console.log('phone number is '+this.phoneNumber)

    }
    handleEmailChange(event){
        this.email = event.target.value;
        console.log('email is '+this.email)

    }
}