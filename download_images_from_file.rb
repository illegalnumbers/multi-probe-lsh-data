#!/bin/ruby

require 'open-uri'
require 'csv'

file = ARGV[0]
max_count = ARGV[1].to_i #optional
count = 0

CSV.foreach(Dir.pwd+'/'+file, { :col_sep => "\t" }) do |line|
  id = line[0]
  url = line[1]
  begin
  open(url) do |f|
    File.open("downloads/#{id}.jpg","wb") do |file|
      file.puts f.read
    end
  end

  count = count + 1
  unless max_count.nil?
    exit(0) if count >= max_count
  end
  rescue => e
    puts 'Unfortunately an error occurred downloading: ' + id
    puts 'The error was: ' + e.message
    next
  end
end