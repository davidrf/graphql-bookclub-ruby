module Resolver
  extend ActiveSupport::Concern

  class_methods do
    def perform(args)
      new(args).perform
    end
  end

  attr_reader :args, :context, :object

  def initialize(context:, object:, **args)
    @args = args
    @context = context
    @object = object
  end

  def current_user
    context[:current_user]
  end

  def perform
    raise "subclass must define #perform"
  end

  def lazy_wrap(value)
    BatchLoader::GraphQL::Wrapper.new(value)
  end
end