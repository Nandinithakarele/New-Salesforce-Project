import { LightningElement } from 'lwc';

import fetchUserDetails from '@salesforce/apex/LoginController.fetchUserDetails';

export default class LoginPage extends LightningElement {
    username;
    password;
    showLoginPage = true;
    handleLoginRegisterClick(){
       this.showLoginPage = false;
    }

    handleBackToLogin(event){
        console.log('Parent received event');
        console.log(event.detail);
        this.showLoginPage = event.detail;

    }
    handleLoginUsernameChange(event){
        this.username = event.target.value;
    }

    handleLoginPasswordChange(event){
        this.password = event.target.value;
    }

    handleLoginClick(){
        fetchUserDetails({username: this.username,  password: this.password})
        .then(result => {
            console.log('userfound' + result );
        })
        .catch(error => {
            console.error(error);
        })
        console.log('Hi');

    }
}