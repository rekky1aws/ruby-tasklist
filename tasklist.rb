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
	stored_tasks = File.read("task_data.csv").split("\n")
	stored_tasks.each do |element|
		task_data = element.split(",")
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

def save_tasks (tasklist)
	result = ""
	tasklist.each do |task_element|
		done_flag = task_element.is_done ? "true" : "false" 
		result += task_element.get_priority.to_s + "," + task_element.get_name + "," + done_flag + "," + task_element.get_description + "\n"
	end
	File.write("task_data.csv", result)
end
	
tasklist = get_stored_tasks

tasklist.each do |task|
	puts " -----"
	task.display_infos
end
puts " -----"

tasklist += [Task.new(0, "Test", false, "Juste pour tester l'écriture du fichier")]

save_tasks(tasklist)
