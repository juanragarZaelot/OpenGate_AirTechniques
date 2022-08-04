/* **************************************************************************
 * Class: RegistrationFormController
 * Created by Juan Ramirez, July 27/2022
 *
 * Purpose/Methods:
 * - class to manage all processes to register a account, contact and user
 * 
 *
 * Unit Test: RegistrationFormControllerTest
 *
 * Modifications:
 * - {DevName}, {MM/DD/YYYY} - {Description of changes made post deployment to client}
 *
 ************************************************************************** */
public class RegistrationFormController {

    /**
     * @author Juan Ramirez
     * @date 2022/07/27
     * @description process to create account, contact and user
	 * @param body 
     * @return String 
     */
    @AuraEnabled
    public static MessageResponse processRegistration(String recordForm) {

        MessageResponse response = new MessageResponse();
        try {
            AccountInformationWrapper record = (AccountInformationWrapper)JSON.deserialize(recordForm, AccountInformationWrapper.class);
            System.debug('[RegistrationFormController.processRegistration] recordForm: ' + record);

            Id accountId = AccountHelper.getAccountRelatedToThePlaceId(record.placeId);
            if (accountId == null) {
                Account acc = AccountHelper.getAccount(record.accountName);
                if (acc == null){
                    acc = AccountHelper.createAccount(record);
                }
                accountId = acc.Id;
            }

            Contact con = ContactHelper.getContact(record.Email.trim());
            if(con == null){
                con = ContactHelper.createContact(record, accountId);
            }
            User us = UserHelper.getUserByEmail(record.Email.trim());
            if(us == null){
                us = UserHelper.createUser(record, con.Id, accountId);
                System.debug('[RegistrationFormController.processRegistration] Account: ' + accountId);
                System.debug('[RegistrationFormController.processRegistration] Contact: ' + con);
                System.debug('[RegistrationFormController.processRegistration] User: ' + us);
                System.debug('[RegistrationFormController.processRegistration] recordForm: ' + record);
                response.typeMessage = 'Success';
                response.message = 'Account Created Successfuly';
            } else{
                response.typeMessage = 'Error';
                response.message = 'The user with email ' + record.Email.trim() + ' already exist';
            }

            //insert us; //to discuss w Juan
            

        } catch(Exception e) {

            response.typeMessage = 'Error';
            response.message = e.getMessage();
            System.debug('[RegistrationFormController.processRegistration] Error: ' + e.getMessage() + '\n' + e.getStackTraceString());

        }
        return response;
    }

    /**
     * @author Juan Ramirez
     * @date 2022/08/01
     * @description process validate address with Google Places API
	 * @param body 
     * @return String 
     */
    @AuraEnabled
    public static MessageResponse validateAddress(String recordForm) {

        MessageResponse response = new MessageResponse();
        try {
            AccountInformationWrapper record = (AccountInformationWrapper)JSON.deserialize(recordForm, AccountInformationWrapper.class);
            String address = record.street + ' ' + record.city + ' ' + record.province + ' ' + record.postalCode + ' ' + record.country;
            GooglePlaceResponse ApiResponse = AccountHelper.getGooglePlaceFinderId(address);
            if(ApiResponse.candidates.size()>0){
                response.typeMessage = 'Success';
                response.placeId = ApiResponse.candidates.get(0).place_id;
                response.accountId = AccountHelper.getAccountRelatedToThePlaceId(response.placeId);
            } else {
                response.typeMessage = 'Error';
                response.message = 'Places ID does not exist';
            }
        } catch(Exception e) {

            response.typeMessage = 'Error';
            response.message = e.getMessage();
            System.debug('[RegistrationFormController.processRegistration] Error: ' + e.getMessage() + '\n' + e.getStackTraceString());

        }
        return response;
    }

    /* **************************************************************************
    * Class: WorkRuleWrapper
    * Created by Juan Ramirez, July 27/2022
    *
    * Purpose/Methods:
    * - class to manage Account Information wrapper
    *
    *
    * Modifications:
    * - {DevName}, {MM/DD/YYYY} - {Description of changes made post deployment to client}
    *
    ************************************************************************** */
    public class AccountInformationWrapper {
            
        @AuraEnabled public String firstName;
        @AuraEnabled public String lastName;
        @AuraEnabled public String accountName;
        @AuraEnabled public String street; 
        @AuraEnabled public String city; 
        @AuraEnabled public String province; 
        @AuraEnabled public String postalCode; 
        @AuraEnabled public String country;  
        @AuraEnabled public String email;  
        @AuraEnabled public String phone;
        @AuraEnabled public String password;
        @AuraEnabled public String placeId;
        
    }

    /* **************************************************************************
    * Class: MessageResponse
    * Created by Juan Ramirez, July 27/2022
    *
    * Purpose/Methods:
    * - class to show confirmation messages (success, error, warning)
    *
    *
    * Modifications:
    * - {DevName}, {MM/DD/YYYY} - {Description of changes made post deployment to client}
    *
    ************************************************************************** */
    public class MessageResponse {
        @AuraEnabled public String typeMessage;
        @AuraEnabled public String message;
        @AuraEnabled public String placeId;
        @AuraEnabled public String accountId;
    }
    
}