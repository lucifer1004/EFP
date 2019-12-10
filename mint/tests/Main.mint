suite "Main" {
  test "Greets Mint" {
    with Test.Html {
      <Main/>
      |> start()
      |> assertTextOf("#title", "Exercises for Programmers")
      |> assertTextOf("#exercise-list", "Saying Hello")
    }
  }
}
