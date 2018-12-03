class Types::QueryType < Types::BaseObject
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  field :users, [Types::UserType], null: false
  def users
    User.all
  end

  field :user, Types::UserType, null: true do
    argument :id, ID, required: true
  end
  def user(id:)
    User.find(id)
  rescue ActiveRecord::RecordNotFound => error
    raise GraphQL::ExecutionError.new(
      error.message,
      extensions: { "code" => "NOT_FOUND" }
    )
  end

  field :repository, Types::RepositoryType, null: true do
    argument :id, ID, required: true
  end
  def repository(id:)
    Repository.find(id)
  rescue ActiveRecord::RecordNotFound => error
    raise GraphQL::ExecutionError.new(
      error.message,
      extensions: { "code" => "NOT_FOUND" }
    )
  end
end
