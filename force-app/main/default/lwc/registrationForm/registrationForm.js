import { LightningElement,track } from 'lwc';
import { loadStyle } from 'lightning/platformResourceLoader';
import AirTechniquesStyles from '@salesforce/resourceUrl/AirTechniquesStyles';

export default class RegistrationForm extends LightningElement {

    @track sent = false;
    @track record = {};
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

        this.initialized=true;

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
    * @description method use to populate practice options  
    * @param
    * @return 
    */
    get optionsPractice() {
        return [
            { label: '--None--', value: 'None' },
        ];
    }

    /**
    * @author Juan Ramirez
    * @date 2022/07/26
    * @description to verify if all information has been filled out
    * @param
    * @return {boolean} 
    */
	get isAddOperation(){
		return false;
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
    * @date 2022/07/26
    * @description assign Practice (returned from lighting-combobox) to json to send 
    * @param
    * @return 
    */
     handleChangePractice(event) {
        this.record.practice = event.detail.value;
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
    }
}