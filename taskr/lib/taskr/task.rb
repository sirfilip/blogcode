module Taskr
  class Task 
    attr_reader :name, :description

    def initialize(name, action, description)
      raise ArgumentError.new('Action is not callable') unless action.respond_to? :call
      @name = name
      @action = action 
      @description = description
    end
    def run
      @action.call
    end
  end
end
