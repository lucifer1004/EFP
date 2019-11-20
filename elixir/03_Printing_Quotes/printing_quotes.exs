input = &(IO.gets(&1) |> String.trim())

saying = input.("What is the quote? ")
person = input.("Who said it? ")

IO.puts("#{person} says, \"#{saying}\"")
