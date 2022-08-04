import { LightningElement, api } from 'lwc';

export default class AlertMessage extends LightningElement {
    @api className;
    @api message;
}