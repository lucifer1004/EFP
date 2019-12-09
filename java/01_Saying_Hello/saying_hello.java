public class saying_hello {
  public static void main(String[] args) {
    var console = System.console();
    var name = console.readLine("What is your name? ");
    System.out.println("Hello, " + name + ", nice to meet you!");
  }
}