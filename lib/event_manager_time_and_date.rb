require 'csv'
require 'date'
require 'erb'

puts 'EventManager Assignments initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

hours = Hash.new(0)
days = Hash.new(0)

def get_hour_of_reg_day(time, hours)
  time = DateTime.strptime(time, '%m/%d/%y %H:%M').hour
  hours[time] += 1
end

def print_table_of_hours_and_weekdays(hours, days)
  hours = hours.sort.to_h
  days = days.sort.to_h
  hour_and_day_template = File.read('hours_and_days_table.erb')
  erb_template = ERB.new hour_and_day_template
  hour_and_day_table = erb_template.result(binding)

  filename = 'hours_and_days_table.html'

  File.open(filename, 'w') do |file|
    file.puts hour_and_day_table
  end
end

def get_weekday_of_reg_day(day, days)
  weekday = Date.strptime(day, '%m/%d/%y').wday
  # puts date
  days[weekday] += 1
end

contents.each do |row|
  get_hour_of_reg_day(row[:regdate], hours)
  get_weekday_of_reg_day(row[:regdate], days)
end

print_table_of_hours_and_weekdays(hours, days)
puts 'table printed'
