class Task
	@@id = 0
	def initialize(priority, name, done = false, description = "")
		@id = @@id
		@@id += 1
		@name = name
		@priority = priority
		@description = description
		@done = done
	end

	def get_id
		return @id
	end

	def set_priority (priority)
		@priority = priority
		return self
	end

	def get_priority
		return @priority
	end

	def get_name
		return @name
	end

	def get_description
		return @description
	end

	def is_done
		return @done
	end

	def set_done (done)
		@done = done
		return self
	end

	def display_infos
		puts "ID : " + @id.to_s
		puts "Name : " + @name
		puts "Description : " + @description
		puts "Priority Level : " + @priority.to_s
		if @done
			puts "Fait."
		else
			puts "Pas encore fait."
		end
	end
end