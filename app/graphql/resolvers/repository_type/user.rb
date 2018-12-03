class Resolvers::RepositoryType::User
  include Resolver

  def perform
    repository = object
    user = User.lazy_find(repository.user_id)
    lazy_wrap(user)
  end
end