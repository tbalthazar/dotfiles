#!/usr/bin/env ruby

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

from = ARGV[0]
to = ARGV[1]

# A / was added after folder1 so that only the contents, rather than whole folder, would be moved into the second. 
from+='/' if from[from.length-1]!='/'

cmd = "#{RSYNC_CMD} #{from} #{to}"
system(cmd)
process_status = $?

if process_status.success?
  msg = "Succeeded."
  urgency = "normal"
else
  msg = "Error code : #{process_status.exitstatus}"
  urgency = "critical"
end

system("notify-send 'sync-directories' '#{msg}' -t 10000 -u #{urgency}")
