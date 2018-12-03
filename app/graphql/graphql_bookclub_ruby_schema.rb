class GraphqlBookclubRubySchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  lazy_resolve(BatchLoader::GraphQL::Wrapper, :sync)
end
