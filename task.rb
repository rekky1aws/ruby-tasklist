class Task
	@@id = 0
	def initialize(name, priority = 1, description = "", done = false)
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

	def to_s
		result = "Task :\n"
		result += "\tID : " + @id.to_s + "\n"
		result += "\tName : " + @name + "\n"
		result += "\tDescription : " + @description + "\n"
		result += "\tPriority Level : " + @priority.to_s + "\n"
		result += "\tStatus : "
		result += @done ? "Done" : "To Do"
		result += "\n"
	end
end