class Types::RepositoryType < Types::BaseObject
  field :id, ID, null: false
  field :name, String, null: false
  field :user, Types::UserType, null: false

  def user
    Resolvers::RepositoryType::User.perform(
      context: context,
      object: object,
    )
  end
end