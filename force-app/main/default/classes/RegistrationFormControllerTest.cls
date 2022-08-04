/**
 * Created by emiliano on 30/7/22.
 */
@isTest
public with sharing class RegistrationFormControllerTest {

    @testSetup static void createData(){



    }
    @IsTest
    public static void registration(){

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

        String jsonStr = JSON.serialize(record);

        // Let's create a new test user
        Profile testProfile = [SELECT Id
                                FROM profile
                                WHERE Name = 'System Administrator'
                                LIMIT 1];

        UserRole userRole = [Select Id, DeveloperName From UserRole Limit 1];

        User testUser = new User(LastName = 'test user 1',
                Username = 'test.user.1@example.com.zaelot',
                Email = 'test.1ok@example.com',
                Alias = 'testu1',
                TimeZoneSidKey = 'GMT',
                LocaleSidKey = 'en_GB',
                EmailEncodingKey = 'ISO-8859-1',
                ProfileId = testProfile.Id,
                UserRoleId = userRole.Id,
                LanguageLocaleKey = 'en_US');

        String respondeBody = '{\"placeId\":\"ABCD123123123\"';

        //Test.setMock(HttpCalloutMock.class, new PlaceIdCalloutMock(200, respondeBody));

        Test.startTest();

        System.runAs(testUser){
            Test.setMock(HttpCalloutMock.class, new PlaceIdCalloutMock());

            //RegistrationFormController.processRegistration(jsonStr);
            AccountHelper.getGooglePlaceFinderIdEmi('abc');
        }

        Test.stopTest();


        User user = [SELECT Id, ProfileId, FirstName, LastName, City, Country, PostalCode, State, Username FROM User where LastName = :lastNameAcc];

        System.assertEquals(firstNameAcc, user.FirstName);
        System.assertEquals(lastNameAcc, user.LastName);
        //System.assertEquals(lastNameAcc, user.ProfileId);
        System.assertEquals(email+'.at', user.Username);


    }

    @IsTest
    public static void accountNotRelatedToPlaceId(){

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

        String jsonStr = JSON.serialize(record);

        // Let's create a new test user
        Profile testProfile = [SELECT Id
            FROM profile
            WHERE Name = 'System Administrator'
            LIMIT 1];

        UserRole userRole = [Select Id, DeveloperName From UserRole Limit 1];

        User testUser = new User(LastName = 'test user 1',
                Username = 'test.user.1@example.com.zaelot',
                Email = 'test.1ok@example.com',
                Alias = 'testu1',
                TimeZoneSidKey = 'GMT',
                LocaleSidKey = 'en_GB',
                EmailEncodingKey = 'ISO-8859-1',
                ProfileId = testProfile.Id,
                UserRoleId = userRole.Id,
                LanguageLocaleKey = 'en_US');

        String respondeBody = 'empty"';

        //Test.setMock(HttpCalloutMock.class, new PlaceIdCalloutMock(200, respondeBody ));

        Test.startTest();

        System.runAs(testUser){
            RegistrationFormController.processRegistration(jsonStr);
        }

        Test.stopTest();

        User user = [SELECT Id, ProfileId, FirstName, LastName, City, Country, PostalCode, State, Username FROM User WHERE LastName = :lastNameAcc];

        System.assertEquals(firstNameAcc, user.FirstName);
        System.assertEquals(lastNameAcc, user.LastName);
        //System.assertEquals(lastNameAcc, user.ProfileId);
        System.assertEquals(email+'.at', user.Username);


    }


}