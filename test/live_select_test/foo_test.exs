defmodule LiveSelectTest.FooTest do
  use LiveSelectTest.DataCase

  alias LiveSelectTest.Foo

  describe "foobars" do
    alias LiveSelectTest.Foo.Foobar

    import LiveSelectTest.FooFixtures

    @invalid_attrs %{}

    test "list_foobars/0 returns all foobars" do
      foobar = foobar_fixture()
      assert Foo.list_foobars() == [foobar]
    end

    test "get_foobar!/1 returns the foobar with given id" do
      foobar = foobar_fixture()
      assert Foo.get_foobar!(foobar.id) == foobar
    end

    test "create_foobar/1 with valid data creates a foobar" do
      valid_attrs = %{}

      assert {:ok, %Foobar{} = foobar} = Foo.create_foobar(valid_attrs)
    end

    test "create_foobar/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Foo.create_foobar(@invalid_attrs)
    end

    test "update_foobar/2 with valid data updates the foobar" do
      foobar = foobar_fixture()
      update_attrs = %{}

      assert {:ok, %Foobar{} = foobar} = Foo.update_foobar(foobar, update_attrs)
    end

    test "update_foobar/2 with invalid data returns error changeset" do
      foobar = foobar_fixture()
      assert {:error, %Ecto.Changeset{}} = Foo.update_foobar(foobar, @invalid_attrs)
      assert foobar == Foo.get_foobar!(foobar.id)
    end

    test "delete_foobar/1 deletes the foobar" do
      foobar = foobar_fixture()
      assert {:ok, %Foobar{}} = Foo.delete_foobar(foobar)
      assert_raise Ecto.NoResultsError, fn -> Foo.get_foobar!(foobar.id) end
    end

    test "change_foobar/1 returns a foobar changeset" do
      foobar = foobar_fixture()
      assert %Ecto.Changeset{} = Foo.change_foobar(foobar)
    end
  end

  describe "foobars" do
    alias LiveSelectTest.Foo.Foobar

    import LiveSelectTest.FooFixtures

    @invalid_attrs %{name: nil, other_id: nil}

    test "list_foobars/0 returns all foobars" do
      foobar = foobar_fixture()
      assert Foo.list_foobars() == [foobar]
    end

    test "get_foobar!/1 returns the foobar with given id" do
      foobar = foobar_fixture()
      assert Foo.get_foobar!(foobar.id) == foobar
    end

    test "create_foobar/1 with valid data creates a foobar" do
      valid_attrs = %{name: "some name", other_id: 42}

      assert {:ok, %Foobar{} = foobar} = Foo.create_foobar(valid_attrs)
      assert foobar.name == "some name"
      assert foobar.other_id == 42
    end

    test "create_foobar/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Foo.create_foobar(@invalid_attrs)
    end

    test "update_foobar/2 with valid data updates the foobar" do
      foobar = foobar_fixture()
      update_attrs = %{name: "some updated name", other_id: 43}

      assert {:ok, %Foobar{} = foobar} = Foo.update_foobar(foobar, update_attrs)
      assert foobar.name == "some updated name"
      assert foobar.other_id == 43
    end

    test "update_foobar/2 with invalid data returns error changeset" do
      foobar = foobar_fixture()
      assert {:error, %Ecto.Changeset{}} = Foo.update_foobar(foobar, @invalid_attrs)
      assert foobar == Foo.get_foobar!(foobar.id)
    end

    test "delete_foobar/1 deletes the foobar" do
      foobar = foobar_fixture()
      assert {:ok, %Foobar{}} = Foo.delete_foobar(foobar)
      assert_raise Ecto.NoResultsError, fn -> Foo.get_foobar!(foobar.id) end
    end

    test "change_foobar/1 returns a foobar changeset" do
      foobar = foobar_fixture()
      assert %Ecto.Changeset{} = Foo.change_foobar(foobar)
    end
  end
end
