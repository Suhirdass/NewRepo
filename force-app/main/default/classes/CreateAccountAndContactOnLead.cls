public class CreateAccountAndContactOnLead {
    
     public static void saveRecord(List<Id> leadIds, Set<String> companyNames) {
         System.debug('leadIds ' +leadIds);
         System.debug('companyNames ' +companyNames);
         
        List<Lead> leadList = [SELECT Id, Name, Company, FirstName, LastName, Email FROM Lead WHERE Id IN :leadIds AND Company IN :companyNames];
         System.debug('leadList ' +leadList);
         
        Map<String, List<Lead>> companyToLeadsMap = new Map<String, List<Lead>>();
        for (Lead leadRecord : leadList) {
            System.debug('leadRecord ' +leadRecord);
            if (!companyToLeadsMap.containsKey(leadRecord.Company)) {
                companyToLeadsMap.put(leadRecord.Company, new List<Lead>());
                System.debug('companyToLeadsMap ' +companyToLeadsMap);
            }
            companyToLeadsMap.get(leadRecord.Company).add(leadRecord);
            System.debug('companyToLeadsMap ' +companyToLeadsMap);
        }
         
        List<Account> accountList = new List<Account>();
        List<Contact> contactList = new List<Contact>();
         
        for (String companyName : companyToLeadsMap.keySet()) {
            System.debug('companyName ' +companyName);
            
            List<Account> existingAccounts = [SELECT Id, Name FROM Account WHERE Name = :companyName LIMIT 1];
            Account accountRecord;
            
            if (existingAccounts.isEmpty()) {
                accountRecord = new Account(Name = companyName);
                accountList.add(accountRecord);
                 System.debug('accountList ' +accountList);
            } else {
                accountRecord = existingAccounts[0];
                 System.debug('accountRecord ' +accountRecord);
            }
            
          /*  Account accountRecord = new Account(Name = companyName);
            accountList.add(accountRecord);
            System.debug('accountList ' +accountList);*/
            
            for (Lead leadRecord : companyToLeadsMap.get(companyName)) {
                System.debug('leadRecord ' +leadRecord);
                
                Contact contactRecord = new Contact(FirstName = leadRecord.FirstName,
                                                     LastName = leadRecord.LastName,
                                                     Email = leadRecord.Email,
                                                     AccountId = accountRecord.Id);
                contactList.add(contactRecord);
                System.debug('contactList ' +contactList);
                
                leadRecord.Account_ID__c = accountRecord.Id;
                System.debug('leadRecord ' +leadRecord);
            }
        }
        insert accountList;
        insert contactList;
        update leadList;
    }
    
    /*
    public static void saveRecord(Lead currentLead) {
        
        if (currentLead.ConvertedContactId != null) {
            return;
        }
        
        Map<String, Account> accountMap = new Map<String, Account>();

        for (Lead lead : [SELECT Id, Company, ConvertedAccountId, ConvertedContactId FROM Lead WHERE Company = :currentLead.Company AND Id != :currentLead.Id]) {
            if (!accountMap.containsKey(lead.Company)) {
                accountMap.put(lead.Company, new Account(Id = lead.ConvertedAccountId));
            }
        }

        List<Database.LeadConvert> leadConverts = new List<Database.LeadConvert>();
        if (accountMap.containsKey(currentLead.Company)) {
            Database.LeadConvert leadConvert = new Database.LeadConvert();
            leadConvert.setLeadId(currentLead.Id);
            leadConvert.setConvertedStatus('Closed - Converted');
            leadConvert.setAccountId(accountMap.get(currentLead.Company).Id);
            leadConvert.setDoNotCreateOpportunity(true);
            //Database.convertLead(new List<Database.LeadConvert>{leadConvert}, true);
            leadConverts.add(leadConvert);
            return;
        }


        List<Database.LeadConvertResult> convertResults = Database.convertLead(leadConverts, true);

        if (convertResults != null && !convertResults.isEmpty()) {
            for (Database.LeadConvertResult convertResult : convertResults) {
                if (convertResult.isSuccess() && convertResult.getContactId() != null) {
                    Contact newContact = new Contact(
                        Id = convertResult.getContactId(),
                        FirstName = currentLead.FirstName,
                        LastName = currentLead.LastName,
                        Email = currentLead.Email,
                        Phone = currentLead.Phone
                    );
                    update newContact;

                    if (convertResult.getAccountId() != null) {
                        Account newAccount = new Account(
                            Id = convertResult.getAccountId(),
                            Name = currentLead.Company
                        );
                        update newAccount;
                    }
                }
            }
        }
    }*/


    /*
    public static void handleUpdate(Map<Id, Lead> newLeads, Map<Id, Lead> oldLeads) {
        System.debug('newLeads >> ' + newLeads);
        System.debug('oldLeads >> ' + oldLeads);
        
        List<Lead> updatedLeads = new List<Lead>();
        for (Id leadId : newLeads.keySet()) {
            System.debug('leadId >> ' + leadId);
            if (newLeads.get(leadId).Company == oldLeads.get(leadId).Company) {
                updatedLeads.add(newLeads.get(leadId));
                System.debug('updatedLeads >> ' + updatedLeads);
            }
        }
        if (!updatedLeads.isEmpty()) {
            List<Account> accountsToCreate = new List<Account>();
            List<Contact> contactsToCreate = new List<Contact>();
            for (Lead lead : updatedLeads) {
                System.debug('lead >> ' + lead);
                
                Account account = new Account(Name = lead.Company);
                accountsToCreate.add(account);
                System.debug('accountsToCreate >> ' + accountsToCreate);
                
                Contact contact = new Contact(
                    FirstName = lead.FirstName,
                    LastName = lead.LastName,
                    Email = lead.Email,
                    Phone = lead.Phone,
                    AccountId = account.Id
                );
                contactsToCreate.add(contact);
                System.debug('contactsToCreate >> ' + contactsToCreate);
                
                lead.ConvertedAccount.Id = account.Id;
                System.debug('lead >> ' + lead);
            }
            System.debug('accountsToCreate >> ' + accountsToCreate);
            insert accountsToCreate;
            
            System.debug('contactsToCreate >> ' + contactsToCreate);
            insert contactsToCreate;
            
            //System.debug('lead >> ' + lead);
            update updatedLeads;
        }
    }*/
}