require 'spec_helper'


describe Taskr::DSL do 

  include Taskr::DSL


  it 'can register tasks' do
    task :sample_task do 
      "Just a sample action"
    end 
    task_manager.tasks.find do |task| 
      task.name == :sample_task 
    end.wont_be_nil
  end
  
  it 'can register task with its dependencies' do 
    task :dep1 do 
      "Dep1"
    end
    task :the_task => :dep1 do 
      "The task"
    end
    dep1 = task_manager.tasks.find {|task| task.name == :dep1}
    dep1.expects(:run)
    task_manager.run(:the_task)
  end
  
  it 'can add a description to a task' do 
    desc "sample task description"
    task :sample_task_1 do 
      "Sample task 1"
    end
    task :sample_task_2 do 
      "Sample task 2"
    end
    task_manager.tasks.find do |task|
      task.name == :sample_task_1
    end.description.must_equal "sample task description"
    task_manager.tasks.find do |task|
      task.name == :sample_task_2
    end.description.must_equal "" 

  end

end
