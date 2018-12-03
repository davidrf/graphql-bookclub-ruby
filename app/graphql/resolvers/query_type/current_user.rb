class Resolvers::QueryType::CurrentUser
  include Resolver

  def perform
    current_user
  end
end