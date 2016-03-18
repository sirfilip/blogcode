module Taskr

  def task_repo 
    @task_repo ||= {}
  end
  
  def desc(task_description)
    @task_description = task_description
  end

  def task(task_name, &task_action)
    task_repo[task_name] = {
      "action" => task_action,
      "description" => @task_description || ""
    }
    # reset the description 
    @task_description = ''
  end

  def run_task(task_name)
    task_repo[task_name]['action'].call
  end

end
include Taskr

desc "This is the first task"
task :my_first_task do 
  puts "This is my first task"
end

puts task_repo.inspect

run_task :my_first_task
