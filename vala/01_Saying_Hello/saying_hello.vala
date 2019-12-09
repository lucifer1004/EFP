int main() {
  print("What is your name? ");
  string? name = stdin.read_line();
  if (name != null) {
    stdout.printf ("Hello, %s, nice to meet you!", name);
  }
  return 0;
}