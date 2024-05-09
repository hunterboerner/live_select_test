defmodule LiveSelectTest.FooFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LiveSelectTest.Foo` context.
  """

  @doc """
  Generate a foobar.
  """
  def foobar_fixture(attrs \\ %{}) do
    {:ok, foobar} =
      attrs
      |> Enum.into(%{

      })
      |> LiveSelectTest.Foo.create_foobar()

    foobar
  end
end
