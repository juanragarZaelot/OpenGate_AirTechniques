import { LightningElement,track } from 'lwc';
import { loadStyle } from 'lightning/platformResourceLoader';
import AirTechniquesStyles from '@salesforce/resourceUrl/AirTechniquesStyles';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import processSave from '@salesforce/apex/RegistrationFormController.processRegistration';
import validateAddress from '@salesforce/apex/RegistrationFormController.validateAddress';

export default class RegistrationForm extends LightningElement {

    @track sent = false;
    @track hideRegisterButton = true;
    @track showMessagePlaceId = false;
    @track className ='slds-notify slds-notify_toast';
    @track message;
    @track record = {firstName: '',
                    lastName: '',
                    accountName: '',
                    street: '',
                    city:'',
                    province:'',
                    postalCode: '',
                    country:'',
                    email:'',
                    phone:'',
                    placeId: null
                    };
    initialized = false;

    /**
    * @author Juan Ramirez
    * @date 2022/07/26
    * @description system function fired when the components load
    * @param
    * @return 
    */
     renderedCallback(){
        if(this.initialized){
            return;
        }
        console.log('[renderedCallback] start');
        this.initialized=true;
        this.hideRegisterButton = true;

        Promise.all([
            loadStyle(this, AirTechniquesStyles ),
        ])
        .then(() => {
                    })
        .catch(error => {
        // eslint-disable-next-line no-console
        console.error({
            message: 'Error occured on load',
        error
                    });
        });
    }

    /**
    * @author Juan Ramirez
    * @date 2022/07/26
    * @description to verify if all information has been filled out
    * @param
    * @return {boolean} 
    */
	get isDisabled(){
        let aux = JSON.parse(JSON.stringify(this.record));
        let disabled = false;
        for(let row in aux){
            //shop will be "1", "2"...n
            if (row != 'placeId' && (!aux.hasOwnProperty(row) || aux[row].length === 0 || !aux[row].trim())){
                disabled = true;
            }
         }
        const obj=this.template.querySelector('.required-field');
		let emailValid=false;
		if(obj!=undefined && obj!=null){
			emailValid=obj.checkValidity();
            disabled = disabled == false ? !emailValid : disabled;
		}
		 
            
		return disabled;
    }

    /**
    * @author Juan Ramirez
    * @date 2022/07/26
    * @description to verify if all information has been filled out
    * @param
    * @return {boolean} 
    */
	get isDisabledSave(){
        let aux = JSON.parse(JSON.stringify(this.record));
        let disabled = false;
        for(let row in aux){
            //shop will be "1", "2"...n
            if (!aux.hasOwnProperty(row) || (aux[row] != null && aux[row].length === 0) || (aux[row] != null && !aux[row].trim()))
                disabled = true;
         }
        const obj=this.template.querySelector('.required-field');
		let emailValid=false;
		if(obj!=undefined && obj!=null){
			emailValid=obj.checkValidity();
            disabled = disabled == false ? !emailValid : disabled;
		}

		return (disabled || this.hideRegisterButton);
    }

    /**
    * @author Juan Ramirez
    * @date 2022/08/01
    * @description to verify if has a valid place id
    * @param
    * @return {boolean} 
    */
	get hasPlaceId(){
        return this.record.placeId != null && this.record.placeId != '' ? true : false;
    }

    /**
    * @author Juan Ramirez
    * @date 2022/07/26
    * @description assign First Name (returned from lighting-input) to json to send 
    * @param
    * @return 
    */
     handleChangeFirstName(event) {
        this.record.firstName = event.detail.value;
    }

    /**
    * @author Juan Ramirez
    * @date 2022/07/26
    * @description assign Last Name (returned from lighting-input) to json to send 
    * @param
    * @return 
    */
     handleChangeLastName(event) {
        this.record.lastName = event.detail.value;
    }

    /**
    * @author Juan Ramirez
    * @date 2022/07/27
    * @description assign Account Name (returned from lighting-combobox) to json to send 
    * @param
    * @return 
    */
     handleChangeAccountName(event) {
        this.record.accountName = event.detail.value;
    }

    /**
    * @author Juan Ramirez
    * @date 2022/07/26
    * @description assign Street, City, Country, State/Province, Zip/PostalCode (returned from lighting-input-address) to json to send 
    * @param
    * @return 
    */
     handleChangeAddress(event) {
        this.record.street = event.detail.street;
        this.record.city = event.detail.city;
        this.record.province = event.detail.province;
        this.record.postalCode = event.detail.postalCode;
        this.record.country = event.detail.country;
    }

    /**
    * @author Juan Ramirez
    * @date 2022/07/26
    * @description assign Email (returned from lighting-input) to json to send 
    * @param
    * @return 
    */
     handleChangeEmail(event) {
        this.record.email = event.detail.value;
    }
    
    /**
    * @author Juan Ramirez
    * @date 2022/07/26
    * @description assign Phone (returned from lighting-input) to json to send 
    * @param
    * @return 
    */
     handleChangePhone(event) {
        this.record.phone = event.detail.value;
    }

    /**
    * @author Juan Ramirez
    * @date 2022/07/26
    * @description method to handle return to home page
    * @param
    * @return 
    */
     handleCancel(event) {
        this.template.querySelector('c-navigate-to-component').navigateToCommunityPage('home',{});
    }

    /**
    * @author Juan Ramirez
    * @date 2022/07/26
    * @description method to handle validate address in the google service
    * @param
    * @return 
    */
     handleValidateAddress(event) {
        console.log('[RegistrationForm.handleValidateAddress] this.record: ' + JSON.stringify(this.record));
        this.sent=true;
        validateAddress({recordForm: JSON.stringify(this.record)}).then(result => {
			
			this.sent=false;
			
			//debugger;
			this.className = 'slds-notify slds-notify_toast';
            this.showMessagePlaceId = false;
			if(result.typeMessage!='Error'){
			    this.hideRegisterButton = false;
                this.record.placeId = result.placeId;
                this.showMessagePlaceId = true;
                if(result.accountId == null || result.accountId == undefined){
                    this.className +=' slds-theme_success';
                    this.message = 'Click Register to create a new account for this business';
                }
                else {
                    this.className +=' slds-theme_warning';
                    this.message = 'This Address is already on our system, click Register to create a new registration for this business';
                }
                //this.showNotification(result.typeMessage, 'There is Place Id related to this address');

            } else{
                this.showNotification(result.typeMessage,result.message);
            }
			
		}).catch(error => {
				console.log('error: '+error);
				this.sent=false;
		});
    }

    /**
    * @author Juan Ramirez
    * @date 2022/07/27
    * @description process save the account information
    * @param
    * @return 
    */
	processSave(event){
		console.log('[RegistrationForm.processSave] save value');
		this.sent=true;
        processSave({recordForm: JSON.stringify(this.record)}).then(result => {
			
			this.sent=false;
			
			//debugger;
			this.showNotification(result.typeMessage,result.message);
			if(result.typeMessage!='Error'){
                this.clearRecord();
            } else{
                
            }
			
		}).catch(error => {
				console.log('error: '+error);
				this.sent=false;
		});
    }

    /**
    * @author Juan Ramirez
    * @date 2022/07/27
    * @description show notifications with toast standard component
    * @param
    * @return 
    */
     showNotification(type,message) {

        const event = new ShowToastEvent({
           
            message: message,
            variant: type
        });
        this.dispatchEvent(event);

    }
    /**
    * @author Juan Ramirez
    * @date 2022/08/02
    * @description process to clear record object
    * @param
    * @return 
    */
	clearRecord(){
        
        for(let row in this.record){
            //shop will be "1", "2"...n
            this.record[row] = row == 'placeId' ? null : '';
            
         }
         this.hideRegisterButton = true;
         this.showMessagePlaceId = false;
         this.className = 'slds-notify slds-notify_toast';
    }
    /**
    * @author Juan Ramirez
    * @date 2022/08/02
    * @description method to handle clear all fields of the form
    * @param
    * @return 
    */
     handleClear(event) {
        this.clearRecord();
    }
}