import { LightningElement, wire } from 'lwc';
import myMessageChannel from "@salesforce/messageChannel/myMessageChannel__c";
import {
  subscribe,
  unsubscribe,
  APPLICATION_SCOPE,
  MessageContext,
} from "lightning/messageService";
export default class LmsReceiver extends LightningElement {
    receivedMessage;


    @wire(MessageContext)
    messageContext;

    subscription;

    connectedCallback(){
        this.subscription = subscribe(
            this.messageContext, 
            myMessageChannel,
            (message) => 
                this.handleMessage(message), 
            {scope: APPLICATION_SCOPE}
        )}
    

    handleMessage(message){
    
        this.receivedMessage = message.msg;
    }

    disconnectedCallback(){
        unsubscribe(this.subscription);
    }
}