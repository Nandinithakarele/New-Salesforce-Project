public class sf0809AccountApi {

    // ===============================
    // METHOD 1: GET ACCESS TOKEN
    // ===============================
    public static AuthResponseWrapper getToken() {

        Http http = new Http();
        HttpRequest req = new HttpRequest();

        req.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');

        String reqBody =
            'grant_type=password' +
            '&client_id=YOUR_CLIENT_ID' +
            '&client_secret=YOUR_CLIENT_SECRET' +
            '&username=nandini.org2@gmail.com' +
            '&password=Org2#08258RugGHMJweIK8J3S25BWjmh2';

        req.setBody(reqBody);

        HttpResponse res = http.send(req);

        System.debug('responseBody: ' + res.getBody());

        AuthResponseWrapper wrap =
            (AuthResponseWrapper) JSON.deserialize(
                res.getBody(),
                AuthResponseWrapper.class
            );

        System.debug('wrapper token: ' + wrap);
        System.debug('token type: ' + wrap.token_type);

        return wrap;
    }

    // ===============================
    // METHOD 2: CALL ACCOUNT API
    // ===============================
    public static void getAccount() {

        //AuthResponseWrapper wrapAccount = getToken();

        Http httpAccount = new Http();
        HttpRequest getAccountRequest = new HttpRequest();

        /*getAccountRequest.setEndpoint(
           wrapAccount.instance_url +
            '/services/apexrest/getAccountFromReceiver'
        ); */
        getAccountRequest.setEndpoint(
            'callout:sf0809AccountNC'
        );

        getAccountRequest.setMethod('GET');
        getAccountRequest.setHeader('Content-Type', 'application/json');
        /*getAccountRequest.setHeader(
            'Authorization',
            wrapAccount.token_type + ' ' + wrapAccount.access_token
        );
       */

        HttpResponse res = httpAccount.send(getAccountRequest);

        System.debug('Response: ' + res.getBody());
    }

    // ===============================
    // WRAPPER CLASS
    // ===============================
    public class AuthResponseWrapper {
        public String access_token;
        public String instance_url;
        public String id;
        public String token_type;
        public String issued_at;
        public String signature;
    }
}