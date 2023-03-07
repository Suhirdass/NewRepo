@isTest
public class AddPrimaryContactTest {

    static testMethod void testQueueable(){
        List<Account> accList = new List<Account>();
        for(Integer i=0;i<50;i++){
            accList.add(new Account(Name='Account'+i,BillingState='CA'));
        }
        
        for(Integer j=0;j<50;j++){
            accList.add(new Account(Name='Account'+j,BillingState='NY'));
        }
        insert accList;
        
        Contact con = new Contact(FirstName='Suhir',LastName='Dass');
        insert con;
        
        AddPrimaryContact addPC = new AddPrimaryContact(con,'CA');
        
        Test.startTest();
        system.enqueueJob(addPC);
        Test.stopTest();
        
        system.assertEquals(50, [SELECT count() from Contact WHERE AccountId in (SELECT Id FROM Account WHERE BillingState ='CA')]);
    }
}