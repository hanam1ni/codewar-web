defmodule CodewarWeb.Api.PrimeRequestTest do
  use CodewarWeb.ConnCase, async: true

  setup do
    Application.put_env(:codewar, CodewarWeb.Api, prime_numbers: "97=>804")
  end

  describe "post verify_answer/2" do
    test "responds with 200 given a valid answer", %{conn: conn} do
      conn = post(conn, Routes.prime_path(conn, :verify_answer, "97"))

      assert conn.status == 200
    end

    test "responds with the value for which there is match a valid answer", %{conn: conn} do
      conn = post(conn, Routes.prime_path(conn, :verify_answer, "97"))

      assert conn.resp_body == "804"
    end

    test "responds with 422 given an invalid answer", %{conn: conn} do
      conn = post(conn, Routes.prime_path(conn, :verify_answer, "100"))

      assert conn.status == 422
    end
  end
end
