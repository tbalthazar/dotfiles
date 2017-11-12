#!/usr/bin/env ruby

require 'mini_exiftool'

from = ARGV[0]
to = ARGV[1]

unless from && to && Dir.exists?(from) && Dir.exists?(to)
  puts "Error. Make sure to pass 2 existing directories as arguments"
  exit
end

Dir.entries(from).each do |entry|
  # make sure it's a file
  src_path = File.join(from, entry)
  ext = File.extname(src_path).downcase
  next unless File.file?(src_path)

  # get the exif info
  begin
    exif_infos = MiniExiftool.new(src_path)
  rescue StandardError => e
    puts "Error: #{e.message}"
    puts "File: #{src_path}"
    next
  end
  create_date = exif_infos['CreateDate']
  gps_position = exif_infos['GPSPosition']

  # use the exif info to build the filename
  file_name_parts = []
  file_name_parts << create_date.to_s unless create_date.nil?
  file_name_parts << gps_position unless gps_position.nil?

  # if no exif info available, use the original file name
  if file_name_parts.empty?
    subfolder = 'unknown_date'
    file_name = entry
  else
    subfolder = create_date.strftime("%Y-%m")
    file_name = file_name_parts.join(' - ')
    file_name+= ext
  end

  # create a subfolder based on the date
  if %w{ .mov .mp4 .mpg }.include?(ext)
    video_folder_path = File.join(to, 'Videos')
    Dir.mkdir(video_folder_path, 0775) unless Dir.exists?(video_folder_path)
    subfolder_path = File.join(video_folder_path, subfolder)
  else
    subfolder_path = File.join(to, subfolder)
  end
  Dir.mkdir(subfolder_path, 0775) unless Dir.exists?(subfolder_path)
  dest_path = File.join(subfolder_path, file_name)

  # add " - 1" until the filename is unique
  while File.exists?(dest_path)
    basename = File.basename(file_name, ext)
    file_name = basename + " - 1" + ext
    dest_path = File.join(to, subfolder, file_name)
  end

  FileUtils.cp src_path, dest_path
end
