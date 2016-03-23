require 'spec_helper'


describe Taskr::TaskManager do 

  let(:task_manager) { Taskr::TaskManager.new }
  let(:task) { Taskr::Task.new('name', stub(:call => nil), 'desc') }
  
  it 'can register task' do 
        task_manager.register(task).must_equal true
  end
  
  it 'can register tasks only' do 
    e = lambda do 
      task_manager.register('something else')
    end.must_raise ArgumentError
    e.message.must_equal 'Can register only instances of Taskr::Task'
  end
  
  it 'provides access to the tasks registered' do 
    task_manager.register(task)
    task_manager.tasks.must_include task
  end
  
  it 'can find and run a task by its name' do
    task_manager.register(task)
    task.expects(:run)
    task_manager.run(task.name)
  end
  
  it 'can register task with dependencies' do
    begin 
      task_manager.register(task, [:one, :two, :three])
    rescue ArgumentError
      flunk("Should be able to register a task with its dependencies")
    end
  end
  
  it 'runs the dependencies when we run the task' do 
    dep1 = Taskr::Task.new('dep1', stub(:call => nil), '')
    dep2 = Taskr::Task.new('dep2', stub(:call => nil), '')
    task_manager.register(task, [dep1.name, dep2.name])
    task_manager.register(dep1)
    task_manager.register(dep2)
    dep1.expects(:run)
    dep2.expects(:run)
    task_manager.run(task.name)
  end

end
