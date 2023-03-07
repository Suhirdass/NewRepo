global class DailyLeadProcessor implements Schedulable {

   
    global void execute(SchedulableContext ctx) {
        List<Lead> leadList = new List<Lead>();
        List<Lead> leads = [SELECT Id, Name, LeadSource FROM Lead WHERE LeadSource = NULL LIMIT 200];
        
        for(Lead leadData : leads){
            leadData.LeadSource = 'Dreamforce';
            leadList.add(leadData);
            
        }
        update leadList;
    }

}