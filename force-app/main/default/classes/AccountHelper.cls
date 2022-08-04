/* **************************************************************************
 * Class: AccountHelper
 * Created by Juan Ramirez, July 28/2022
 *
 * Purpose/Methods:
 * - class to manage all processes related to the Account
 * 
 *
 * Unit Test: RegistrationFormControllerTest
 *
 * Modifications:
 * - {DevName}, {MM/DD/YYYY} - {Description of changes made post deployment to client}
 *
 ************************************************************************** */
public class AccountHelper {
    
    /**
     * @author Juan Ramirez
     * @date 2022/07/28
     * @description process to create a account
	 * @param record all information to create the account
     * @return Account object just created
     */
    public static Account createAccount(RegistrationFormController.AccountInformationWrapper record) {

        Account acc = new Account();
        acc.Name = record.accountName.trim();
        acc.BillingCity= record.city.trim(); 
        acc.BillingCountry= record.country.trim();  
        acc.BillingPostalCode= record.postalCode.trim(); 
        acc.BillingState= record.province.trim(); 
        acc.BillingStreet= record.street.trim(); 
        acc.Type = 'EndUser/Direct Sales';
        acc.Phone = record.phone.trim();
        acc.PlaceId__c = record.placeId;
        insert acc;
        return acc;
    }

    /** @author Emiliano Gnocchi
    * @date 2022/07/28
    * @description return the account related to the place id if in case the that exists, otherwise it will create a new account id
    * @param full address
    * @return an account id
    */
    public static Id getAccountRelatedToThePlaceId(String placeId){
        
        List<Account> accountList = [SELECT Id FROM Account WHERE PlaceId__c = :placeId];
        return accountList.size() > 0 ? accountList.get(0).Id : null;
        
    }

    
    public static GooglePlaceResponse getGooglePlaceFinderId(String address) {

        Air_Techniques_Setting__mdt setting = [SELECT 	Name__c, Value__c from Air_Techniques_Setting__mdt where Name__c = 'Google Places Key'];
        HttpRequest req = new HttpRequest();
        String search = EncodingUtil.urlEncode(address, 'UTF-8');
        req.setEndpoint('callout:Google_Places/maps/api/place/findplacefromtext/json?input=' + search + '&inputtype=textquery&fields=place_id&key=' + setting.Value__c);
        
        req.setMethod('GET');

        Http http = new Http();

        HTTPResponse res = http.send(req);
        System.debug('[AccounHelper.getGooglePlaceFinderId]' + res.getBody());
        return GooglePlaceResponse.parse(res.getBody());
    }


    public static GooglePlaceResponse getGooglePlaceFinderIdEmi(String address) {


        testing(address);
        return GooglePlaceResponse.parse(response);
    }

    private static String response;
    @future
    public static void testing(String address){
        Air_Techniques_Setting__mdt setting = [SELECT 	Name__c, Value__c from Air_Techniques_Setting__mdt where Name__c = 'Google Places Key'];

        HttpRequest req = new HttpRequest();
        String search = EncodingUtil.urlEncode(address, 'UTF-8');
        req.setEndpoint('callout:Google_Places/maps/api/place/findplacefromtext/json?input=' + search + '&inputtype=textquery&fields=place_id&key=' + setting.Value__c);

        req.setMethod('GET');

        Http http = new Http();

        HTTPResponse res = http.send(req);
        System.debug('[AccounHelper.getGooglePlaceFinderId]' + res.getBody());
        response = res.getBody();
       // return response;
    }




    /**
     * @author Juan Ramirez
     * @date 2022/07/28
     * @description get Account filter by name
	 * @param accountName name of the account
     * @return Account object selected
     */
    public static Account getAccount(String accountName) {

        List<Account> accountList = [SELECT Id,Name,BillingCity,BillingCountry,BillingPostalCode,
                                    BillingState,BillingStreet,Type,Phone from Account WHERE Name = :accountName];
        
        return accountList.size() > 0 ? accountList.get(0) : null;
    }


    
}