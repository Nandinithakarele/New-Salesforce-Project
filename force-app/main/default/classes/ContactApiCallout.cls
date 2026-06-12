public class ContactApiCallout {
    public static AccessWrapper getAccessToken(){
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        //req.setEndpoint('https://test.salesforce.com/services/oauth2/token');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        sf08__mdt mdt = sf08__mdt.getInstance('contactApi');
        
        string requestBody = 'grant_type=password' 
            + '&client_id=' +mdt.Client_Id__c 
            + '&client_secret='+mdt.Client_Secret__c 
            + '&username=' +mdt.Username__c 
            + '&password=' +mdt.Password__c;
                             
        req.setBody(requestBody);
        Http http = new Http();
        HttpResponse res = http.send(req);
        System.debug('response:'+res.getBody());
        
        AccessWrapper accessWrap = (AccessWrapper)JSON.deserialize(res.getBody(), AccessWrapper.class);
        System.debug(accessWrap);
        return accessWrap;
    }
    
    
    public class AccessWrapper{
        public String access_token;	//SESSION_ID_REMOVED
        public String instance_url;	//https://orgfarm-342f5f118c-dev-ed.develop.my.salesforce.com
        public String id;	//https://login.salesforce.com/id/00Dg500000B1WfREAV/005g5000007N909AAC
        public String token_type;	//Bearer
        public String issued_at;	//1779884682476
        public String signature;	//qy4gLVkpDzbNsuOGLX/7whGN2L6Zzeq30d9WGbAjNqM=
    }
    
    public static void makeGetCall(){
        AccessWrapper accessWrap = getAccessToken();
        if(accessWrap.access_token != null){
            HttpRequest req = new HttpRequest();
            string endPoint = accessWrap.instance_url + '/services/apexrest/sf08Contacts?firstName=Jon&lastName=Snow';
            req.setEndpoint(endPoint);
            req.setMethod('GET');
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('Authorization', 'Bearer '+ accessWrap.access_token);
            Http http = new Http();
            HttpResponse res = http.send(req);
            system.debug('response:' + res.getBody());
        }
    }
    public static void makePostCall(){
        
        AccessWrapper accessWrap = getAccessToken();
        if(accessWrap.access_token != null){
            HttpRequest req = new HttpRequest();
            string endPoint = accessWrap.instance_url + '/services/apexrest/sf08Contacts';
            req.setEndpoint(endPoint);
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('Authorization', 'Bearer '+ accessWrap.access_token);
            Map<String, Object> requestMap = new Map<String, Object>();
            requestMap.put('firstName', 'Rob');
            requestMap.put('lastName', 'Stark');
            requestMap.put('email', 'nandini@ci.com');
            requestMap.put('phone', '9873456278');
            req.setBody(JSON.serialize(requestMap));
            Http http = new Http();
            HttpResponse res = http.send(req);
            system.debug('response:' + res.getBody());
        }

        
    }
    

}