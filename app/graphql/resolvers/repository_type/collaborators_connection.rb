class Resolvers::RepositoryType::CollaboratorsConnection
  include Resolver
  alias_method :repository, :object
  DEFAULT_ORDER_BY = { direction: "ASC", field: "USERNAME" }
  ORDER_ATTRIBUTE = {
    "USERNAME" => :username
  }

  def perform
    repository.collaborators.order(order)
  end

  def order
    { ORDER_ATTRIBUTE[order_by_field] => order_by_direction }
  end

  def order_by_direction
    order_by[:direction]
  end

  def order_by_field
    order_by[:field]
  end

  def order_by
    args[:order_by] || DEFAULT_ORDER_BY
  end
end