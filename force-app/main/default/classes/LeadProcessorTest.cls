@isTest
public class LeadProcessorTest {

    @isTest
    public static void testing(){
        List<Lead> leadList = new List<Lead>();
        for(Integer i=0;i<200;i++){
            Lead leadData = new Lead();
            leadData.LastName = 'name' + i;
            leadData.Company = 'Dreamforce';
            leadData.Status = 'Random Status';
            leadList.add(leadData);
            
        }
        insert leadList;
        
        Test.startTest();
        LeadProcessor lp = new LeadProcessor();
        Id batchId = Database.executeBatch(lp);
        Test.stopTest();
    }
}