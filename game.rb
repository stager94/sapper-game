require_relative "field"

field = Field.new

if !field.valid?
  puts "\nInput data invalid!"
  STDIN.gets
  exit
end

field.display_map("with_mask")

result = "start"

until (["win","loss"] & [result]).length > 0 do
  result = field.play_round
  field.display_map
end

if result == "win"
  puts "\nYou win. Bye!"
elsif result == "loss"
  puts "\nYou lose. Bye!"
end
    
STDIN.gets