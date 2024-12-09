defmodule Painsnakes.Painpoints do
  @moduledoc """
  The Painpoints context.
  """

  import Ecto.Query, warn: false
  alias Painsnakes.Repo

  alias Painsnakes.Painpoints.Painsnake

  @doc """
  Returns the list of painsnakes.

  ## Examples

      iex> list_painsnakes()
      [%Painsnake{}, ...]

  """
  def list_painsnakes do
    Repo.all(Painsnake)
  end

  def update_painsnake(id, attrs) do
    Painsnake
    |> Repo.get!(id)
    |> Painsnake.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Gets a single painsnake.

  Raises `Ecto.NoResultsError` if the Painsnake does not exist.

  ## Examples

      iex> get_painsnake!(123)
      %Painsnake{}

      iex> get_painsnake!(456)
      ** (Ecto.NoResultsError)

  """
  def get_painsnake!(id), do: Repo.get!(Painsnake, id)

  @doc """
  Creates a painsnake.

  ## Examples

      iex> create_painsnake(%{field: value})
      {:ok, %Painsnake{}}

      iex> create_painsnake(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_painsnake(attrs \\ %{}) do
    %Painsnake{}
    |> Painsnake.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a painsnake.

  ## Examples

      iex> update_painsnake(painsnake, %{field: new_value})
      {:ok, %Painsnake{}}

      iex> update_painsnake(painsnake, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_painsnake(%Painsnake{} = painsnake, attrs) do
    painsnake
    |> Painsnake.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a painsnake.

  ## Examples

      iex> delete_painsnake(painsnake)
      {:ok, %Painsnake{}}

      iex> delete_painsnake(painsnake)
      {:error, %Ecto.Changeset{}}

  """
  def delete_painsnake(%Painsnake{} = painsnake) do
    Repo.delete(painsnake)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking painsnake changes.

  ## Examples

      iex> change_painsnake(painsnake)
      %Ecto.Changeset{data: %Painsnake{}}

  """
  def change_painsnake(%Painsnake{} = painsnake, attrs \\ %{}) do
    Painsnake.changeset(painsnake, attrs)
  end

  alias Painsnakes.Painpoints.Painpoint

  @doc """
  Returns the list of painpoints.

  ## Examples

      iex> list_painpoints()
      [%Painpoint{}, ...]

  """
  def list_painpoints do
    Repo.all(Painpoint)
  end

  @doc """
  Gets a single painpoint.

  Raises `Ecto.NoResultsError` if the Painpoint does not exist.

  ## Examples

      iex> get_painpoint!(123)
      %Painpoint{}

      iex> get_painpoint!(456)
      ** (Ecto.NoResultsError)

  """
  def get_painpoint!(id), do: Repo.get!(Painpoint, id)

  @doc """
  Creates a painpoint.

  ## Examples

      iex> create_painpoint(%{field: value})
      {:ok, %Painpoint{}}

      iex> create_painpoint(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_painpoint(attrs \\ %{}) do
    %Painpoint{}
    |> Painpoint.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a painpoint.

  ## Examples

      iex> update_painpoint(painpoint, %{field: new_value})
      {:ok, %Painpoint{}}

      iex> update_painpoint(painpoint, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_painpoint(%Painpoint{} = painpoint, attrs) do
    painpoint
    |> Painpoint.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a painpoint.

  ## Examples

      iex> delete_painpoint(painpoint)
      {:ok, %Painpoint{}}

      iex> delete_painpoint(painpoint)
      {:error, %Ecto.Changeset{}}

  """
  def delete_painpoint(%Painpoint{} = painpoint) do
    Repo.delete(painpoint)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking painpoint changes.

  ## Examples

      iex> change_painpoint(painpoint)
      %Ecto.Changeset{data: %Painpoint{}}

  """
  def change_painpoint(%Painpoint{} = painpoint, attrs \\ %{}) do
    Painpoint.changeset(painpoint, attrs)
  end
end
