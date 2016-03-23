require File.expand_path('../taskr/task', __FILE__)
require File.expand_path('../taskr/task_manager', __FILE__)
require File.expand_path('../taskr/dsl', __FILE__)

module Taskr

  class TaskNotFoundError < StandardError; end

end
