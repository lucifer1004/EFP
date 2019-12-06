defmodule Input do
  @tax 0.055

  def handle(parsed) do
    case parsed do
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
  end

  def input(hint) do
    IO.gets(hint)
    |> String.trim()
    |> Integer.parse()
    |> handle()
  end

  def format(num) do
    (num + 0.0) |> :erlang.float_to_binary(decimals: 2)
  end

  def query_item(count, sum, continue) do
    if continue do
      price = input("Enter the price of item #{count + 1}: ")
      quantity = input("Enter the quantity of item #{count + 1}: ")
      more = IO.gets("Any more? [y] ") |> String.trim()
      query_item(count + 1, sum + price * quantity, more == "y")
    else
      tax = sum * @tax
      total = sum + tax
      IO.puts("Subtotal: $#{format(sum)}")
      IO.puts("Tax: $#{format(tax)}")
      IO.puts("Total: $#{format(total)}")
    end
  end
end

Input.query_item(0, 0, true)
