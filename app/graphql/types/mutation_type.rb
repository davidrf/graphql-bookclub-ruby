class Types::MutationType < Types::BaseObject
  field :create_user, Types::CreateUserPayloadType, null: true do
    argument :input, Types::CreateUserInputType, required: true
  end
  
  def create_user(**args)
    Mutations::CreateUser.perform(
      **args,
      context: context,
      object: object,
    )
  end
end
