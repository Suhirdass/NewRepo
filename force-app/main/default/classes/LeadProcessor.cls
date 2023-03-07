global class LeadProcessor implements Database.Batchable<sObject> {

    global Integer count = 0;
 global Database.QueryLocator start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        return Database.getQueryLocator('SELECT ID, Name,LeadSource FROM Lead');
    }
    
    global void execute(Database.BatchableContext bc, List<Lead> leadLists){
        // process each batch of records
        List<Lead> leadList = new List<Lead>();
        for(Lead leadData : leadLists){
            leadData.LeadSource = 'Dreamforce';
            leadList.add(leadData);
            count += 1;
        }
        update leadList;
    }
    
    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
        system.debug('count = ' +count);
    }
    
}