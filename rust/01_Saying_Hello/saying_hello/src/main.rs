use std::io;
use std::io::Write;

fn main() {
    print!("What is your name? ");
    io::stdout().flush();
    let mut name = String::new();
    io::stdin().read_line(&mut name).expect("An error occurs.");
    println!("Hello, {}, nice to meet you!", name.trim());
}
