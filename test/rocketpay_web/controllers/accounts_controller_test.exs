defmodule RocketpayWeb.AccountsControllerTest do
  use RocketpayWeb.ConnCase

  alias Rocketpay.{Account, User}

  describe "deposit/2" do
    setup %{conn: conn} do
      params = %{
        name: "Anderson",
        password: "123456",
        nickname: "havour",
        email: "havour@gmail.com",
        age: 37
      }

      {:ok, %User{account: %Account{id: account_id}}} = Rocketpay.create_user(params)

      conn = put_req_header(conn, "authorization", "Basic YW5kZXJzb246MTIzNDU2")

      {:ok, conn: conn, account_id: account_id}
    end

    test "when all params are valid, make the deposit", %{conn: conn, account_id: account_id} do
      params = %{"value" => "50.00"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(:ok)

      assert response == "banana"

      # assert %{
      #   "account" => %{"balance" => "50.00", "id" => _id},
      #   "message" => "Balance changed sucessfully"
      # } = response
    end
  end
end
