def put_arr (array)
	# Display content of array like ["string", other]
	result = "["
	array.length.times do |i|
		if array[i].is_a?(String)
			result += "\""
			result += array[i]
			result += "\""
		else
			result += array[i].to_s
		end
		if i < array.length - 1
			result += ", "
		end
	end
	result += "]"
	puts result
end