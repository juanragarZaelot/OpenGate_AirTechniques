@isTest
public with sharing class AccountHelperTest {

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
        System.assertEquals(firstNameAcc, acc.Name);
        System.assertEquals(city, acc.BillingCity);
        System.assertEquals(country, acc.BillingCountry);
        System.assertEquals(postalCode, acc.BillingPostalCode);
        System.assertEquals(province, acc.BillingState);
        System.assertEquals(street, acc.BillingStreet);
        System.assertEquals('EndUser/Direct Sales', acc.Type);
        System.assertEquals(phone, acc.Phone);

        Account account = AccountHelper.getAccount(acc.Name);
        System.assert(account != null);

    }
}