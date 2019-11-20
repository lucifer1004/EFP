input = String.trim(IO.gets("What is the input string? "))
len = String.length(input)
IO.puts("#{input} has #{len} character#{if(len != 1, do: "s", else: "")}.")
