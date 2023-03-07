trigger FlightScheduleTrigger on Fight_Schedule__c (before insert, before update) {
 
    if(Trigger.isBefore){
        if(Trigger.isInsert || Trigger.isUpdate){
            FlightScheduleController.saveFlightScheduleRecord(Trigger.New);
        }
    }
}