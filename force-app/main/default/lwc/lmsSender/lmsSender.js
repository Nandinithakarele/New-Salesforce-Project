import { LightningElement, wire} from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import myMessageChannel from "@salesforce/messageChannel/myMessageChannel__c";

export default class LmsSender extends LightningElement {
    input;

    handleChange(event){
        this.input = event.target.value;
        publish(this.messageContext, myMessageChannel, {message: this.input});

    }

    @wire(MessageContext)
    messageContext;


}