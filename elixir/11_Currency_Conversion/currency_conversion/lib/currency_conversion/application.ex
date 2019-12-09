defmodule CurrencyConversion.Application do
  use Application

  @cache "rates.cache"
  @ts "timestamp"
  @rates "rates"
  @expiration 18000
  @appid System.fetch_env!("OPENEXCHANGE_APPID")

  defp get_currency(rates, hint) do
    currency = IO.gets(hint) |> String.trim()

    if rates[@rates][currency] == nil do
      if currency == "h" do
        Map.keys(rates[@rates]) |> Enum.join(",") |> IO.puts()
      end

      get_currency(rates, hint)
    else
      {currency, rates[@rates][currency]}
    end
  end

  def handle(parsed) do
    case parsed do
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
  end

  def input(hint) do
    IO.gets(hint)
    |> String.trim()
    |> Float.parse()
    |> handle()
  end

  def format(num) do
    (num + 0.0) |> :erlang.float_to_binary(decimals: 2)
  end

  def start(_type, _args) do
    children = []

    rates =
      case File.read(@cache) do
        {:ok, result} -> result |> :erlang.binary_to_term()
        _ -> nil
      end

    duration =
      case rates do
        nil ->
          nil

        _ ->
          {:ok, now} = DateTime.now("Etc/UTC")
          cached_ts = DateTime.from_unix!(rates[@ts])
          DateTime.diff(now, cached_ts)
      end

    rates =
      if rates == nil or duration >= @expiration do
        if rates == nil do
          IO.puts("Local cache not found.")
        else
          IO.puts("Local cache is outdated.")
        end

        IO.puts("Try updating from OpenExchangeRates...")

        rates =
          HTTPoison.get!("https://openexchangerates.org/api/latest.json?app_id=#{@appid}")
          |> Map.get(:body)
          |> Jason.decode!()

        File.write!(@cache, :erlang.term_to_binary(rates))

        IO.puts("Update completed.")
        rates
      else
        rates
      end

    {from, from_rate} =
      get_currency(rates, "From which currency? (h for all available currencies) ")

    {to, to_rate} = get_currency(rates, "To which currency? (h for all available currencies) ")
    exchange_rate = 100 * (to_rate / from_rate)

    money = input("How much #{from} are you exchanging? ")
    to_money = money * exchange_rate / 100

    IO.puts(
      "#{format(money)} #{from} at an exchange rate of #{format(exchange_rate)} is #{
        format(to_money)
      } #{to}."
    )

    opts = [strategy: :one_for_one, name: CurrencyConversion.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
