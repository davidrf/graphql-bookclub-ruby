class Types::RepositoryCollaboratorsEdgeType < GraphQL::Types::Relay::BaseEdge
  node_type(Types::UserType)

  field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  field :id, ID, null: false
end