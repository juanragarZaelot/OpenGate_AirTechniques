/* **************************************************************************
 * Class: AccountHelper
 * Created by Juan Ramirez, July 28/2022
 *
 * Purpose/Methods:
 * - class to manage all processes related to the User
 * 
 *
 * Unit Test: RegistrationFormControllerTest
 *
 * Modifications:
 * - {DevName}, {MM/DD/YYYY} - {Description of changes made post deployment to client}
 *
 ************************************************************************** */
public class UserHelper {
    /**
     * @author Juan Ramirez
     * @date 2022/07/28
     * @description process to create a User
	 * @param record all information to create the User
     * @return User object just created
     */
    public static User createUser(RegistrationFormController.AccountInformationWrapper record, Id contactId, Id accountId) {

        User us = new User();
        us.FirstName = record.firstName.trim();
	    us.LastName = record.lastName.trim();
        us.City = record.city.trim(); 
        us.Country = record.country.trim();  
        us.PostalCode = record.postalCode.trim(); 
        us.State = record.province.trim(); 
        us.Street = record.street.trim(); 
        us.Phone = record.phone.trim();
        us.Email = record.email.trim();
        us.Username = record.email.trim() + '.AT';
        us.communityNickname = record.email.trim() + '.AT';
        us.alias = record.email.trim().substring(0, 8);
        us.languagelocalekey = 'en_US';
        us.localesidkey = UserInfo.getLocale();
        us.emailEncodingKey = 'UTF-8';
        us.timeZoneSidKey = 'America/Los_Angeles';
        us.ProfileId = getProfile('AT Community').Id;
        us.ContactId = contactId;
        
        insert us;
        
        return us;
    }

    /**
     * @author Juan Ramirez
     * @date 2022/07/28
     * @description process to generate a random password
	 * @return String password generated
     */
    public static String generatePassword() {

        Integer len = 10;
        Blob blobKey = crypto.generateAesKey(128);
        String key = EncodingUtil.convertToHex(blobKey);
        String pwd = key.substring(0,len);
        return pwd;
    }

    /**
     * @author Juan Ramirez
     * @date 2022/07/28
     * @description process to get a profile by name
	 * @return Profile oject selected
     */
    public static Profile getProfile(String profileName) {

        return [SELECT
                Id,
                Name
            FROM Profile where Name = :profileName LIMIT 1];
    }

    /**
     * @author Juan Ramirez
     * @date 2022/08/02
     * @description process to get a User by username
	 * @return UserRole oject selected
     */
    public static User getUserByEmail(String email) {

        List<User> userList = [SELECT
                Id,
                Name
            FROM User where Email = :email LIMIT 1];
        return userList.size() > 0 ? userList.get(0) : null;
    }
}