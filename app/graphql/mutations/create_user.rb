class Mutations::CreateUser
  include Mutation

  def perform
    {
      user: User.create(input)
    }
  end
end