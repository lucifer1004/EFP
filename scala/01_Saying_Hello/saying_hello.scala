import scala.io.StdIn

object HelloWorld {
  def main(args: Array[String]): Unit = {
    var name = StdIn.readLine("What is your name? ")
    println("Hello, " + name + ", nice to meet you!")
  }
}