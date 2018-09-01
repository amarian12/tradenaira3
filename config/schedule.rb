# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

set :output, "cron/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

env :PATH, ENV['PATH']
env :GEM_PATH, ENV['GEM_PATH']

#every 1.hours do
#  command '/usr/local/rbenv/shims/backup perform -t database_backup'
#end

every :day, at: '4am' do
  rake "solvency:clean"
end

every :day, at: '4:02am' do
  rake "solvency:liability_proof"
end

every :day, at: '4:04am' do
  rake "dailymail:email_sender"
end

every 4.hours do
   rake "admin:cleanup"
end

# Learn more: http://github.com/javan/whenever

# every 1.hours do
#   command '/usr/local/rbenv/shims/backup perform -t database_backup'
# end

# every :day, at: '4am' do
#   rake 'solvency:clean solvency:liability_proof'
# end

# 5 am
# every :day, at: '5:00am' do
#   rake "daemons:stop"
# end
# every :day, at: '5:02am' do
#    rake 'admin:cleanup'
# end
# every :day, at: '5:03am' do
#   rake "daemons:start"
# end


# every :day, at: '5:30am' do
#   rake "daemons:stop"
# end
# every :day, at: '5:32am' do
#    rake 'admin:cleanup'
# end
# every :day, at: '5:33am' do
#   rake "daemons:start"
# end

# # 6 am
# every :day, at: '6:00am' do
#   rake "daemons:stop"
# end
# every :day, at: '6:02am' do
#    rake 'admin:cleanup'
# end
# every :day, at: '6:03am' do
#   rake "daemons:start"
# end

# every :day, at: '6:30am' do
#   rake "daemons:stop"
# end
# every :day, at: '6:32am' do
#    rake 'admin:cleanup'
# end
# every :day, at: '6:33am' do
#   rake "daemons:start"
# end

# # 5 am
# every :day, at: '7:00am' do
#   rake "daemons:stop"
# end
# every :day, at: '7:02am' do
#    rake 'admin:cleanup'
# end
# every :day, at: '7:03am' do
#   rake "daemons:start"
# end

# every :day, at: '7:30am' do
#   rake "daemons:stop"
# end
# every :day, at: '7:32am' do
#    rake 'admin:cleanup'
# end
# every :day, at: '7:33am' do
#   rake "daemons:start"
# end

# #8am
# every :day, at: '8:00am' do
#   rake "daemons:stop"
# end
# every :day, at: '8:02am' do
#    rake 'admin:cleanup'
# end
# every :day, at: '8:03am' do
#   rake "daemons:start"
# end

# every :day, at: '8:30am' do
#   rake "daemons:stop"
# end
# every :day, at: '8:32am' do
#    rake 'admin:cleanup'
# end
# every :day, at: '8:33am' do
#   rake "daemons:start"
# end

# #9am
# every :day, at: '9:00am' do
#   rake "daemons:stop"
# end
# every :day, at: '9:02am' do
#    rake 'admin:cleanup'
# end
# every :day, at: '9:03am' do
#   rake "daemons:start"
# end

# every :day, at: '9:30am' do
#   rake "daemons:stop"
# end
# every :day, at: '9:32am' do
#    rake 'admin:cleanup'
# end
# every :day, at: '9:33am' do
#   rake "daemons:start"
# end

# #10am
# every :day, at: '10:00am' do
#   rake "daemons:stop"
# end
# every :day, at: '10:02am' do
#    rake 'admin:cleanup'
# end
# every :day, at: '10:03am' do
#   rake "daemons:start"
# end

# every :day, at: '10:30am' do
#   rake "daemons:stop"
# end
# every :day, at: '10:32am' do
#    rake 'admin:cleanup'
# end
# every :day, at: '10:33am' do
#   rake "daemons:start"
# end

# #11:00am
# every :day, at: '11:00am' do
#   rake "daemons:stop"
# end
# every :day, at: '11:02am' do
#    rake 'admin:cleanup'
# end
# every :day, at: '11:03am' do
#   rake "daemons:start"
# end

# every :day, at: '11:30am' do
#   rake "daemons:stop"
# end
# every :day, at: '11:32am' do
#    rake 'admin:cleanup'
# end
# every :day, at: '11:33am' do
#   rake "daemons:start"
# end

# #12:00am
# every :day, at: '12:00am' do
#   rake "daemons:stop"
# end
# every :day, at: '12:02am' do
#    rake 'admin:cleanup'
# end
# every :day, at: '12:03am' do
#   rake "daemons:start"
# end

# every :day, at: '12:30am' do
#   rake "daemons:stop"
# end
# every :day, at: '12:32am' do
#    rake 'admin:cleanup'
# end
# every :day, at: '12:33am' do
#   rake "daemons:start"
# end

# #01:00pm
# every :day, at: '01:00pm' do
#   rake "daemons:stop"
# end
# every :day, at: '01:02pm' do
#    rake 'admin:cleanup'
# end
# every :day, at: '01:03pm' do
#   rake "daemons:start"
# end

# every :day, at: '01:30pm' do
#   rake "daemons:stop"
# end
# every :day, at: '01:32pm' do
#    rake 'admin:cleanup'
# end
# every :day, at: '01:33pm' do
#   rake "daemons:start"
# end

# #02:00pm
# every :day, at: '02:00pm' do
#   rake "daemons:stop"
# end
# every :day, at: '02:02pm' do
#    rake 'admin:cleanup'
# end
# every :day, at: '02:03pm' do
#   rake "daemons:start"
# end

# every :day, at: '02:30pm' do
#   rake "daemons:stop"
# end
# every :day, at: '02:32pm' do
#    rake 'admin:cleanup'
# end
# every :day, at: '02:33pm' do
#   rake "daemons:start"
# end


# #3pm
# every :day, at: '3:00pm' do
#   rake "daemons:stop"
# end
# every :day, at: '3:02pm' do
#    rake 'admin:cleanup'
# end
# every :day, at: '3:03pm' do
#   rake "daemons:start"
# end

# every :day, at: '3:30pm' do
#   rake "daemons:stop"
# end
# every :day, at: '3:32pm' do
#    rake 'admin:cleanup'
# end
# every :day, at: '3:33pm' do
#   rake "daemons:start"
# end

# #4pm
# every :day, at: '4:00pm' do
#   rake "daemons:stop"
# end
# every :day, at: '4:02pm' do
#    rake 'admin:cleanup'
# end
# every :day, at: '4:03pm' do
#   rake "daemons:start"
# end

# every :day, at: '4:30pm' do
#   rake "daemons:stop"
# end
# every :day, at: '4:32pm' do
#    rake 'admin:cleanup'
# end
# every :day, at: '4:33pm' do
#   rake "daemons:start"
# end

# #5pm
# every :day, at: '5:00pm' do
#   rake "daemons:stop"
# end
# every :day, at: '5:02pm' do
#    rake 'admin:cleanup'
# end
# every :day, at: '5:03pm' do
#   rake "daemons:start"
# end

# every :day, at: '5:30pm' do
#   rake "daemons:stop"
# end
# every :day, at: '5:32pm' do
#    rake 'admin:cleanup'
# end
# every :day, at: '5:33pm' do
#   rake "daemons:start"
# end

# #6pm
# every :day, at: '6:00pm' do
#   rake "daemons:stop"
# end
# every :day, at: '6:02pm' do
#    rake 'admin:cleanup'
# end
# every :day, at: '6:03pm' do
#   rake "daemons:start"
# end

# every :day, at: '6:30pm' do
#   rake "daemons:stop"
# end
# every :day, at: '6:32pm' do
#    rake 'admin:cleanup'
# end
# every :day, at: '6:33pm' do
#   rake "daemons:start"
# end

# #6pm
# every :day, at: '7:00pm' do
#   rake "daemons:stop"
# end
# every :day, at: '7:02pm' do
#    rake 'admin:cleanup'
# end
# every :day, at: '7:03pm' do
#   rake "daemons:start"
# end

# every :day, at: '7:30pm' do
#   rake "daemons:stop"
# end
# every :day, at: '7:32pm' do
#    rake 'admin:cleanup'
# end
# every :day, at: '7:33pm' do
#   rake "daemons:start"
# end

# #6pm
# every :day, at: '8:00pm' do
#   rake "daemons:stop"
# end
# every :day, at: '8:02pm' do
#    rake 'admin:cleanup'
# end
# every :day, at: '8:03pm' do
#   rake "daemons:start"
# end

# every :day, at: '8:30pm' do
#   rake "daemons:stop"
# end
# every :day, at: '8:32pm' do
#    rake 'admin:cleanup'
# end
# every :day, at: '8:33pm' do
#   rake "daemons:start"
# end

# #6pm
# every :day, at: '9:00pm' do
#   rake "daemons:stop"
# end
# every :day, at: '9:02pm' do
#    rake 'admin:cleanup'
# end
# every :day, at: '9:03pm' do
#   rake "daemons:start"
# end

# every :day, at: '9:30pm' do
#   rake "daemons:stop"
# end
# every :day, at: '9:32pm' do
#    rake 'admin:cleanup'
# end
# every :day, at: '9:33pm' do
#   rake "daemons:start"
# end


# #10pm
# every :day, at: '10:00pm' do
#   rake "daemons:stop"
# end
# every :day, at: '10:02pm' do
#    rake 'admin:cleanup'
# end
# every :day, at: '10:03pm' do
#   rake "daemons:start"
# end

# every :day, at: '10:30pm' do
#   rake "daemons:stop"
# end
# every :day, at: '10:32pm' do
#    rake 'admin:cleanup'
# end
# every :day, at: '10:33pm' do
#   rake "daemons:start"
# end

# #11pm
# every :day, at: '11:00pm' do
#   rake "daemons:stop"
# end
# every :day, at: '11:02pm' do
#    rake 'admin:cleanup'
# end
# every :day, at: '11:03pm' do
#   rake "daemons:start"
# end

# every :day, at: '11:30pm' do
#   rake "daemons:stop"
# end
# every :day, at: '11:32pm' do
#    rake 'admin:cleanup'
# end
# every :day, at: '11:33pm' do
#   rake "daemons:start"
# end

# #10pm
# every :day, at: '12:00pm' do
#   rake "daemons:stop"
# end
# every :day, at: '12:02pm' do
#    rake 'admin:cleanup'
# end
# every :day, at: '12:03pm' do
#   rake "daemons:start"
# end

# every :day, at: '12:30pm' do
#   rake "daemons:stop"
# end
# every :day, at: '12:32pm' do
#    rake 'admin:cleanup'
# end
# every :day, at: '12:33pm' do
#   rake "daemons:start"
# end


# # 1 am
# every :day, at: '1:00am' do
#   rake "daemons:stop"
# end
# every :day, at: '1:02am' do
#    rake 'admin:cleanup'
# end
# every :day, at: '1:03am' do
#   rake "daemons:start"
# end

# every :day, at: '1:30am' do
#   rake "daemons:stop"
# end
# every :day, at: '1:32am' do
#    rake 'admin:cleanup'
# end
# every :day, at: '1:33am' do
#   rake "daemons:start"
# end

# # 2 am
# every :day, at: '2:00am' do
#   rake "daemons:stop"
# end
# every :day, at: '2:02am' do
#    rake 'admin:cleanup'
# end
# every :day, at: '2:03am' do
#   rake "daemons:start"
# end

# every :day, at: '2:30am' do
#   rake "daemons:stop"
# end
# every :day, at: '2:32am' do
#    rake 'admin:cleanup'
# end
# every :day, at: '2:33am' do
#   rake "daemons:start"
# end

# # 3 am
# every :day, at: '3:00am' do
#   rake "daemons:stop"
# end
# every :day, at: '3:02am' do
#    rake 'admin:cleanup'
# end
# every :day, at: '3:03am' do
#   rake "daemons:start"
# end

# every :day, at: '3:30am' do
#   rake "daemons:stop"
# end
# every :day, at: '3:32am' do
#    rake 'admin:cleanup'
# end
# every :day, at: '3:33am' do
#   rake "daemons:start"
# end

# # 4 am
# every :day, at: '4:00am' do
#   rake "daemons:stop"
# end
# every :day, at: '4:02am' do
#    rake 'admin:cleanup'
# end
# every :day, at: '4:03am' do
#   rake "daemons:start"
# end

# every :day, at: '4:30am' do
#   rake "daemons:stop"
# end
# every :day, at: '4:32am' do
#    rake 'admin:cleanup'
# end
# every :day, at: '4:33am' do
#   rake "daemons:start"
# end
