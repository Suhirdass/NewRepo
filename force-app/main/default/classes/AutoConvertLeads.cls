public class AutoConvertLeads {

     public static void saveRecord(string compName){
        System.debug(compName);
        List<Lead> leads = [select id from lead where Company = :compName];
        System.debug(leads);
        List<Database.LeadConvert> leadsToConvert = new List<Database.LeadConvert>();
        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        System.debug(convertStatus);
        for(lead l: leads){
            System.debug(l);
            Database.LeadConvert tempLC = new Database.LeadConvert();
            tempLC.setLeadId(l.id);
            tempLC.setConvertedStatus(convertStatus.MasterLabel);
            tempLC.setDoNotCreateOpportunity(true);
           // tempLC.bypassaccountdedupecheck(true);
            //tempLC.setBypassAccountDedupeCheck(true);
           // tempLC.setBypassContactDedupeCheck(true);
           // tempLC.setOverwriteLeadSource(true);
           // tempLC.isOverwriteLeadSource();
            leadsToConvert.add(tempLC);
            System.debug(leadsToConvert);
        }
        
        List<Database.LeadConvertResult> lc = Database.convertLead(leadsToConvert);
        System.debug(lc);
        for(Database.LeadConvertResult lctemp: lc){
            system.debug(lctemp.getAccountId());
            system.debug(lctemp.getContactId());
        }
    }


}