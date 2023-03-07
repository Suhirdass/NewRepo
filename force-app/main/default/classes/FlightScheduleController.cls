public class FlightScheduleController {
    
    public static void saveFlightScheduleRecord(List<Fight_Schedule__c> newList){
        for (Fight_Schedule__c fs : newList) {
            if (fs.Source_Name__c == fs.Destination_Name__c) {
                fs.addError('The source and destination place cannot be the same.');
            }
        }
    }
}