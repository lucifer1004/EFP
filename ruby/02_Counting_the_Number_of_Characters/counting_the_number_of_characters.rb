print "What is the input string? "
input = gets().strip
len = input.length
puts "#{input} has #{len} character#{len != 1 ? "s" : ""}."
