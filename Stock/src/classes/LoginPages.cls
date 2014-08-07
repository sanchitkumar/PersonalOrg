public with sharing class LoginPages {
    public String password { get; set; }
    public String username { get; set; }
    
    public void registerUser() {
        system.debug('sanchit'+username);
        system.debug('sanchit'+password);
       
    }
    
    public PageReference validatePass(){
        system.debug('sanchit-----entered validatePass');
          
        string actualUsername = 'sanchit';
        string actualPassword = 'sanchit';
        
        if(username == actualUsername  &&  password == actualPassword )   
        {     
            system.debug('sanchit------pass'+password);
            PageReference pr = new PageReference('https://ap1.salesforce.com/a0A/o'); 
            system.debug('sanchit---pr--'+pr);
            return pr;
        }  
        else  
        {   
           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Invalid Username or Password'));
           return null;  
        }  
    }
  }