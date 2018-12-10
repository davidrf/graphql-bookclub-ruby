class Types::RepositoryCollaboratorsConnectionType < GraphQL::Types::Relay::BaseConnection
  edge_type(Types::RepositoryCollaboratorsEdgeType, edge_class: Edges::RepositoryCollaboratorsEdge)

  field :collaborators, [Types::UserType], null: false
  def collaborators
    object.edge_nodes
  end

  field :total_count, Integer, null: false
  def total_count
    object.nodes.size
  end
end