import { LightningElement } from 'lwc';

export default class ConditionalRenderingVersion2 extends LightningElement {
    /*showFlag = true;
    handleClick() {
        this.showFlag = !this.showFlag;
    }
        */
    showJerry = true;
    showTom = true;
    
    handleClick() {
        this.showJerry = !this.showJerry;
        this.showTom = !this.showTom;
        
    }
}