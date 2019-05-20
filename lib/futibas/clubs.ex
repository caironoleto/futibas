defmodule Futibas.Clubs do
  @moduledoc """
  The Clubs context.
  """

  import Ecto.Query, warn: false
  alias Futibas.Repo

  alias Futibas.Clubs.Player

  @doc """
  Returns the list of players.

  ## Examples

      iex> list_players()
      [%Player{}, ...]

  """
  def list_players do
    Repo.all(Player)
  end

  @doc """
  Gets a single player.

  Raises `Ecto.NoResultsError` if the Player does not exist.

  ## Examples

      iex> get_player!(123)
      %Player{}

      iex> get_player!(456)
      ** (Ecto.NoResultsError)

  """
  def get_player!(id), do: Repo.get!(Player, id)

  @doc """
  Creates a player.

  ## Examples

      iex> create_player(%{field: value})
      {:ok, %Player{}}

      iex> create_player(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_player(attrs \\ %{}) do
    %Player{}
    |> Player.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a player.

  ## Examples

      iex> update_player(player, %{field: new_value})
      {:ok, %Player{}}

      iex> update_player(player, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_player(%Player{} = player, attrs) do
    player
    |> Player.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Player.

  ## Examples

      iex> delete_player(player)
      {:ok, %Player{}}

      iex> delete_player(player)
      {:error, %Ecto.Changeset{}}

  """
  def delete_player(%Player{} = player) do
    Repo.delete(player)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking player changes.

  ## Examples

      iex> change_player(player)
      %Ecto.Changeset{source: %Player{}}

  """
  def change_player(%Player{} = player) do
    Player.changeset(player, %{})
  end

  @doc """
  Create or update the given players.
  """
  def create_or_update_players([]) do
    IO.inspect("finished")
  end

  def create_or_update_players([%{} = player_changset | players]) do
    result =
      case Repo.get_by(Player, external_id: player_changset.external_id) do
        nil -> %Player{}
        player -> player
      end
      |> Player.changeset(player_changset)
      |> Repo.insert_or_update()

    case result do
      {:ok, player} -> IO.inspect(":ok - #{player.name}")
      {:error, _} -> IO.inspect(":error - #{player_changset.name}")
    end

    create_or_update_players(players)
  end
end
