defmodule Painsnakes.PainpointsTest do
  use Painsnakes.DataCase

  alias Painsnakes.Painpoints

  describe "painsnakes" do
    alias Painsnakes.Painpoints.Painsnake

    import Painsnakes.PainpointsFixtures

    @invalid_attrs %{category_name: nil}

    test "list_painsnakes/0 returns all painsnakes" do
      painsnake = painsnake_fixture()
      assert Painpoints.list_painsnakes() == [painsnake]
    end

    test "get_painsnake!/1 returns the painsnake with given id" do
      painsnake = painsnake_fixture()
      assert Painpoints.get_painsnake!(painsnake.id) == painsnake
    end

    test "create_painsnake/1 with valid data creates a painsnake" do
      valid_attrs = %{category_name: "some category_name"}

      assert {:ok, %Painsnake{} = painsnake} = Painpoints.create_painsnake(valid_attrs)
      assert painsnake.category_name == "some category_name"
    end

    test "create_painsnake/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Painpoints.create_painsnake(@invalid_attrs)
    end

    test "update_painsnake/2 with valid data updates the painsnake" do
      painsnake = painsnake_fixture()
      update_attrs = %{category_name: "some updated category_name"}

      assert {:ok, %Painsnake{} = painsnake} = Painpoints.update_painsnake(painsnake, update_attrs)
      assert painsnake.category_name == "some updated category_name"
    end

    test "update_painsnake/2 with invalid data returns error changeset" do
      painsnake = painsnake_fixture()
      assert {:error, %Ecto.Changeset{}} = Painpoints.update_painsnake(painsnake, @invalid_attrs)
      assert painsnake == Painpoints.get_painsnake!(painsnake.id)
    end

    test "delete_painsnake/1 deletes the painsnake" do
      painsnake = painsnake_fixture()
      assert {:ok, %Painsnake{}} = Painpoints.delete_painsnake(painsnake)
      assert_raise Ecto.NoResultsError, fn -> Painpoints.get_painsnake!(painsnake.id) end
    end

    test "change_painsnake/1 returns a painsnake changeset" do
      painsnake = painsnake_fixture()
      assert %Ecto.Changeset{} = Painpoints.change_painsnake(painsnake)
    end
  end

  describe "painpoints" do
    alias Painsnakes.Painpoints.Painpoint

    import Painsnakes.PainpointsFixtures

    @invalid_attrs %{description: nil, creation_date: nil}

    test "list_painpoints/0 returns all painpoints" do
      painpoint = painpoint_fixture()
      assert Painpoints.list_painpoints() == [painpoint]
    end

    test "get_painpoint!/1 returns the painpoint with given id" do
      painpoint = painpoint_fixture()
      assert Painpoints.get_painpoint!(painpoint.id) == painpoint
    end

    test "create_painpoint/1 with valid data creates a painpoint" do
      valid_attrs = %{description: "some description", creation_date: ~U[2024-10-25 19:46:00Z]}

      assert {:ok, %Painpoint{} = painpoint} = Painpoints.create_painpoint(valid_attrs)
      assert painpoint.description == "some description"
      assert painpoint.creation_date == ~U[2024-10-25 19:46:00Z]
    end

    test "create_painpoint/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Painpoints.create_painpoint(@invalid_attrs)
    end

    test "update_painpoint/2 with valid data updates the painpoint" do
      painpoint = painpoint_fixture()
      update_attrs = %{description: "some updated description", creation_date: ~U[2024-10-26 19:46:00Z]}

      assert {:ok, %Painpoint{} = painpoint} = Painpoints.update_painpoint(painpoint, update_attrs)
      assert painpoint.description == "some updated description"
      assert painpoint.creation_date == ~U[2024-10-26 19:46:00Z]
    end

    test "update_painpoint/2 with invalid data returns error changeset" do
      painpoint = painpoint_fixture()
      assert {:error, %Ecto.Changeset{}} = Painpoints.update_painpoint(painpoint, @invalid_attrs)
      assert painpoint == Painpoints.get_painpoint!(painpoint.id)
    end

    test "delete_painpoint/1 deletes the painpoint" do
      painpoint = painpoint_fixture()
      assert {:ok, %Painpoint{}} = Painpoints.delete_painpoint(painpoint)
      assert_raise Ecto.NoResultsError, fn -> Painpoints.get_painpoint!(painpoint.id) end
    end

    test "change_painpoint/1 returns a painpoint changeset" do
      painpoint = painpoint_fixture()
      assert %Ecto.Changeset{} = Painpoints.change_painpoint(painpoint)
    end
  end
end
