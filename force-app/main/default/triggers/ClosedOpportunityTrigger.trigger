trigger ClosedOpportunityTrigger on Opportunity (after insert,after update) {

     List<Task> TaskList = new  List<Task>();
    
    for(Opportunity opp : Trigger.new){
        // Insert Method - while creating the record, when Stage is Closed Won to insert task and and whatId  
        if(Trigger.isInsert){
            if(opp.StageName == 'Closed Won'){
                TaskList.add(new Task(Subject = 'Follow Up Test Task',WhatId=opp.Id));
            }
        }
            // Update Method - while Updating the record, when Stage is Closed Won to insert task and and whatId
            if(Trigger.isUpdate){
                if(opp.StageName == 'Closed Won' && opp.StageName != Trigger.OldMap.get(opp.id).StageName){
                    TaskList.add(new Task(Subject = 'Follow Up Test Task',WhatId=opp.Id));
                }
            }
        
        
    }
    
    if(TaskList.size()>0){
    insert TaskList;
    }
}