@RestResource(urlMapping='/Accounts/*')
global with sharing class AccountWebService {
   @HttpGet
    global static List<Account> getAccount() {
        //grab the case record from the end of the URL -- return case from SF Org B
        List<Account> result =  [SELECT Name,Phone,Type,Industry FROM Account LIMIT 10];
        return result;
    }
}