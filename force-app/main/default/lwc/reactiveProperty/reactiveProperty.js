import { LightningElement } from 'lwc';
let firstName;// no error
export default class ReactiveProperty extends LightningElement {
    //we can not use let keyword here let firstName error inside class already it takes as a variable let firstName;
    firstName = 'Nandini';
}