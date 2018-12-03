module Mutation
  extend ActiveSupport::Concern

  class_methods do
    def perform(args)
      new(args).perform
    end
  end

  attr_reader :context, :input, :object

  def initialize(context:, input:, object:)
    @context = context
    @input = input.to_h
    @object = object
  end

  def current_user
    context[:current_user]
  end

  def perform
    raise "subclass must define #perform"
  end

  def resolve_lazily(value)
    BatchLoader::GraphQL::Wrapper.new(value)
  end
end