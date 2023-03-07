@isTest
public class AccountProcessorTest {

    @isTest
    public static void testNoOfContacts(){
        Account a = new Account();
        a.Name = 'Test Account';
        insert a;
        
        Contact c= new Contact();
        c.FirstName = 'Suhir';
        c.LastName = 'Dass';
        c.AccountId = a.Id;
        insert c;
        
        Contact c1= new Contact();
        c1.FirstName = 'Suhir';
        c1.LastName = 'Dass';
        c1.AccountId = a.Id;
        insert c1;
        
        /*
        List<Account> accList = new List<Account>();
        Account a1 = new Account();
        a1.Id = a.Id;
        a1.Number_Of_Contacts__c = a.contacts.size();
        accList.add(a1);
        update accList;*/
        
        List<Id> acctIds = new List<Id>();
        acctIds.add(a.Id);
        
        Test.startTest();
        AccountProcessor.countContacts(acctIds);
        Test.stopTest();
    }
}