#!/usr/bin/env ruby

if ARGV[0].nil?
  puts "Error. Usage : tb-backup.rb /path/to/dest"
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

day_of_month = Time.now.strftime("%d")

from = Dir.home
log_file = File.join(to, 'TBBackup.log')
to = File.join(to, day_of_month)

exclude_list = [
  '.cache',
  '.dropbox',
  '.dropbox-dist',
  '.local/share/gvfs-metadata',
  '.local/share/Trash',
  'Downloads',
  'Dropbox',
  'Pictures/Photos',
  'Music/Music',
  'Video'
]

periodic_backup_list = [
]

# only backup periodic_backup_list on 01 and 15
exclude_list+=periodic_backup_list unless %w{ 01 15 }.include?(day_of_month)

exclude = exclude_list.map { |dir| "--exclude #{dir}" }.join(' ')

cmd = "#{RSYNC_CMD} #{exclude} #{from} #{to}"
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
  file.puts "#{Time.now} - in #{day_of_month} - #{msg}"
end
