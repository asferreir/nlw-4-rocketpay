defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase

  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "when all params are valid, return an user" do
      params = %{
        name: "Anderson",
        password: "123456",
        nickname: "havour",
        email: "havour@gmail.com",
        age: 37
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "Anderson", age: 37, id: ^user_id} = user
    end

    test "when there are invalid params, return an error" do
      params = %{
        name: "Anderson",
        nickname: "havour",
        email: "havour@gmail.com",
        age: 15
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["can't be blank"]
      }

      assert errors_on(changeset) == expected_response
    end

  end

end
