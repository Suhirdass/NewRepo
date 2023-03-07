trigger leadTrigger on Lead (after update) {  
    
    Map<Id, String> leadCompanyMap = new Map<Id, String>();
    String companyNames = '';
    
    for (Lead leadRecord : Trigger.new) {
        if(leadRecord.Status != Trigger.oldMap.get(leadRecord.Id).Status && leadRecord.Status == 'Qualified'){
            leadCompanyMap.put(leadRecord.Id, leadRecord.Company);
        } 
    }
        
        for (Id leadId : leadCompanyMap.keySet()) {
            companyNames = leadCompanyMap.get(leadId);
        }
    
    if(companyNames != null) {
        AutoConvertLeads.saveRecord(companyNames);
    }
 
}