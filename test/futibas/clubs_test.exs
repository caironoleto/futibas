defmodule Futibas.ClubsTest do
  use Futibas.DataCase

  alias Futibas.Clubs

  describe "players" do
    alias Futibas.Clubs.Player

    @valid_attrs %{external_id: 42, name: "some name", overall: 42, positions: ["ST", "CAM"]}
    @update_attrs %{
      external_id: 43,
      name: "some updated name",
      overall: 43,
      positions: ["MEI", "MC"]
    }
    @invalid_attrs %{external_id: nil, name: nil, overall: nil, positions: nil}

    def player_fixture(attrs \\ %{}) do
      {:ok, player} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Clubs.create_player()

      player
    end

    test "list_players/0 returns all players" do
      player = player_fixture()
      assert Clubs.list_players() == [player]
    end

    test "get_player!/1 returns the player with given id" do
      player = player_fixture()
      assert Clubs.get_player!(player.id) == player
    end

    test "create_player/1 with valid data creates a player" do
      assert {:ok, %Player{} = player} = Clubs.create_player(@valid_attrs)
      assert player.external_id == 42
      assert player.name == "some name"
      assert player.overall == 42
      assert player.positions == ["ST", "CAM"]
    end

    test "create_player/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Clubs.create_player(@invalid_attrs)
    end

    test "update_player/2 with valid data updates the player" do
      player = player_fixture()
      assert {:ok, %Player{} = player} = Clubs.update_player(player, @update_attrs)
      assert player.external_id == 43
      assert player.name == "some updated name"
      assert player.overall == 43
      assert player.positions == ["MEI", "MC"]
    end

    test "update_player/2 with invalid data returns error changeset" do
      player = player_fixture()
      assert {:error, %Ecto.Changeset{}} = Clubs.update_player(player, @invalid_attrs)
      assert player == Clubs.get_player!(player.id)
    end

    test "delete_player/1 deletes the player" do
      player = player_fixture()
      assert {:ok, %Player{}} = Clubs.delete_player(player)
      assert_raise Ecto.NoResultsError, fn -> Clubs.get_player!(player.id) end
    end

    test "change_player/1 returns a player changeset" do
      player = player_fixture()
      assert %Ecto.Changeset{} = Clubs.change_player(player)
    end
  end
end
