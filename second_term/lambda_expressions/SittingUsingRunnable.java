public class SittingUsingRunnable {
    public static void main(String[] args) {
        BoysRunnable boy= new BoysRunnable();
        GirlsRunnable girl = new GirlsRunnable();
      Thread boysThread = new Thread(boy);
      Thread girlThread = new Thread(girl);
      boysThread.start();
      girlThread.start();
    }
}

