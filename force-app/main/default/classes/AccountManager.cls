@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {

    @HttpGet
    global static Account getAccount() {
        
        RestRequest request = RestContext.request;
        
        // Get the account ID from the request URL
        String accountId = request.requestURI.subStringBetween('/Accounts/','/contacts');

        // Query the account and its related contacts
        Account result = [SELECT Id, Name, (SELECT Id, Name FROM Contacts) FROM Account WHERE Id = :accountId LIMIT 1]; return result;
    }
}