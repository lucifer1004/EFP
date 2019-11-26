defmodule Gui.Scene.Home do
  use Scenic.Scene
  require Logger

  alias Scenic.Graph
  alias Scenic.ViewPort

  import Scenic.Primitives
  import Scenic.Components

  @text_size 24
  @input_width 100
  @graph Graph.build(font: :roboto, font_size: @text_size)

  # Initialize the game scene
  def init(_, opts) do
    viewport = opts[:viewport]

    # calculate the transform that centers the snake in the viewport
    {:ok, %ViewPort.Status{size: {vp_width, vp_height}}} = ViewPort.info(viewport)
    {:ok, now} = DateTime.now("Etc/UTC")

    state = %{
      year: now.year,
      current: "",
      retire: "",
      graph:
        @graph
        |> text("Retirement Calculator",
          id: :title,
          fill: :white,
          translate: {vp_width / 2, 100},
          text_align: :center
        )
        |> text("Please input your current and retire age.",
          id: :hint,
          fill: :white,
          translate: {vp_width / 2, vp_height - 100},
          text_align: :center
        )
        |> text("Current age: ",
          translate: {vp_width / 2 - 100, vp_height / 2},
          text_align: :center
        )
        |> text("Retire age: ",
          translate: {vp_width / 2 - 100, vp_height / 2 + 40},
          text_align: :center
        )
        |> text_field("",
          id: :current,
          translate: {vp_width / 2, vp_height / 2 - 20},
          width: @input_width
        )
        |> text_field("",
          id: :retire,
          translate: {vp_width / 2, vp_height / 2 + 20},
          width: @input_width
        )
    }

    {:ok, state, push: state.graph}
  end

  def filter_event({:value_changed, id, value}, _context, state) do
    state = state |> put_in([id], value)
    current = parse_input(state.current)
    retire = parse_input(state.retire)

    state =
      state
      |> put_in(
        [:graph],
        Graph.modify(
          state.graph,
          :hint,
          &text(
            &1,
            case {current, retire} do
              {:invalid, _} ->
                "Invalid input."

              {_, :invalid} ->
                "Invalid input."

              {:empty, :empty} ->
                "Please input your current and retire age."

              {:empty, _} ->
                "Please input your current age."

              {_, :empty} ->
                "Please input your retire age."

              _ ->
                "It's #{state.year}, " <>
                  cond do
                    current < retire ->
                      "so you can retire in #{state.year + retire - current}."

                    current > retire ->
                      "and you retired in #{state.year + retire - current}."

                    true ->
                      "the same year in which you can retire."
                  end
            end
          )
        )
      )

    {:noreply, state, push: state.graph}
  end

  defp parse_input(input) do
    if input == "" do
      :empty
    else
      case input |> Integer.parse() do
        :error ->
          Logger.info("Invalid input.")
          :invalid

        {int, rest} ->
          if rest != "" do
            Logger.info("#{rest} has been truncated.")
          end

          if int < 0 do
            Logger.info("Negative values are not allowed.")
            :invalid
          else
            int
          end
      end
    end
  end
end
