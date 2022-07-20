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

def display_menu
	puts "########## Menu ##########"
	puts "1 - Display Tasks"
	puts "2 - Add Task"

	puts "\n0 - Quit"
	puts "\nChoose between the options above :"
end
	
# Reading file to get saved tasks
tasklist = get_stored_tasks

puts "Name the file to load tasks from (default = task_data.csv) :"
load_location = gets.chomp
if load_location == ""
	load_location = "task_data.csv"
end

puts "Loaded tasks from #{load_location}\n\n"

choice = -1
while choice !=0
	display_menu
	choice = gets.chomp.to_i
	puts "##########################"

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
		tasklist = add_task(tasklist)

	else
		puts "#{choice} is not a valid command."
	end 
end



# Saving all tasks to task_data.csv
save_tasks(tasklist)
