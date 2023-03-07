@isTest
private class AccountManagerTest {
    @isTest
    static void testGetAccount() {

        Id recordId = createTestRecord();
        RestRequest request = new RestRequest();
        request.requestUri = 'https://yourInstance.my.salesforce.com/services/apexrest/Accounts'+recordId+'/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        Account thisAccount = AccountManager.getAccount();
        System.Assert(thisAccount!=null);
        System.assertEquals('Test record', thisAccount.Name);
        
    }
    
    static Id createTestRecord(){
        // Create test data
        Account testAccount = new Account(Name='Test record');
        insert testAccount;

        Contact testContact1 = new Contact(AccountId=testAccount.Id, FirstName='John', LastName='Doe');
        insert testContact1;

      //  Contact testContact2 = new Contact(AccountId=testAccount.Id, FirstName='Jane', LastName='Doe');
      //  insert testContact2;
         return testAccount.Id;
       
        }
}