global class AutocreatedRegHandler1398077435857 implements Auth.RegistrationHandler{
global boolean canCreateUser(Auth.UserData data) {
    return false;
}

global User createUser(Id portalId, Auth.UserData data){
System.debug('----'+data);
    
        
        User u = [Select Id , username from User where email =: data.email and isactive=true and profileid='00e90000001W0NI' limit 1];
        System.debug(u);
        return u;
    
}

global void updateUser(Id userId, Id portalId, Auth.UserData data){
System.debug('====\n\nAuth uppdate fun====');
System.debug('----'+data);
    
        
        User u = [Select Id , username from User where email =: data.email and isactive=true and profileid='00e90000001W0NI' limit 1];
        System.debug(u);
        //return u;
    createUser(portalId,data);
}}