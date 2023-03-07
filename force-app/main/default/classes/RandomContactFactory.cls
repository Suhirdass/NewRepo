public class RandomContactFactory {

    public static List<Contact> generateRandomContacts(Integer numberOfContacts,String firstName){
        List<Contact> contactList = new List<Contact>();
        
        for(Integer i=0;i<numberOfContacts;i++){
            Contact cnt = new Contact(FirstName=firstName + ' ' + i, LastName = 'Contact ' +i);
            contactList.add(cnt);
        }
        return contactList;
    }
}