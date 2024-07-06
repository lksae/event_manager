require 'csv'
require 'time'
require 'date'

puts 'EventManager Assignments initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

contents.each do |row|
  # time = DateTime.parse(row[:regdate])
  time = DateTime.strptime(row[:regdate], '%m/%d/%y %H:%M')
  puts "#{time.hour}"
end
