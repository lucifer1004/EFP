handle =
  &case &1 do
    :error ->
      IO.puts("Invalid input.")
      exit(:shutdown)

    {int, rest} ->
      if rest != "" do
        IO.puts("#{rest} has been truncated.")
      end

      if int < 0 do
        IO.puts("Negative values are not allowed.")
        exit(:shutdown)
      end

      int
  end

input =
  &(IO.gets("What is the #{&1} number? ")
    |> String.trim()
    |> Integer.parse()
    |> handle.())

first = input.("first")
second = input.("second")
IO.puts("#{first} + #{second} = #{first + second}")
IO.puts("#{first} - #{second} = #{first - second}")
IO.puts("#{first} * #{second} = #{first * second}")
IO.puts("#{first} / #{second} = #{div(first, second)}")
