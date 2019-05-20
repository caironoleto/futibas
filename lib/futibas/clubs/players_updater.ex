defmodule Futibas.Clubs.PlayersUpdater do
  @moduledoc """
  Find and update players information from https://sofifa.com.
  """

  @url "https://sofifa.com/players?column=oa&sort=desc&col=oa&offset="

  alias Futibas.Clubs

  def search_and_update do
    case HTTPoison.get(@url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
        |> find_and_prepare_players()
        |> Clubs.create_or_update_players()

      {:error, error} ->
        {:error, error}
    end
  end

  defp find_and_prepare_players(body) do
    body
    |> Floki.find(".table tbody tr")
    |> process_players([])
  end

  defp process_players([], players) do
    players
  end

  defp process_players([body | tail], players) do
    processed_players =
      players
      |> fill_name(body)
      |> fill_overall(body)
      |> fill_position(body)
      |> fill_external_id(body)

    process_players(tail, processed_players)
  end

  defp fill_name(players, body) do
    name = find_text(body, "td:nth-child(2) .col-name > a:nth-child(2)")

    [%{name: name} | players]
  end

  defp fill_overall([player | players], body) do
    overall = find_text(body, ".col-digit.col-oa span")

    [Map.put(player, :overall, overall) | players]
  end

  defp fill_position([player | players], body) do
    [Map.put(player, :positions, find_positions(body)) | players]
  end

  defp fill_external_id([player | players], body) do
    external_id =
      body
      |> Floki.attribute("td:nth-child(2) .col-name > a:nth-child(2)", "href")
      |> List.first()
      |> String.replace(~r/\/player\/(\d+).*/, "\\g{1}", global: false)

    [Map.put(player, :external_id, external_id) | players]
  end

  defp find_text(body, element) do
    body
    |> Floki.find(element)
    |> Floki.text()
  end

  defp find_positions(body) do
    body
    |> Floki.find(".col-name > div span")
    |> Enum.map(fn span -> Floki.text(span) end)
  end
end
