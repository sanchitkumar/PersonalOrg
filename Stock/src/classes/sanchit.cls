public class sanchit{
public static boolean isprime(integer num)
    
    {
        if(num<=1){
            return(false);
        }
        for(integer i=2;i<num;i++){
            if(math.mod(num,i) ==0 && i!=num){
                return(false);
            } 
        }
        return(true);
    }
}