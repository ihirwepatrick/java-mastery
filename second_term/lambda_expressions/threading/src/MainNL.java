public class MainNL {
    public static void main(String[] args){
        NumberThread nt = new NumberThread();
        nt.start();
        LetterThread lt = new  LetterThread();
        lt.start();
    }
}
