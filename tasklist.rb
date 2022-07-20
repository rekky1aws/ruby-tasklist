require './task.rb'
require './to_bool.rb'

tasklist = []

def puts_arr (array)
	result = "["
	array.length.times do |i|
		result += "\""
		result += array[i]
		result += "\""
		if i < array.length - 1
			result += ", "
		end
	end
	result += "]"
	puts result
end

def get_stored_tasks
	result = []
	stored_tasks = File.open("task_data.csv").read.split("\n")
	stored_tasks.each do |element|
		task_data = element.split(", ")
		if task_data.length == 4
			result += [Task.new(task_data[0].to_i, task_data[1], task_data[2].to_boolean, task_data[3])]
		elsif task_data.length == 3
			result += [Task.new(task_data[0].to_i, task_data[1], task_data[2].to_boolean)]
		elsif task_data.length == 2
			result += [Task.new(task_data[0].to_i, task_data[1])]
		else
			puts "Error while parsing data"
			return false
		end
	end
	return result
end
	
tasklist = get_stored_tasks

tasklist.each do |task|
	puts " -----"
	task.display_infos
end
puts " -----"
