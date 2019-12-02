# frozen_string_literal: true

# 1. Сделать хеш, содеращий месяцы и количество дней в месяце. В цикле выводить те месяцы, у которых количество дней ровно 30

require 'date'

def days_in_month(month)
  Date.new(Date.today.year, month, -1).day
end

months = Date::MONTHNAMES.compact
days = (1..12).map { |month| days_in_month(month) }
Hash[months.zip(days)].each do |month, number|
  puts month if number == 30
end
