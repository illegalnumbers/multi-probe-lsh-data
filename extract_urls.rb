#!/bin/ruby

num_files = 1

line_count_cutoff = 100_000
new_file = File.new("images/file_#{num_files}", 'w')

File.open('fall11_urls.txt') do |f|
 line_count = 1
 f.each_line do |line|
  if line_count % line_count_cutoff == 0
    num_files = num_files + 1
    new_file = File.new("images/file_#{num_files}", 'w')
  end

  new_file.write(line)

  line_count += 1
  if line_count % line_count_cutoff == 0
    $stdout.puts line_count
    new_file.close
  end
 end
end