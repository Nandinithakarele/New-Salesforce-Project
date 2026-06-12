public class WeatherService {
    
    public static void getWeather() {
        
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        
        req.setEndpoint('https://api.open-meteo.com/v1/forecast?latitude=18.52&longitude=73.85&current_weather=true');
        req.setMethod('GET');
        
        HttpResponse res = http.send(req);
        
        if(res.getStatusCode() == 200) {
            
            Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            
            Map<String, Object> current = (Map<String, Object>) result.get('current_weather');
            
            Weather_Data__c wd = new Weather_Data__c();
            wd.City__c = 'Pune';
            wd.Temperature__c = (Decimal) current.get('temperature');
            wd.WindSpeed__c = (Decimal) current.get('windspeed');
            
            insert wd;
        }
    }

}