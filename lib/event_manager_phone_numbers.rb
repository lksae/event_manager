require 'csv'

puts 'EventManager Assignments initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

def clean_phone_number(phone_number)
  incoming_number = phone_number.gsub(/[^\w\s]/, '').delete(' ')
  if incoming_number.length == 10
    incoming_number
  elsif incoming_number.length == 11 && incoming_number[0] == '1'
    incoming_number.slice(1..incoming_number.length)
  elsif incoming_number.length < 10 || incoming_number.length >= 11
    'bad number'
  end
end

# If the phone number is less than 10 digits, assume that it is a bad number
# If the phone number is 10 digits, assume that it is good
# If the phone number is 11 digits and the first number is 1, trim the 1 and use the remaining 10 digits
# If the phone number is 11 digits and the first number is not 1, then it is a bad number
# If the phone number is more than 11 digits, assume that it is a bad number

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  phone_number = clean_phone_number(row[:homephone])
  puts "#{id} #{name} #{phone_number}"
end
