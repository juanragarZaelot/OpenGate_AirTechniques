public with sharing class CreatePortalUserController {

    public static String getGooglePlaceFinderId(String address) {

        HttpRequest req = new HttpRequest();
        //  req.setEndpoint('callout:Google_Places/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&radius=500&types=food&name=harbour');
        req.setEndpoint('https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=Torre Libertad, Cagancha 1335, 11100 Montevideo&inputtype=textquery&fields=place_id&key=AIzaSyAqJb5FkqUFibVAbSiI5RlL9gqe43Qx9gg');
        req.setMethod('GET');

        Http http = new Http();

        HTTPResponse res = http.send(req);
        System.debug(res.getBody());
        return '';
    }


    /*

    Method: getAccountIdBasedOnAddress
    This method returns the id of the account related to the Address based on the response of the API Places of Google
    if the returned id is null, then that means there is no account related to that address

    public static Id getAccountIdBasedOnAddress(String address) {
        String placeId = null;
        if (Test.isRunningTest() == false){
            placeId = getGooglePlaceFinderId(address);
        }

        if (placeId != null) {
            return ([SELECT id FROM Account WHERE PlaceId__c = :placeId].Id);
        }

        return null;
    }

    /*
    Method: createUser
    This method creates an account (if it does not exist), a contact and a portal user

    public static void createContact(String firstName, String lastName, String anEmail, String address) {
        Id accountId = getAccountIdBasedOnAddress(address);

        if (accountId == null) {
            //if account is not related to a place Id
            Account acc = new Account();
            //acc.BillingAddress = (Address) address;
            acc.Name = firstName + ' ' + lastName;
            insert acc;
            accountId = acc.Id;
        }

        Contact con = new Contact();
        con.FirstName = firstName;
        con.LastName = lastName;
        con.Email = anEmail;
        insert con;

        Profile pf = [SELECT id, name FROM Profile LIMIT 1];

        User u = new User(contactId = con.Id, username = con.Email+'.AT', firstname = con.FirstName,
                lastname = con.LastName, email = con.Email, communityNickname = con.FirstName + '_' + con.LastName,
                alias = String.valueof(con.FirstName.substring(0, 1) + con.LastName.substring(0, 1)), profileid = pf.Id, emailencodingkey = 'UTF-8',
                languagelocalekey = 'en_US', localesidkey = 'en_US', timezonesidkey = 'America/Los_Angeles');
        Database.DMLOptions dlo = new Database.DMLOptions();
        dlo.EmailHeader.triggerUserEmail = true;
        /*


        User u = new User();
        u.Username = con.Email+'.AT';
        u.Email = anEmail;
        u.CommunityNickname = 'communityNickname';

         //accountId = PORTAL_ACCOUNT_ID;

        // lastName is a required field on user, but if it isn't specified, we'll default it to the username
        String userId = Site.createPortalUser(u, accountId, 'password');

        System.debug('EMI  ' + [SELECT id FROM User WHERE ContactId = :con.Id]);
        System.debug('EMI  ' + userId);


    }

    public static void testing(String firstName, String lastName, String email, String address){
        Savepoint sp = null;
        try {
            sp = Database.setSavepoint();

            Id accountId = getAccountIdBasedOnAddress(address);

            if (accountId == null) {
                //if account is not related to a place Id
                Account acc = new Account();
                //acc.BillingAddress = (Address) address;
                acc.Name = firstName + ' ' + lastName;
                insert acc;
                accountId = acc.Id;
            }


            User u = new User();
            u.Username = email;
            u.put('Email',email);

            u.FirstName = firstname;
            u.LastName = lastname;

            String networkId = Network.getNetworkId();


            String nickname = ((firstname != null && firstname.length() > 0) ? firstname.substring(0,1) : '' ) + lastname.substring(0,1);
            nickname += String.valueOf(Crypto.getRandomInteger()).substring(1,7);
            u.put('CommunityNickname', nickname);

            String password = null;

            // lastName is a required field on user, but if it isn't specified, we'll default it to the username
            String userId = Site.createPortalUser(u, accountId, password);

            System.debug('EMI X ' + userId);
            // create a fake userId for test.
            if (Test.isRunningTest()) {
                userId = 'fakeUserId';
            }

        }
        catch (Exception ex) {
            System.debug('EMI ERROR ' + ex.getMessage());

            Database.rollback(sp);
        }
    }*/




}