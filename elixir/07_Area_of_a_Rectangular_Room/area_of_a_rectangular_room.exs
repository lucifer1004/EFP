conversion = 0.09290304

handle =
  &case &1 do
    :error ->
      IO.puts("Invalid input.")
      exit(:shutdown)

    {float, rest} ->
      if rest != "" do
        IO.puts("#{rest} has been truncated.")
      end

      if float <= 0 do
        IO.puts("Non-positive values are not allowed.")
        exit(:shutdown)
      end

      float
  end

input =
  &(IO.gets(&1)
    |> String.trim()
    |> Float.parse()
    |> handle.())

use_feet =
  if IO.gets("Use feet? [type 'n' to use meter.] ")
     |> String.trim() == "n" do
    false
  else
    true
  end

unit =
  case use_feet do
    true -> "feet"
    false -> "meter"
  end

len = input.("What is the length of the room in #{unit}? ")
width = input.("What is the width of the room in #{unit}? ")

area_in_square_feet =
  case use_feet do
    true -> len * width
    false -> len * width / conversion
  end

area_in_square_meters =
  case use_feet do
    true -> len * width * conversion
    false -> len * width
  end

IO.puts("You entered dimensions of #{len} #{unit} by #{width} #{unit}.")
IO.puts("The area is
#{area_in_square_feet} square feet
#{area_in_square_meters} square meters
")
