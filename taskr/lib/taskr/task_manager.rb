module Taskr

  class TaskManager
  
    def initialize
      @data = {}
    end
    
    def register(task, deps=[])
      raise ArgumentError.new('Can register only instances of Taskr::Task') unless task.is_a? Task
      @data[task.name] = {:task => task, :deps => deps}
      true
    end
    
    def tasks
      @data.values.map {|task_record| task_record[:task]}
    end
    
    def run(task_name)
      task_record = find_by_name(task_name)
      task_record[:deps].each { |task_dep_name| run(task_dep_name) }
      task_record[:task].run
    end
    
    private 
    
    def find_by_name(task_name)
      task = @data.fetch(task_name, nil)
      raise TaskNotFoundError.new("Task with name '#{task_name}' could not be found") if task.nil?
      task
    end
  
  end


end
