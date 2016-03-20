require 'spec_helper'
require 'taskr'

describe Taskr::Task do 

  it 'can be created with a name, callable action and description' do 
    begin 
      Taskr::Task.new('name', Proc.new {}, 'description')
    rescue ArgumentError  => e
      flunk("Should not raise ArgumentError")
    end
  end

  it 'must be created with a callable action' do 
    e = lambda do 
      Taskr::Task.new('name', 'something not callable', 'desc')
    end.must_raise ArgumentError
    e.message.must_equal 'Action is not callable'
  end

  it 'must run the action when we run the task' do 
    action = stub(:call => nil)
    action.expects(:call)
    task = Taskr::Task.new('name', action, 'desc')
    task.run 
  end

end
    

