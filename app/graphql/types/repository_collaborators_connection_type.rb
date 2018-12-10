class Types::RepositoryCollaboratorsConnectionType < GraphQL::Types::Relay::BaseConnection
  edge_type(Types::RepositoryCollaboratorsEdgeType)

  field :total_count, Integer, null: false
  def total_count
    object.nodes.size
  end
end