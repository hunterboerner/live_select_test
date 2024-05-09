defmodule LiveSelectTestWeb.FoobarLiveTest do
  use LiveSelectTestWeb.ConnCase

  import Phoenix.LiveViewTest
  import LiveSelectTest.FooFixtures

  @create_attrs %{name: "some name", other_id: 42}
  @update_attrs %{name: "some updated name", other_id: 43}
  @invalid_attrs %{name: nil, other_id: nil}

  defp create_foobar(_) do
    foobar = foobar_fixture()
    %{foobar: foobar}
  end

  describe "Index" do
    setup [:create_foobar]

    test "lists all foobars", %{conn: conn, foobar: foobar} do
      {:ok, _index_live, html} = live(conn, ~p"/foobars")

      assert html =~ "Listing Foobars"
      assert html =~ foobar.name
    end

    test "saves new foobar", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/foobars")

      assert index_live |> element("a", "New Foobar") |> render_click() =~
               "New Foobar"

      assert_patch(index_live, ~p"/foobars/new")

      assert index_live
             |> form("#foobar-form", foobar: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#foobar-form", foobar: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/foobars")

      html = render(index_live)
      assert html =~ "Foobar created successfully"
      assert html =~ "some name"
    end

    test "updates foobar in listing", %{conn: conn, foobar: foobar} do
      {:ok, index_live, _html} = live(conn, ~p"/foobars")

      assert index_live |> element("#foobars-#{foobar.id} a", "Edit") |> render_click() =~
               "Edit Foobar"

      assert_patch(index_live, ~p"/foobars/#{foobar}/edit")

      assert index_live
             |> form("#foobar-form", foobar: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#foobar-form", foobar: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/foobars")

      html = render(index_live)
      assert html =~ "Foobar updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes foobar in listing", %{conn: conn, foobar: foobar} do
      {:ok, index_live, _html} = live(conn, ~p"/foobars")

      assert index_live |> element("#foobars-#{foobar.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#foobars-#{foobar.id}")
    end
  end

  describe "Show" do
    setup [:create_foobar]

    test "displays foobar", %{conn: conn, foobar: foobar} do
      {:ok, _show_live, html} = live(conn, ~p"/foobars/#{foobar}")

      assert html =~ "Show Foobar"
      assert html =~ foobar.name
    end

    test "updates foobar within modal", %{conn: conn, foobar: foobar} do
      {:ok, show_live, _html} = live(conn, ~p"/foobars/#{foobar}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Foobar"

      assert_patch(show_live, ~p"/foobars/#{foobar}/show/edit")

      assert show_live
             |> form("#foobar-form", foobar: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#foobar-form", foobar: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/foobars/#{foobar}")

      html = render(show_live)
      assert html =~ "Foobar updated successfully"
      assert html =~ "some updated name"
    end
  end
end
