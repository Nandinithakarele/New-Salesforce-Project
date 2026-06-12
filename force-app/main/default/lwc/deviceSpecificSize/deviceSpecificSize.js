import { LightningElement } from 'lwc';

export default class DeviceSpecificSize extends LightningElement {
    handleClick(){
        alert('Button Clicked');
        console.log('button clicked');
    }
    handleChange(event){
        //target is lightning-input 
        //we are giving as input in output
        console.log(event.target.value);

    }
}