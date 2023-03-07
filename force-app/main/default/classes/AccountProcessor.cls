public class AccountProcessor {

    @future(callout=true)
    public static void countContacts(List<Id> accId){
        List<Account> accList = new List<Account>();
        List<Account> accounts = [Select Id, Name,Number_Of_Contacts__c,(SELECT Id FROM Contacts) from Account Where Id IN :accId];
        for(Account acc: accounts){
            Account accValue = new Account();
            accValue.Id = acc.Id;
            accValue.Number_Of_Contacts__c = acc.Contacts.size();
            accList.add(accValue);
        }
        update accList;
    }
}