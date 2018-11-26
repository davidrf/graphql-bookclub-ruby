class Types::CreateUserInputType < Types::BaseInputObject
  argument :bio, String, required: false
  argument :first_name, String, required: true
  argument :last_name, String, required: true
  argument :picture_url, String, required: false
  argument :username, String, required: true
end
