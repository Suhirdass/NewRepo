@RestResource(urlMapping='/accountssss/*')
global class insertAccountFromOrgA{
    
     @HttpPost
    global static string createAccount(String Name, String Phone,String Industry,String Type){

        system.debug(Name);
        system.debug(Phone);
        system.debug(Industry);
        system.debug(Type);
        
        Account thisAccount = new Account(
            Name=Name,
            Phone=Phone,
            Type=Type,
            Industry=Industry);
        insert thisAccount;
        
        String returnResponse = 'Record Inserted Successfully';
        return returnResponse;
        //return thisCase.Id;
    }
  
}