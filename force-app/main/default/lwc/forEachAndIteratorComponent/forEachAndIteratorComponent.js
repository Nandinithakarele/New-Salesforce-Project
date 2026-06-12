import { LightningElement, track } from 'lwc';

export default class ForEachAndIteratorComponent extends LightningElement {
    @track users = [
        {name: 'Jerry', email: 'nandinithakarele@gmail.com'},
        {name: 'Tom', email: 'nandini1thakarele@gmail.com'},
        {name: 'TomJerry', email: 'nandini2thakarele@gmail.com'}
    ];
}