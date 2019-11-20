name =
  IO.gets("What is your name? ")
  |> String.trim()

IO.puts("Hello, #{name}, nice to meet you!")
