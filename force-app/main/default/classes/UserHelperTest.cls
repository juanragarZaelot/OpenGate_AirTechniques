/**
 * Created by emiliano on 30/7/22.
 */
@isTest

public with sharing class UserHelperTest {

    @IsTest
    public static void userHelperTest(){
        RegistrationFormController.AccountInformationWrapper record = new RegistrationFormController.AccountInformationWrapper();
        String firstNameAcc = 'Jhon';
        String lastNameAcc = 'Smith';
        String accountName = 'Jhon';
        String street = 'Bv España 2228';
        String city = 'Montevideo';
        String country = 'Uruguay';
        String province = 'Montevideo';
        String email = 'testing@test.com';
        String phone = '123123123';
        String postalCode = '123123123';
        String password = '123123123';

        record.firstName = firstNameAcc;
        record.lastName = lastNameAcc;
        record.accountName = accountName;
        record.street = street;
        record.city = city;
        record.province = province;
        record.country = country;
        record.email = email;
        record.phone = phone;
        record.postalCode = postalCode;
        record.password = password;

        Account acc = AccountHelper.createAccount(record);

        Contact con = ContactHelper.createContact(record, acc.Id);

        User user = UserHelper.createUser(record, con.Id, acc.Id);

        System.assertEquals(firstNameAcc, user.FirstName);
        System.assertEquals(lastNameAcc, user.LastName);
        System.assertEquals(city, user.City);
        System.assertEquals(country, user.Country);
        System.assertEquals(postalCode, user.PostalCode);
        System.assertEquals(street, user.Street);
        System.assertEquals(phone, user.Phone);
        System.assertEquals(email, user.Email);
        System.assertEquals(email+'.AT', user.Username);
        System.assertEquals(email+'.AT', user.CommunityNickname);
        System.assertEquals('en_US', user.LanguageLocaleKey);
        System.assertEquals('en_US', user.LanguageLocaleKey);
        System.assertEquals([SELECT id FROM Profile WHERE name = 'AT Community'].Id, user.ProfileId);
        System.assertEquals(con.Id, user.ContactId);
    }


}