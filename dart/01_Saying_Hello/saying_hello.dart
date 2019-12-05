import 'dart:io';

void main() {
  stdout.write("What is your name? ");
  String name = stdin.readLineSync().trim();
  print("Hello, $name, nice to meet you!");
}
