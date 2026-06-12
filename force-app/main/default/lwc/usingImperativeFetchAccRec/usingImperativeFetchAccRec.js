import { LightningElement } from 'lwc';
import getAccountRecords from '@salesforce/apex/ContactController.getAccountRecords';

export default class UsingImperativeFetchAccRec extends LightningElement {

    accName = '';

    handleChange(event) {
        this.accName = event.target.value;
    }
    fetchAccountRecords() {
        getAccountRecords({accountName: this.accName})
            .then(result => {
                console.log('result: ' + JSON.stringify(result));
            })
            .catch(error => {
                console.log('error: ' + JSON.stringify(error));
            });
    }


}