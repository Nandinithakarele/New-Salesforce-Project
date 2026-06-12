import { LightningElement } from 'lwc';

export default class LifecycleChildHook extends LightningElement {
    flag = false;
    
    constructor(){
        super();
        this.flag = true;
        console.log('constructor called on child');
    }
    connectedCallback(){
        console.log('connected callback called on child');
    }
    renderedCallback(){
        console.log('renderedCallback called on child');
    }
    handleClick(){
        console.log('button clicked');
        this.flag = !this.flag;
        this.dispatchEvent(new CustomEvent('childclick',{detail:this.flag}));

    }
    disconnectedCallback(){
        console.log('disconnectedCallback called on child');
    }
    errorCallback(error, stack){
        console.log('errorCallback called on child');
        console.log('error on child' + error);
        console.log('stack on child' + stack);

    }
}