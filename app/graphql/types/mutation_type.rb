class Types::MutationType < Types::BaseObject
  field :create_user, Types::CreateUserPayloadType, null: true do
    argument :input, Types::CreateUserInputType, required: true
  end
  
  def create_user(input:)
    {
      user: User.create(input.to_h)
    }
  end
end
