public class AnimalLocator {

  public static String getAnimalNameById(Integer Num) {
     // String animalName;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + Num);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        Map<String, Object> animal = new Map<String, Object>();
      
        // If the request is successful, parse the JSON response.
        if(response.getStatusCode() == 200) {
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            animal = (Map<String, Object>) results.get('animal');
            
        }
        return (String)animal.get('name');
    }
}