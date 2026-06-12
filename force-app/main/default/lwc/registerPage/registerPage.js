import { LightningElement } from 'lwc';

export default class RegisterPage extends LightningElement {
    password;
    username;
    confirmPassword;
    handleRegisterClick(){
        console.log('Register clicked');

        this.dispatchEvent(new CustomEvent('backtologin', {detail: true}));
    }

    handleRegisterPageUsernameClick(){
        let username = this.template.querySelector('.username');
        if(this.username.length >= 8){
            username.setCustomValidity('');
            username.reportValidity();
        }else{
            username.setCustomValidity('username must be at least 8 characters');
            username.reportValidity();
            return;
        }

    }

    handleRegisterPagePassowrdClick(event){
        this.password = event.target.value;

    }

    
    handleRegisterPageConfirmPassowrdClick(){
        let confirmPassword = this.template.querySelector('.confirmPassword');
        if(this.password == this.confirmPassword){
        confirmPassword.setCustomValidity('');
        } else {
          confirmPassword.setCustomValidity('password does not match');  
        }
        confirmPassword.reportValidity();

    }
    
}