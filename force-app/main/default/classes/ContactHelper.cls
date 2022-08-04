/* **************************************************************************
 * Class: AccountHelper
 * Created by Juan Ramirez, July 28/2022
 *
 * Purpose/Methods:
 * - class to manage all processes related to the Contact
 * 
 *
 * Unit Test: RegistrationFormControllerTest
 *
 * Modifications:
 * - {DevName}, {MM/DD/YYYY} - {Description of changes made post deployment to client}
 *
 ************************************************************************** */
public class ContactHelper {
 
    /**
     * @author Juan Ramirez
     * @date 2022/07/28
     * @description process to create a Contact
	 * @param record all information to create the contact
     * @param accountId id of Account used to the contact
     * @return Contact object just created
     */
    public static Contact createContact(RegistrationFormController.AccountInformationWrapper record, Id accountId) {

        Contact con = new Contact();
        con.FirstName = record.firstName.trim();
	    con.LastName = record.lastName.trim();
        con.MailingCity = record.city.trim(); 
        con.MailingCountry = record.country.trim();  
        con.MailingPostalCode = record.postalCode.trim(); 
        con.MailingState = record.province.trim(); 
        con.MailingStreet = record.street.trim(); 
        con.Phone = record.phone.trim();
        con.Email = record.email.trim();
        con.AccountId = accountId;
        insert con;
        return con;
    }

    /**
     * @author Juan Ramirez
     * @date 2022/07/28
     * @description get Contact filter by email
	 * @param contactEmail email of the contact
     * @return Contact object selected
     */
    public static Contact getContact(String contactEmail) {

        List<Contact> contactList = [SELECT Id,Email from Contact WHERE Email = :contactEmail];
        
        return contactList.size() > 0 ? contactList.get(0) : null;
    }
}