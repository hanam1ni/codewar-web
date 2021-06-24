defmodule CodewarWeb.Api.PrimeController do
  use CodewarWeb, :controller

  def verify_answer(conn, %{"answer" => answer}) do
    prime_number_list = convert_to_list(prime_number_config())

    case prime_number_list[answer] do
      match when is_binary(match) ->
        conn
        |> put_status(:ok)
        |> text(match)

      _ ->
        conn
        |> put_status(:unprocessable_entity)
        |> text("That's not the valid prime number pal. Try again.")
    end
  end

  defp prime_number_config do
    Application.get_env(:codewar, CodewarWeb.Api)[:prime_numbers]
  end

  defp convert_to_list(config_data) when is_nil(config_data), do: []

  defp convert_to_list(config_data) do
    config_data
    |> String.split(",")
    |> Enum.reduce(%{}, fn number_pair, config_list ->
      [key, value] = String.split(number_pair, "=>")
      Map.put(config_list, "#{key}", value)
    end)
  end
end
