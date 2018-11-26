class Types::MutationType < Types::BaseObject
  # TODO: remove me
  field :test_field, String, null: false,
    description: "An example field added by the generator"
  def test_field
    "Hello World"
  end

  field :create_user, Types::CreateUserPayloadType, null: true do
    argument :input, Types::CreateUserInputType, required: true
  end
  
  def create_user(input:)
    {
      user: User.create(input.to_h)
    }
  end
end
