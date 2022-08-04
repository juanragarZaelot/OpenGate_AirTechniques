@IsTest
public with sharing class ContactHelperTest {

    @IsTest
    public static void accountHelperTest(){
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

        System.assertEquals(firstNameAcc, con.FirstName);
        System.assertEquals(lastNameAcc, con.LastName);
        System.assertEquals(city, con.MailingCity);
        System.assertEquals(country, con.MailingCountry);
        System.assertEquals(postalCode, con.MailingPostalCode);

        System.assertEquals(province, con.MailingState);
        System.assertEquals(street, con.MailingStreet);

        System.assertEquals(phone, con.Phone);
        System.assertEquals(email, con.email);
        System.assertEquals(acc.Id, con.AccountId);

    }
}