#!/bin/ruby

num_files = 1

line_count_cutoff = ARGV[0].nil? ? 10_000 : ARGV[0].to_i
num_files_cutoff = ARGV[1].nil? ? 1000 : ARGV[1].to_i
new_file = File.new("images/file_#{num_files}", 'w')

# if original doesnt exist download original fall11_urls and unpack it
if !File.file?('fall11_urls.txt') && !File.file?('imagenet_fall11_urls.txt') && !File.file?('imagenet_fall11_urls.tgz')
  `wget http://image-net.org/imagenet_data/urls/imagenet_fall11_urls.tgz`
  `tar -xvzf imagenet_fall11_urls.tgz`
end

File.open('fall11_urls.txt') do |f|
 line_count = 1
 f.each_line do |line|
  if line_count % line_count_cutoff == 0
    # trying to not get excessive files, if you do 100 lines per file
    # with fall 11 you wind up getting 100000 files and it starts having problems
    exit(0) if num_files == num_files_cutoff
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