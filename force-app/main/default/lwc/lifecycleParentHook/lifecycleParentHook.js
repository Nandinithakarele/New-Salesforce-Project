import { LightningElement } from 'lwc';

export default class LifecycleParentHook extends LightningElement {
    flag = false;
    
    constructor(){
        super();
        this.flag = true;
        console.log('constructor called on Parent');
    }
    connectedCallback(){
        console.log('connected callback called on Parent');
    }
    renderedCallback(){
        console.log('renderedCallback called on Parent');
    }
    handleClick(){
        console.log('button clicked');
        this.flag = !this.flag;

    }
    
    disconnectedCallback(){
        console.log('disconnectedCallback called on Parent');
    }
    errorCallback(error, stack){
        console.log('errorCallback called on Parent');
        console.log('error on Parent' + error);
        console.log('stack on Parent' + stack);

    }
    handleChildClick(event){
        this.flag = event.detail;
    }
}