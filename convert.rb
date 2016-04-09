#!/usr/bin/env ruby

# Harvest format http://www.getharvest.com/help/account-settings/managing-account-settings/importing-and-exporting-data
# Date (YYYY-MM-DD or M/D/YYYY formats. For example: 2008-08-25 or 8/25/2008)
# Client
# Project
# Task
# Note
# Hours (in decimal form, without any stray characters. For example: 7.5, 3, 9.9)
# First name
# Last name

# Toggl format
# 0-User,1-Email,2-Client,3-Project,4-Task,5-Description,6-Billable,7-Start date,8-Start time,9-End date,10-End time,11-Duration,12-Tags,13-Amount (USD)
# Bryan Wilson,bryan@woollyandwise.com,,YES! Magazine,,Fix tablet display issues,Yes,2015-08-07,15:20:32,2015-08-07,15:20:34,00:00:02,,0.00

require 'csv'
require 'date'


def clean_value(value, default)
  return default if value.nil? || (value.is_a?(String) && value.empty?)
  value
end

fname = $*[0]
user_first_name = $*[1]
user_last_name = $*[2]

fout = fname.gsub(".csv", "_harvest.csv")
output = ["date, client, project, task, note, hours, first name, last name".split(",")]
c = CSV.open(fname)
c.drop(1).each do |row|
	tmp = row[11].split(":")

	duration = sprintf('%0.2f',tmp[0].to_f + (tmp[1].to_f/60.0) + (tmp[2].to_f/3600.0))
	date = DateTime.parse(row[7]).strftime("%Y-%m-%d")
  output << [date, 
             clean_value(row[2], "No Client"), 
             clean_value(row[3], "No Project"), 
             clean_value(row[4], "No Task"),
             row[5], 
             duration, 
             user_first_name, 
             user_last_name]
end

`rm #{fout}`
`touch #{fout}`

CSV.open(fout, "wb") do |csv|
  output.each do |row|
    csv << row
  end
end
puts `cat #{fout}`
