class Types::UserType < Types::BaseObject
  field :bio, String, null: true
  field :first_name, String, null: false
  field :full_name, String, null: false
  field :id, ID, null: false
  field :last_name, String, null: false
  field :picture_url, String, null: true
  field :username, String, null: false
end