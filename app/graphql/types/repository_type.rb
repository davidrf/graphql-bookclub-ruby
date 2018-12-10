class Types::RepositoryType < Types::BaseObject
  field(
    :collaborators_connection,
    Types::UserType.connection_type,
    null: false,
  ) do
    argument :order_by, Types::UserConnectionOrderInputType, required: false
  end
  field :id, ID, null: false
  field :name, String, null: false
  field :user, Types::UserType, null: false

  def user
    Resolvers::RepositoryType::User.perform(
      context: context,
      object: object,
    )
  end

  def collaborators_connection(**args)
    Resolvers::RepositoryType::CollaboratorsConnection.perform(
      context: context,
      object: object,
      **args,
    )
  end
end