defmodule RocketpayWeb.UsersViewTest do

  import Phoenix.View
  use RocketpayWeb.ConnCase

  alias Rocketpay.{User, Account}

  test "renders create.json" do
    params = %{
      name: "Anderson",
      password: "123456",
      nickname: "havour",
      email: "havour@gmail.com",
      age: 37
    }

    {:ok, %User{id: user_id, account: %Account{id: account_id}} = user} = Rocketpay.create_user(params)

    response = render(RocketpayWeb.UsersView, "create.json", user: user)

    expected_response = %{
      message: "User Created",
      user: %{
        account: %{
          balance: Decimal.new("0.00"),
          id: account_id
          },
          id: user_id,
          name: "Anderson",
          nickname: "havour"
          }
        }

    assert expected_response == response


  end

end
