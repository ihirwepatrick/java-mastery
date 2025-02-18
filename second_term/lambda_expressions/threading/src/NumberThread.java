public class NumberThread extends Thread{
    public void run(){
 for(int i=1; i<=25; i++){
     System.out.println("n = " +i);
    try{
        Thread.sleep(12);
    }catch(InterruptedException e){
        throw new RuntimeException (e);
    }
 }
    }
}
