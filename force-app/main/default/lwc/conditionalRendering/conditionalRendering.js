import { LightningElement } from 'lwc';

export default class ConditionalRendering extends LightningElement {
    showFlag = false;
    handleClick(){
        this.showFlag = !this.showFlag;
    }
    handleClick(){
        if(this.showFlag == true){
        this.showFlag = false;
    }
    else{
        this.showFlag = true;
    }
    }


}