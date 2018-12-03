class Resolvers::QueryType::Repository
  NOT_FOUND_MESSAGE = "repository not found"
  include Resolver

  def perform
    repository = Repository.gen(
      current_user: current_user,
      id: args[:id],
    )

    if repository.nil?
      raise GraphQL::ExecutionError.new(
        NOT_FOUND_MESSAGE,
        extensions: { "code" => "NOT_FOUND" }
      )
    end

    repository
  end
end