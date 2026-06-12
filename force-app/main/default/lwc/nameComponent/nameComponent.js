import { LightningElement } from 'lwc';

export default class NameComponent extends LightningElement {
    firstName;
    middleName;
    lastName;
    handleFirstNameChange(event){
        this.firstName = event.target.value;
        console.log('first name is '+this.firstName)

    }
    handleMiddleNameChange(event){
        this.middleName = event.target.value;
        console.log('middle name is '+this.middleName)

    }
    handleLastNameChange(event){
        this.lastName = event.target.value;
        console.log('last name is '+this.lastName)

    }

}