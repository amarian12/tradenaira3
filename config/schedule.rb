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

set :output, "log/cron_log.log"
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

# Learn more: http://github.com/javan/whenever

# every 1.hours do
#   command '/usr/local/rbenv/shims/backup perform -t database_backup'
# end

# every :day, at: '4am' do
#   rake 'solvency:clean solvency:liability_proof'
# end

# 5 am
every :day, at: '5:00am' do
  rake "daemons:stop"
end
every :day, at: '5:02am' do
   rake 'admin:cleanup'
end
every :day, at: '5:03am' do
  rake "daemons:start"
end

#8am
every :day, at: '8:00am' do
  rake "daemons:stop"
end
every :day, at: '8:02am' do
   rake 'admin:cleanup'
end
every :day, at: '8:03am' do
  rake "daemons:start"
end

every :day, at: '11:00am' do
  rake "daemons:stop"
end
every :day, at: '11:02am' do
   rake 'admin:cleanup'
end
every :day, at: '11:03am' do
  rake "daemons:start"
end


#3pm
every :day, at: '3:00pm' do
  rake "daemons:stop"
end
every :day, at: '3:02pm' do
   rake 'admin:cleanup'
end
every :day, at: '3:03pm' do
  rake "daemons:start"
end

#6pm
every :day, at: '6:00pm' do
  rake "daemons:stop"
end
every :day, at: '6:02pm' do
   rake 'admin:cleanup'
end
every :day, at: '6:03pm' do
  rake "daemons:start"
end


#10pm
every :day, at: '10:00pm' do
  rake "daemons:stop"
end
every :day, at: '10:02pm' do
   rake 'admin:cleanup'
end
every :day, at: '10:03pm' do
  rake "daemons:start"
end


# 1 am
every :day, at: '1:00am' do
  rake "daemons:stop"
end
every :day, at: '1:02am' do
   rake 'admin:cleanup'
end
every :day, at: '1:03am' do
  rake "daemons:start"
end
