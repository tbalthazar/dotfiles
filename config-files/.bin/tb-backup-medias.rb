#!/usr/bin/env ruby

if ARGV[0].nil?
  puts "Error. Usage : tb-backup-medias.rb /path/to/dest"
  exit
end

to = ARGV[0]
unless File.exists?(to)
  puts "#{to} do not exist"
  exit
end

# https://help.ubuntu.com/community/rsync

RSYNC_CMD = 'rsync --delete -azvv'

# --delete deletes files that don't exist on the system being backed up.(Optional)
# 
# -a preserves the date and times, and permissions of the files (same as -rlptgoD).
# With this option rsync will:
# 
#     Descend recursively into all directories (-r),
# 
#     copy symlinks as symlinks (-l),
# 
#     preserve file permissions (-p),
# 
#     preserve modification times (-t),
# 
#     preserve groups (-g),
# 
#     preserve file ownership (-o), and
# 
#     preserve devices as devices (-D). 
# 
# -z compresses the data
# 
# -vv increases the verbosity of the reporting process 

from = Dir.home
log_file = File.join(to, 'TBBackupMedias.log')

media_dirs = [
  'Pictures/Photos',
  'Music/Music',
  'Videos'
]

sources = media_dirs.map { |dir| "#{from}/#{dir}" }.join(' ')

cmd = "#{RSYNC_CMD} #{sources} #{to}"
puts cmd
system(cmd)

# get exit status and notify
process_status = $?

if process_status.success?
  msg = "Succeeded."
  urgency = "normal"
else
  msg = "Error code : #{process_status.exitstatus}"
  urgency = "critical"
end

system("notify-send 'tb-backup' '#{msg}' -t #{1000 * 3600} -u #{urgency}")

# write to log file
File.open(log_file, 'a+') do |file|
  file.puts "#{Time.now} - in #{to} - #{msg}"
end
