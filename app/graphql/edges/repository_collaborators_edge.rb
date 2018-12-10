class Edges::RepositoryCollaboratorsEdge < GraphQL::Relay::Edge
  def collaboration
    @collaboration ||= begin
      repository = parent
      user = node
      Collaboration.find_by(repository: repository, user: user)
    end
  end

  def created_at
    collaboration.created_at
  end

  def id
    collaboration.id
  end
end