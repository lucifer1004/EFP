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
  &(IO.gets(&1)
    |> String.trim()
    |> Integer.parse()
    |> handle.())

current = input.("What is your current age? ")
retire = input.("At what age would you like to retire? ")

{:ok, now} = DateTime.now("Etc/UTC")

if retire > current do
  IO.puts("It's #{now.year}, so you can retire in #{now.year + retire - current}.")
else
  if retire == current do
    IO.puts("It's #{now.year}, the same year in which you can retire.")
  else
    IO.puts("It's #{now.year}, and you retired in #{now.year + retire - current}.")
  end
end
