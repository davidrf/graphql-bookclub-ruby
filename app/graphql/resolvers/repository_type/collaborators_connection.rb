class Resolvers::RepositoryType::CollaboratorsConnection
  include Resolver
  alias_method :repository, :object

  def perform
    repository.collaborators
  end
end