@RestResource(urlMapping='/cases/*')
global class CaseWebService {
    
  @HttpGet
    global static List<Case> getCase() {
        //grab the case record from the end of the URL -- return case from SF Org B
        List<Case> result =  [SELECT CaseNumber,Subject,Status,Origin,Priority FROM Case LIMIT 10];
        return result;
    }
}