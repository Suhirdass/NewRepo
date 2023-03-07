@RestResource(urlMapping='/leads/*')
global class LeadWebService {
 
  @HttpGet
    global static List<Lead> getCase() {
        //grab the case record from the end of the URL -- return case from SF Org B
        List<Lead> result =  [SELECT FirstName,LastName,Phone,Email,Status,Company FROM Lead];
        return result;
    }

}