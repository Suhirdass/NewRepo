@isTest
private class AutoConvertLeadsTest {
    @isTest
    static void testSaveRecord() {
        
        Lead lead = new Lead(
            FirstName = 'John',
            LastName = 'Doe',
            Company = 'Test Company',
            Status = 'Qualified'
        );
        insert lead;

         Map<Id, String> leadCompanyMap = new Map<Id, String>();
         String companyNames;
         leadCompanyMap.put(lead.Id, lead.Company);
        
        for (Id leadId : leadCompanyMap.keySet()) {
            companyNames = leadCompanyMap.get(leadId);
        }
    
        
        // Call the Apex Class
        Test.startTest();
        AutoConvertLeads.saveRecord(companyNames);
        Test.stopTest();

        // Verify if the lead was converted or not
        List<Contact> contacts = [SELECT Id FROM Contact WHERE Account.Name = :lead.Company];
        System.assertEquals(1, contacts.size());
    }
}