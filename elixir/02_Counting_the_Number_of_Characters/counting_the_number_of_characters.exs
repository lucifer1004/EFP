input =
  IO.gets("What is the input string? ")
  |> String.trim()

len = String.length(input)
IO.puts("#{input} has #{len} character#{if(len != 1, do: "s", else: "")}.")
