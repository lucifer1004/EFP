class Main {
	static public function main():Void {
		var name:String;
		Sys.print("What is your name? ");
		name = Sys.stdin().readLine();
		Sys.print("Hello, " + name + ", nice to meet you!");
	}
}
