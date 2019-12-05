handle =
  &case &1 do
    :error ->
      IO.puts("Invalid input.")
      exit(:shutdown)

    {int, rest} ->
      if rest != "" do
        IO.puts("#{rest} has been truncated.")
      end

      if int <= 0 do
        IO.puts("Non-positive values are not allowed.")
        exit(:shutdown)
      end

      int
  end

input =
  &(IO.gets(&1)
    |> String.trim()
    |> Integer.parse()
    |> handle.())

people_count = input.("How many people? ")
pizza_count = input.("How many pizzas do you have? ")
slices_per_pizza = input.("How many slices does a pizza have? ")

display =
  &case &1 do
    :people ->
      if &2 != 1 do
        "people"
      else
        "person"
      end

    :pizza ->
      if &2 != 1 do
        "pizzas"
      else
        "pizza"
      end

    :slice ->
      if &2 != 1 do
        "pieces"
      else
        "piece"
      end
  end

IO.puts(
  "#{people_count} #{display.(:people, people_count)} with #{pizza_count} #{
    display.(:pizza, pizza_count)
  }."
)

slices_per_person = div(pizza_count * slices_per_pizza, people_count)
IO.puts("Each person gets #{slices_per_person} #{display.(:slice, slices_per_person)} of pizza.")

leftover = pizza_count * slices_per_pizza - people_count * slices_per_person
IO.puts("There are #{leftover} leftover #{display.(:slice, leftover)}.")
