defmodule Input do
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

  def query_shape(res) do
    case res do
      "r" -> "r"
      "o" -> "o"
      "l" -> "l"
      _ -> IO.gets("What shape is your room? [r/o/l] ") |> String.trim() |> query_shape()
    end
  end

  def query_rectangle() do
    width = input("What is the width in feet? ")
    len = input("What is the length in feet? ")
    width * len
  end

  def query_round() do
    radius = input("What is the radius in feet? ")
    radius * radius * :math.pi()
  end

  def query_lshape() do
    outer_width = input("What is the outer width in feet? ")
    outer_length = input("What is the outer length in feet? ")
    inner_width = input("What is the inner width in feet? ")

    if inner_width >= outer_width do
      IO.puts("Inner width must not exceed outer width.")
      exit(:shutdown)
    end

    inner_length = input("What is the inner length in feet? ")

    if inner_length >= outer_length do
      IO.puts("Inner length must not exceed outer length.")
      exit(:shutdown)
    end

    outer_width * outer_length - inner_width * inner_length
  end
end

shape = Input.query_shape("")
paint = 350

area =
  case shape do
    "r" -> Input.query_rectangle()
    "o" -> Input.query_round()
    "l" -> Input.query_lshape()
  end

gallon = Kernel.ceil(area / paint)

IO.puts(
  "You will neet to purchase #{gallon} gallon#{
    if gallon == 1 do
      ""
    else
      "s"
    end
  } of paint to cover #{area} square feet."
)
