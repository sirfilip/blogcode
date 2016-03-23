module Taskr
  
  module DSL
  
    def task_manager
      @task_manager ||= TaskManager.new
    end
    
    def desc(description)
      @description = description
    end
    
    def task(task_name, &action)
      deps = []
      if task_name.is_a? Hash
        deps = [task_name.values.first].flatten
        task_name = task_name.keys.first
      end
      task_description = description
      reset_description
      task_manager.register(Task.new(task_name, action, task_description), deps)
    end
    
    private 
    
    def description 
      @description ||= ''
    end
    
    def reset_description
      @description = ''
    end
  
  end
  
end
