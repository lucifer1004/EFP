input = &(IO.gets("Enter a #{&1}: ") |> String.trim())

noun = input.("noun")
verb = input.("verb")
adjective = input.("adjective")
adverb = input.("adverb")

IO.puts("Do you #{verb} your #{adjective} #{noun} #{adverb}? That's hilarious!")
