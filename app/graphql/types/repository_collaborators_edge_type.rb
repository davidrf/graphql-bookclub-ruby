class Types::RepositoryCollaboratorsEdgeType < GraphQL::Types::Relay::BaseEdge
  node_type(Types::UserType)
end