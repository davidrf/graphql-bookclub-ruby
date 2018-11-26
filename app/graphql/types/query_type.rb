class Types::QueryType < Types::BaseObject
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  # TODO: remove me
  field :test_field, String, null: false,
    description: "An example field added by the generator"
  def test_field
    "Hello World!"
  end

  field :my_text_field, String, null: false
  def my_text_field
    "bookclub rulz"
  end

  field :my_array_field, [String], null: false
  def my_array_field
    ["item"]
  end

  field :my_boolean_field, Boolean, null: false
  def my_boolean_field
    true
  end

  field :my_integer_field, Int, null: false
  def my_integer_field
    13
  end

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
end
