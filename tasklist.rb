#! /usr/local/bin/ruby

require './task.rb'
require './to_bool.rb'
require './lib.rb'

tasklist = []

def display_all_tasks (tasklist)
	tasklist.each do |task|
		puts " -----"
		puts task.to_s
	end
	puts " -----"
end

def display_tasks_by_status (tasklist, status = false)
	tasklist.each do |task|
		if task.is_done == status
			puts " -----"
			puts task.to_s
		end
	end
	puts " -----"
end


def get_stored_tasks (location = "task_data.csv")
	result = []
	# Reading all data from file
	stored_tasks = File.read(location).split("\n")

	# Each line represents a Task
	stored_tasks.each do |element|
		task_data = element.split(",")
		if task_data.length == 4
			result += [Task.new(task_data[0], task_data[1].to_i, task_data[2], task_data[3].to_boolean)]
		elsif task_data.length == 3
			result += [Task.new(task_data[0], task_data[1].to_i, task_data[2])]
		elsif task_data.length == 2
			result += [Task.new(task_data[0], task_data[1].to_i)]
		elsif task_data.length == 1
			result += [Task.new(task_data[0])]
		else
			# If line isn't the right size.
			puts "Error while parsing data"
			return false
		end
	end
	return result
end

def save_tasks (tasklist, location = "task_data.csv")
	result = ""
	tasklist.each do |task_element|
		done_flag = task_element.is_done ? "true" : "false" 
		result += task_element.get_name + "," + task_element.get_priority.to_s + "," + task_element.get_description + "," + done_flag + "\n"
	end
	File.write(location, result)
end

def add_task (tasklist)
	puts "Task Name :"
	task_name = gets.chomp
	puts "Task Description (just press enter if you don't want to add any description) :"
	task_desc = gets.chomp
	puts "Priority level (integer > 0, default is 1) :"
	task_priority = gets.chomp.to_i
	tasklist += [Task.new(task_name, task_priority, task_desc)]
	puts "Created Task :"
	puts tasklist[tasklist.length - 1].to_s
	return tasklist
end

def remove_task (tasklist)
	if tasklist.length == 0
		puts "There is no task to delete"
	else
		puts "ID of the task to delete :"
		task_id = gets.chomp.to_i
		if tasklist.length > task_id
			puts "Are your sure you want to delete this task :"
			puts tasklist[task_id].to_s
			puts "[y / N]"
			delete_prompt = gets.chomp.downcase
			if delete_prompt ==  'y'
				tasklist.delete_at(task_id)
				puts "Task #{task_id} deleted"
			else
				puts "Canceled task deletion"
			end
		else
			puts "No task with this ID"
		end
	end
	return tasklist
end

def update_task (tasklist)
	if tasklist.length == 0
		puts "There is no tag"
	else
		puts "ID of the task to change status :"
		task_id = gets.chomp.to_i
		if tasklist.length > task_id
			puts "Are your sure you want to change the status of this task :"
			puts tasklist[task_id].to_s
			puts "[Y / n]"
			change_prompt = gets.chomp.downcase
			if change_prompt !=  'n'
				tasklist[task_id].change_status
				status = tasklist[task_id].is_done ? "Done" : "To Do"
				puts "Task #{task_id} has changed status to \"#{status}\""
			else
				puts "Canceled task status change"
			end
		else
			puts "No task with this ID"
		end
	end
	return tasklist
end

def display_menu
	puts "\n\n########## Menu ##########"
	puts "1 - Display All Tasks"
	puts "2 - Display Tasks To Do"
	puts "3 - Display Done Tasks"
	puts "4 - Add Task"
	puts "5 - Remove Task"
	puts "6 - Change Task Status"

	puts "\n0 - Quit"
	puts "\nChoose between the options above :"
end

# Asks the name of the file to load task data
puts "Name the file to load tasks from (default = task_data.csv) :"
load_location = gets.chomp
if load_location == ""
	# Default file to load data
	load_location = "task_data.csv"
end

# Creating file if not existing
if !File.exist?(load_location)
	File.write(load_location, "")
end

# Reading file to get saved tasks
tasklist = get_stored_tasks(load_location)

puts "Loaded tasks from #{load_location}\n\n"

choice = -1
while choice !=0
	display_menu
	choice = gets.chomp.to_i
	puts "##########################\n\n\n"

	case choice
	when 0
		puts "Enter the name of the file you want to save (default = task_data.csv) :"
		save_location = gets.chomp
		if save_location == ""
			save_location = "task_data.csv"
		end
		save_tasks(tasklist, save_location)
		puts "Tasks saved to #{load_location}\n\n"
	when 1
		display_all_tasks(tasklist)
	when 2
		display_tasks_by_status(tasklist)
	when 3
		display_tasks_by_status(tasklist, true)
	when 4
		tasklist = add_task(tasklist)
	when 5
		display_all_tasks(tasklist)
		tasklist = remove_task(tasklist)
	when 6
		display_all_tasks(tasklist)
		tasklist = update_task (tasklist)

	else
		puts "#{choice} is not a valid command."
	end 
end



# Saving all tasks to task_data.csv
save_tasks(tasklist)
