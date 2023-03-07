public class AddPrimaryContact implements Queueable{

    private Contact con;
    private String state;
    
    public AddPrimaryContact(Contact con, String state){
        this.con = con;
        this.state = state;
    }
    
    public void execute(QueueableContext context){
        List<Contact> conList = new List<Contact>();
        List<Account> accList = [SELECT Id,Name,(SELECT Id,FirstName,LastName FROM contacts) FROM Account WHERE BillingState =:state LIMIT 200];
        
        for(Account acc: accList){
            Contact c = con.clone();
            c.AccountId = acc.Id;
            conList.add(c);
        }
        
        if(conList.size() > 0){
            insert conList;
        }
    }
}